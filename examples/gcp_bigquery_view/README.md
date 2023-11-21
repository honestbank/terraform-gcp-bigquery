# Google BigQuery Table Example

This code builds a Google BigQuery table and all supporting entities including encryption keys.

## APIs Needed (not comprehensive)

* cloudkms.googleapis.com
* iam.googleapis.com

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.13.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bigquery_dataset"></a> [bigquery\_dataset](#module\_bigquery\_dataset) | ../../modules/gcp_bigquery_dataset | n/a |
| <a name="module_bigquery_table"></a> [bigquery\_table](#module\_bigquery\_table) | ../../modules/gcp_bigquery_table | n/a |
| <a name="module_bigquery_view"></a> [bigquery\_view](#module\_bigquery\_view) | ../../modules/gcp_bigquery_view | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_credentials"></a> [google\_credentials](#input\_google\_credentials) | Service account credentials for provisioning and asserting test resources | `string` | n/a | yes |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | Project where the test resources will be provisioned | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bigquery_dataset_id"></a> [bigquery\_dataset\_id](#output\_bigquery\_dataset\_id) | n/a |
| <a name="output_bigquery_dataset_link"></a> [bigquery\_dataset\_link](#output\_bigquery\_dataset\_link) | n/a |
| <a name="output_bigquery_table_id"></a> [bigquery\_table\_id](#output\_bigquery\_table\_id) | n/a |
| <a name="output_bigquery_table_link"></a> [bigquery\_table\_link](#output\_bigquery\_table\_link) | n/a |
| <a name="output_bigquery_view_id"></a> [bigquery\_view\_id](#output\_bigquery\_view\_id) | n/a |
| <a name="output_bigquery_view_link"></a> [bigquery\_view\_link](#output\_bigquery\_view\_link) | n/a |
<!-- END_TF_DOCS -->
