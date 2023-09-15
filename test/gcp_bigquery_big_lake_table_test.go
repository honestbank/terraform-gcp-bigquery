package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestGCPBigQueryBigLakeTable(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		//options := getOptions(t, testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_big_lake_table"))
		options := getOptions(t, "../examples/gcp_bigquery_big_lake_table")

		defer terraform.Destroy(t, options)

		terraform.InitAndApply(t, options)

		// test connection based on terraform output
		id := terraform.Output(t, options, "big_lake_table_id")
		link := terraform.Output(t, options, "big_lake_table_link")

		assert.NotEmpty(t, id)
		assert.NotEmpty(t, link)

		// Ensure no drift on next run
		ensureZeroResourceChange(t, options)
	})
}
