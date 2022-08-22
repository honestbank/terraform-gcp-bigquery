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

func TestGCPBigQueryMaskedTable(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	t.Run("success", func(t *testing.T) {
		t.Parallel()

		options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testStructure.CopyTerraformFolderToTemp(t, "..", "examples/create_masked_table"),
		})

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)

		datasetID := terraform.Output(t, options, "bigquery_main_dataset_id")
		assert.NotEmpty(t, datasetID)
		maskedDataSetID := terraform.Output(t, options, "bigquery_masked_dataset_id")
		assert.NotEmpty(t, maskedDataSetID)

		tableID := terraform.Output(t, options, "bigquery_table_id")
		assert.NotEmpty(t, tableID)
		viewID := terraform.Output(t, options, "bigquery_view_id")
		assert.NotEmpty(t, viewID)

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(datasetID).ProjectID)
	})
}
