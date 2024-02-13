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

func TestGCPBigQueryDatasetIAM(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	t.Run("success", func(t *testing.T) {
		t.Parallel()

		terraformDir := testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_dataset_iam_policy")
		opt := options.NewTerraformOptionsBuilder(t, terraformDir).Build()

		defer terraform.Destroy(t, opt)

		terraform.InitAndApply(t, opt)

		id := terraform.Output(t, opt, "bigquery_dataset_id")
		assert.NotEmpty(t, id)
		link := terraform.Output(t, opt, "bigquery_dataset_link")
		assert.NotEmpty(t, link)

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(id).ProjectID)

		// Ensure no drift on next run
		ensureZeroResourceChange(t, opt)
	})
}
