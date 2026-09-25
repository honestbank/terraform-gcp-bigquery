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

func TestGCPBigQueryExternalSheetTable(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	// BigQuery reads the spreadsheet over the Drive connector when it detects the schema. The test therefore needs a
	// real spreadsheet that is shared with the test service account. Skip the test when CI does not supply one,
	// because no Terraform resource can create a Google Sheet.
	if os.Getenv("TF_VAR_test_spreadsheet_id") == "" {
		t.Skip("TF_VAR_test_spreadsheet_id is not set; set it to a spreadsheet shared with the test service account")
	}

	t.Run("success", func(t *testing.T) {
		t.Parallel()

		options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_external_sheet_table"),
		})

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)

		datasetID := terraform.Output(t, options, "bigquery_dataset_id")
		assert.NotEmpty(t, datasetID)
		datasetLink := terraform.Output(t, options, "bigquery_dataset_link")
		assert.NotEmpty(t, datasetLink)

		tableID := terraform.Output(t, options, "bigquery_external_sheet_table_id")
		assert.NotEmpty(t, tableID)
		tableLink := terraform.Output(t, options, "bigquery_external_sheet_table_link")
		assert.NotEmpty(t, tableLink)

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(datasetLink).ProjectID)
		assert.Equal(t, tableID, client.Dataset(datasetLink).Table(tableID).TableID)

		metadata, err := client.Dataset(datasetLink).Table(tableID).Metadata(ctx)
		assert.NoError(t, err)
		if assert.NotNil(t, metadata.ExternalDataConfig) {
			assert.Equal(t, bigquery.GoogleSheets, metadata.ExternalDataConfig.SourceFormat)
		}

		// Ensure no drift on next run
		ensureZeroResourceChange(t, options)
	})
}
