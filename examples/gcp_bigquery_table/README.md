# Google BigQuery Table Example

This code builds a Google BigQuery table and all supporting entities including encryption keys.

## APIs Needed (not comprehensive)

* cloudkms.googleapis.com
* iam.googleapis.com

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.13.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bigquery_dataset"></a> [bigquery\_dataset](#module\_bigquery\_dataset) | ../../modules/gcp_bigquery_dataset | n/a |
| <a name="module_bigquery_table_1"></a> [bigquery\_table\_1](#module\_bigquery\_table\_1) | ../../modules/gcp_bigquery_table | n/a |
| <a name="module_bigquery_table_2"></a> [bigquery\_table\_2](#module\_bigquery\_table\_2) | ../../modules/gcp_bigquery_table | n/a |
| <a name="module_bigquery_table_2_materialized_view"></a> [bigquery\_table\_2\_materialized\_view](#module\_bigquery\_table\_2\_materialized\_view) | ../../modules/gcp_bigquery_materialized_view | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/3.1.2/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_credentials"></a> [google\_credentials](#input\_google\_credentials) | JSON GCP IAM credentials that have GCP Owner and BigQuery Admin Role granted | `string` | n/a | yes |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | Project that dataset will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bigquery_dataset_id"></a> [bigquery\_dataset\_id](#output\_bigquery\_dataset\_id) | n/a |
| <a name="output_bigquery_dataset_link"></a> [bigquery\_dataset\_link](#output\_bigquery\_dataset\_link) | n/a |
| <a name="output_bigquery_table_1_id"></a> [bigquery\_table\_1\_id](#output\_bigquery\_table\_1\_id) | n/a |
| <a name="output_bigquery_table_1_link"></a> [bigquery\_table\_1\_link](#output\_bigquery\_table\_1\_link) | n/a |
| <a name="output_bigquery_table_2_id"></a> [bigquery\_table\_2\_id](#output\_bigquery\_table\_2\_id) | n/a |
| <a name="output_bigquery_table_2_link"></a> [bigquery\_table\_2\_link](#output\_bigquery\_table\_2\_link) | n/a |
<!-- END_TF_DOCS -->
