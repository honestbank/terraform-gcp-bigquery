# Google BigQuery Masked Table Example

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
| <a name="module_bigquery_dataset"></a> [bigquery\_dataset](#module\_bigquery\_dataset) | ../../modules/gcp_bigquery_masked_dataset | n/a |
| <a name="module_bigquery_masked_table"></a> [bigquery\_masked\_table](#module\_bigquery\_masked\_table) | ../../modules/gcp_bigquery_masked_table | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.dataset_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_credentials"></a> [google\_credentials](#input\_google\_credentials) | JSON GCP IAM credentials that have GCP Owner and BigQuery Admin Role granted | `string` | n/a | yes |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | Project that dataset will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bigquery_main_dataset_id"></a> [bigquery\_main\_dataset\_id](#output\_bigquery\_main\_dataset\_id) | n/a |
| <a name="output_bigquery_masked_dataset_id"></a> [bigquery\_masked\_dataset\_id](#output\_bigquery\_masked\_dataset\_id) | n/a |
| <a name="output_bigquery_table_id"></a> [bigquery\_table\_id](#output\_bigquery\_table\_id) | n/a |
| <a name="output_bigquery_view_id"></a> [bigquery\_view\_id](#output\_bigquery\_view\_id) | n/a |
<!-- END_TF_DOCS -->
