This module is using for create BigQuery Materialized View (https://cloud.google.com/bigquery/docs/materialized-views-intro)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_table.materialized_view](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dataset_encryption_key_name"></a> [dataset\_encryption\_key\_name](#input\_dataset\_encryption\_key\_name) | The KMS key used to encrypt the dataset specified in var.dataset\_id | `string` | n/a | yes |
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (\_). The maximum length is 1,024 characters. | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether or not to prevent Terraform from destroying the instance. | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The field description. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A table name for the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_query"></a> [query](#input\_query) | A query that BigQuery executes and persist the data in cache | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The `table_id` of the created resource |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The full link into the created resource |
<!-- END_TF_DOCS -->
