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

func TestGCPBigQueryMaskingDataset(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	t.Run("creates 2 dataset, one for main data and another for masking datasets suffix", func(t *testing.T) {
		t.Parallel()

		options := getOptions(t, testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_masked_dataset"))

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)

		maskedDatasetID := terraform.Output(t, options, "bigquery_masked_dataset_id")
		assert.NotEmpty(t, maskedDatasetID)
		mainDatasetID := terraform.Output(t, options, "bigquery_main_dataset_id")
		assert.NotEmpty(t, mainDatasetID)

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(mainDatasetID).ProjectID)
		assert.Equal(t, projectName, client.Dataset(maskedDatasetID).ProjectID)
	})
}
