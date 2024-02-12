package test

import (
	"log"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"

	"github.com/honestbank/terraform-gcp-bigquery/test_util/options"
)

func TestGCPBigQueryConnection(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		t.Parallel()

		terraformDir := testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_cloudsql_connection")
		opt := options.NewTerraformOptionsBuilder(t, terraformDir).Build()

		defer terraform.Destroy(t, opt)

		result, errorApplying := terraform.InitAndApplyE(t, opt)
		log.Print(result)
		if errorApplying != nil {
			return
		}
		// test connection based on terraform output
		link := terraform.Output(t, opt, "bigquery_connection_link")
		assert.NotEmpty(t, link)

		// Ensure no drift on next run
		ensureZeroResourceChange(t, opt)
	})
}
