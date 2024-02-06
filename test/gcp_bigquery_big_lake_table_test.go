package test

import (
	"testing"

	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"

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
		assert.NotEmpty(t, terraform.Output(t, options, "avro_big_lake_table_id"))
		assert.NotEmpty(t, terraform.Output(t, options, "avro_big_lake_table_link"))
		assert.NotEmpty(t, terraform.Output(t, options, "json_big_lake_table_id"))
		assert.NotEmpty(t, terraform.Output(t, options, "json_big_lake_table_link"))
		assert.NotEmpty(t, terraform.Output(t, options, "parquet_big_lake_table_id"))
		assert.NotEmpty(t, terraform.Output(t, options, "parquet_big_lake_table_link"))
		assert.NotEmpty(t, terraform.Output(t, options, "partitioned_csv_big_lake_table_id"))
		assert.NotEmpty(t, terraform.Output(t, options, "partitioned_csv_big_lake_table_link"))

		// Ensure no drift on next run
		ensureZeroResourceChange(t, options)
	})
}
