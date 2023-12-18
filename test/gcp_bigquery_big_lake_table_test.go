package test

import (
	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestGCPBigQueryBigLakeTable(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		t.Parallel()

		options := getOptions(t, testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_big_lake_table"))

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)

		// test connection based on terraform output
		id := terraform.Output(t, options, "big_lake_table_id")
		link := terraform.Output(t, options, "big_lake_table_link")

		assert.NotEmpty(t, id)
		assert.NotEmpty(t, link)
		assert.NotEmpty(t, terraform.Output(t, options, "partitioned_csv_big_lake_table_id"))

		// Ensure no drift on next run
		ensureZeroResourceChange(t, options)
	})
}
