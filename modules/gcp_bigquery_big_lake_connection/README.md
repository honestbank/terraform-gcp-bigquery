<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.62.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_connection.big_lake_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_id"></a> [connection\_id](#input\_connection\_id) | ID of the BigQuery connection | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description of the BigQuery connection | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | GCP location, e.g. asia-southeast2 | `string` | `"asia-southeast2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The reference ID of the created resource |
| <a name="output_service_account_id"></a> [service\_account\_id](#output\_service\_account\_id) | Build-in service account that is populated after connection has been created |
<!-- END_TF_DOCS -->
