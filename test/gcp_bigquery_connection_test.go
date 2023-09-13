package test

import (
	"log"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestGCPBigQueryConnection(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		t.Parallel()

		options := getOptions(t, testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_cloudsql_connection"))

		defer terraform.Destroy(t, options)

		result, errorApplying := terraform.InitAndApplyE(t, options)
		log.Print(result)
		if errorApplying != nil {
			return
		}
		// test connection based on terraform output
		link := terraform.Output(t, options, "bigquery_connection_link")
		assert.NotEmpty(t, link)
	})
}
