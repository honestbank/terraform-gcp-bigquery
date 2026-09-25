This module creates a BigQuery external table that reads a tab of a Google Sheets spreadsheet.

The table holds no data. BigQuery reads the spreadsheet over the Google Drive connector on every query, so the sheet
stays the single source of truth. Two grants are necessary, and neither one is a Terraform resource:

1. Share the spreadsheet with the service account that applies this module. BigQuery reads the sheet when it detects
   the schema, so the apply fails without that grant.
2. Add the Drive scope to the credentials of every client that queries the table. A query without the Drive scope
   fails with `Access Denied ... Drive credentials`.

An external Sheets table cannot hold a customer-managed encryption key, so this module sets no
`encryption_configuration` block. The sheet stays under Google Drive encryption.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_bigquery_table.google_bigquery_table](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_autodetect"></a> [autodetect](#input\_autodetect) | Let BigQuery detect the column names and types from the sheet. Set it to false when you supply `schema`, because the two inputs conflict. | `bool` | `true` | no |
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (\_). The maximum length is 1,024 characters. | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether or not to prevent Terraform from destroying the instance. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The field description. | `string` | n/a | yes |
| <a name="input_ignore_unknown_values"></a> [ignore\_unknown\_values](#input\_ignore\_unknown\_values) | Let BigQuery ignore values that the schema does not cover, instead of a query failure. A spreadsheet often grows extra comment columns, so the default is true. | `bool` | `true` | no |
| <a name="input_max_bad_records"></a> [max\_bad\_records](#input\_max\_bad\_records) | The number of bad records that BigQuery accepts before a query fails. | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | A table name for the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_range"></a> [range](#input\_range) | The tab and cell range that BigQuery reads, for example `Engineering!A:Z`, or a named range. Leave it null to read the first tab of the spreadsheet. | `string` | `null` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | A JSON schema for the table. Supply it, and set `autodetect` to false, when the sheet holds columns that BigQuery detects incorrectly. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed. | `string` | `""` | no |
| <a name="input_skip_leading_rows"></a> [skip\_leading\_rows](#input\_skip\_leading\_rows) | The number of rows at the top of the range that BigQuery skips. Keep the default of 1 when the first row holds the column headers and `autodetect` is true. | `number` | `1` | no |
| <a name="input_spreadsheet_id"></a> [spreadsheet\_id](#input\_spreadsheet\_id) | The ID of the Google Sheets spreadsheet, taken from its URL. In `https://docs.google.com/spreadsheets/d/<id>/edit` the ID is the `<id>` segment. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The reference ID of the created resource |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The full link into the created resource |
<!-- END_TF_DOCS -->