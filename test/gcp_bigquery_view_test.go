package test

import (
	"context"
	"os"
	"testing"

	"cloud.google.com/go/bigquery"
	"github.com/gruntwork-io/terratest/modules/terraform"
	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	"google.golang.org/api/option"
)

func TestGCPBigQueryView(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	t.Run("success", func(t *testing.T) {
		t.Parallel()

		options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_view"),
		})

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)

		datasetLink := terraform.Output(t, options, "bigquery_dataset_link")
		assert.NotEmpty(t, terraform.Output(t, options, "bigquery_dataset_id"))
		assert.NotEmpty(t, datasetLink)

		tableID := terraform.Output(t, options, "bigquery_table_id")
		assert.NotEmpty(t, tableID)
		assert.NotEmpty(t, terraform.Output(t, options, "bigquery_table_link"))

		viewID := terraform.Output(t, options, "bigquery_view_id")
		assert.NotEmpty(t, viewID)
		assert.NotEmpty(t, terraform.Output(t, options, "bigquery_view_link"))

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(datasetLink).ProjectID)

		assert.Equal(t, tableID, client.Dataset(datasetLink).Table(tableID).TableID)
		assert.Equal(t, viewID, client.Dataset(datasetLink).Table(viewID).TableID)

		// Ensure no drift on next run
		ensureZeroResourceChange(t, options)
	})
}
