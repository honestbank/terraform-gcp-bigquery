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

func TestGCPBigQueryConnection(t *testing.T) {
	projectName := os.Getenv("TF_VAR_google_project")
	credentials := os.Getenv("TF_VAR_google_credentials")

	t.Run("success", func(t *testing.T) {
		t.Parallel()

		options := getOptions(t, testStructure.CopyTerraformFolderToTemp(t, "..", "example/create_cloudsql_connection"))

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)
		// test connection based on terraform output
		connectionReplicaName := terraform.Output(t, options, "sql_database_instance_read_replica_connection_name")
		assert.NotEmpty(t, connectionReplicaName)
		link := terraform.Output(t, options, "bigquery_connection_link")
		assert.NotEmpty(t, link)

		ctx := context.Background()
		client, err := bigquery.NewClient(ctx, projectName, option.WithCredentialsJSON([]byte(credentials)))
		assert.NoError(t, err)

		assert.Equal(t, projectName, client.Dataset(id).ProjectID)
	})
}
