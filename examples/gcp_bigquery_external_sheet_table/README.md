# Google BigQuery External Sheet Table Example

This code builds a Google BigQuery dataset and an external table that reads a tab of a Google Sheets spreadsheet.

BigQuery reads the spreadsheet over the Google Drive connector. Two grants are therefore necessary, and neither one
is a Terraform resource:

1. Share the spreadsheet with the service account that applies this code. BigQuery reads the sheet when it detects
   the schema, so the apply fails without that grant.
2. Add the Drive scope to the credentials of every client that queries the table. A query without the Drive scope
   fails with `Access Denied ... Drive credentials`.

## APIs Needed (not comprehensive)

* bigquery.googleapis.com
* cloudkms.googleapis.com
* drive.googleapis.com
* iam.googleapis.com

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.13.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.2 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.2 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_bigquery_dataset"></a> [bigquery\_dataset](#module\_bigquery\_dataset) | ../../modules/gcp_bigquery_dataset | n/a |
| <a name="module_bigquery_external_sheet_table"></a> [bigquery\_external\_sheet\_table](#module\_bigquery\_external\_sheet\_table) | ../../modules/gcp_bigquery_external_sheet_table | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [google_service_account.owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_google_credentials"></a> [google\_credentials](#input\_google\_credentials) | JSON GCP IAM credentials that have GCP Owner and BigQuery Admin Role granted | `string` | n/a | yes |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | Project that dataset will be created | `string` | n/a | yes |
| <a name="input_test_range"></a> [test\_range](#input\_test\_range) | The tab and cell range to read from the test spreadsheet, for example `Sheet1!A:Z`. | `string` | `null` | no |
| <a name="input_test_spreadsheet_id"></a> [test\_spreadsheet\_id](#input\_test\_spreadsheet\_id) | The ID of a Google Sheets spreadsheet that the test service account can read. The spreadsheet must be shared with that service account, because BigQuery reads the sheet when it detects the schema. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bigquery_dataset_id"></a> [bigquery\_dataset\_id](#output\_bigquery\_dataset\_id) | n/a |
| <a name="output_bigquery_dataset_link"></a> [bigquery\_dataset\_link](#output\_bigquery\_dataset\_link) | n/a |
| <a name="output_bigquery_external_sheet_table_id"></a> [bigquery\_external\_sheet\_table\_id](#output\_bigquery\_external\_sheet\_table\_id) | n/a |
| <a name="output_bigquery_external_sheet_table_link"></a> [bigquery\_external\_sheet\_table\_link](#output\_bigquery\_external\_sheet\_table\_link) | n/a |
<!-- END_TF_DOCS -->
