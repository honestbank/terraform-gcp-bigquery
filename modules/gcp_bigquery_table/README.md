This module is using for create BigQuery table

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
| [google_bigquery_table.google_bigquery_table](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_managed_key_id"></a> [customer\_managed\_key\_id](#input\_customer\_managed\_key\_id) | Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table. The BigQuery Service Account associated with your project requires access to this encryption key. | `string` | n/a | yes |
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (\_). The maximum length is 1,024 characters. | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether or not to prevent Terraform from destroying the instance. | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The field description. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A table name for the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_schema"></a> [schema](#input\_schema) | A JSON schema for the table. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed. If the API returns a different value for the same schema, e.g. it switched the order of values or replaced STRUCT field type with RECORD field type, we currently cannot suppress the recurring diff this causes. As a workaround, we recommend using the schema as returned by the API. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The `table_id` of the created resource |
| <a name="output_name"></a> [name](#output\_name) | A passthrough of the `name` input variable |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The full link into the created resource |
<!-- END_TF_DOCS -->
