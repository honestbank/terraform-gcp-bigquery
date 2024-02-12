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

	"github.com/honestbank/terraform-gcp-bigquery/test_util/options"
)

func TestGCPBigQueryMaskingDataset(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	t.Run("creates 2 dataset, one for main data and another for masking datasets suffix", func(t *testing.T) {
		t.Parallel()

		terraformDir := testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_masked_dataset")
		opt := options.NewTerraformOptionsBuilder(t, terraformDir).Build()

		defer terraform.Destroy(t, opt)

		terraform.InitAndApply(t, opt)

		maskedDatasetID := terraform.Output(t, opt, "bigquery_masked_dataset_id")
		assert.NotEmpty(t, maskedDatasetID)
		mainDatasetID := terraform.Output(t, opt, "bigquery_main_dataset_id")
		assert.NotEmpty(t, mainDatasetID)

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(mainDatasetID).ProjectID)
		assert.Equal(t, projectName, client.Dataset(maskedDatasetID).ProjectID)

		// Ensure no drift on next run
		ensureZeroResourceChange(t, opt)
	})
}
