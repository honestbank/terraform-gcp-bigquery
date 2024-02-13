package test

import (
	"testing"

	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/honestbank/terraform-gcp-bigquery/test_util/options"
)

func TestGCPBigQueryBigLakeTable(t *testing.T) {
	formatToTableName := map[string]string{
		"AVRO":                   "avro_big_lake_table",
		"CSV":                    "csv_big_lake_table",
		"NEWLINE_DELIMITED_JSON": "jsonl_big_lake_table",
		"PARQUET":                "parquet_big_lake_table",
	}

	for format, tableName := range formatToTableName {
		t.Run(tableName, func(t *testing.T) {
			terraformDir := testStructure.CopyTerraformFolderToTemp(t, "..", "examples/gcp_bigquery_big_lake_table")
			opt := options.NewTerraformOptionsBuilder(t, terraformDir).
				WithInputVariables("external_data_source_format", format).
				Build()

			defer terraform.Destroy(t, opt)

			terraform.InitAndApply(t, opt)

			// test connection based on terraform output
			assert.NotEmpty(t, terraform.Output(t, opt, "big_lake_table_id"))
			assert.NotEmpty(t, terraform.Output(t, opt, "big_lake_table_link"))

			// Ensure no drift on next run
			ensureZeroResourceChange(t, opt)
		})
	}
}
