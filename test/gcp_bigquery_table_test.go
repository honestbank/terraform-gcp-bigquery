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

func TestGCPBigQueryTable(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	t.Run("success", func(t *testing.T) {
		t.Parallel()

		options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testStructure.CopyTerraformFolderToTemp(t, "..", "examples/create_table"),
		})

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)

		datasetID := terraform.Output(t, options, "bigquery_dataset_id")
		assert.NotEmpty(t, datasetID)
		datasetLink := terraform.Output(t, options, "bigquery_dataset_link")
		assert.NotEmpty(t, datasetLink)

		table1ID := terraform.Output(t, options, "bigquery_table_1_id")
		assert.NotEmpty(t, datasetID)
		table2ID := terraform.Output(t, options, "bigquery_table_2_id")
		assert.NotEmpty(t, datasetLink)

		table1Link := terraform.Output(t, options, "bigquery_table_1_link")
		assert.NotEmpty(t, table1Link)
		table2Link := terraform.Output(t, options, "bigquery_table_2_link")
		assert.NotEmpty(t, table2Link)

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(datasetLink).ProjectID)

		assert.Equal(t, table1ID, client.Dataset(datasetLink).Table(table1ID).TableID)
		assert.Equal(t, table2ID, client.Dataset(datasetLink).Table(table2ID).TableID)
	})
}
