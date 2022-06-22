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

func getOptions(t *testing.T, directory string) *terraform.Options {
	return terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: directory,
	})
}

func TestGCPBigQueryDataset(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	t.Run("success", func(t *testing.T) {
		t.Parallel()

		options := getOptions(t, testStructure.CopyTerraformFolderToTemp(t, "..", "examples/create_dataset"))

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)

		id := terraform.Output(t, options, "bigquery_dataset_id")
		assert.NotEmpty(t, id)
		link := terraform.Output(t, options, "bigquery_dataset_link")
		assert.NotEmpty(t, link)

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(id).ProjectID)
	})
}
