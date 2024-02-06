# Google BigQuery BigLake Table Example

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.63.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.63.1 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_big_lake_connection"></a> [big\_lake\_connection](#module\_big\_lake\_connection) | ../../modules/gcp_bigquery_big_lake_connection | n/a |
| <a name="module_big_lake_table"></a> [big\_lake\_table](#module\_big\_lake\_table) | ../../modules/gcp_bigquery_big_lake_table | n/a |
| <a name="module_bigquery_dataset"></a> [bigquery\_dataset](#module\_bigquery\_dataset) | ../../modules/gcp_bigquery_dataset | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.big_lake_data_source](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.big_lake_connection_gcs_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_object.dummy_file](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [random_id.big_lake_data_source_random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_data_source_format"></a> [external\_data\_source\_format](#input\_external\_data\_source\_format) | Source format of table must be AVRO, CSV, NEWLINE\_DELIMITED\_JSON, or PARQUET | `string` | `"PARQUET"` | no |
| <a name="input_google_credentials"></a> [google\_credentials](#input\_google\_credentials) | Google Cloud Platform credentials | `string` | n/a | yes |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | Project that dataset will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_big_lake_table_id"></a> [big\_lake\_table\_id](#output\_big\_lake\_table\_id) | n/a |
| <a name="output_big_lake_table_link"></a> [big\_lake\_table\_link](#output\_big\_lake\_table\_link) | n/a |
| <a name="output_bigquery_dataset_id"></a> [bigquery\_dataset\_id](#output\_bigquery\_dataset\_id) | n/a |
| <a name="output_bigquery_dataset_link"></a> [bigquery\_dataset\_link](#output\_bigquery\_dataset\_link) | n/a |
<!-- END_TF_DOCS -->
