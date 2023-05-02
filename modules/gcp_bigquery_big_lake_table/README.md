<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.63.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.63.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_table.google_bigquery_table](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autodetect"></a> [autodetect](#input\_autodetect) | Let BigQuery try to autodetect the schema and format of the table. | `bool` | n/a | yes |
| <a name="input_connection_id"></a> [connection\_id](#input\_connection\_id) | The connection specifying the credentials to be used to read external storage for Big Lake table | `string` | n/a | yes |
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (\_). The maximum length is 1,024 characters. | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether or not to prevent Terraform from destroying the instance. | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The field description. | `string` | n/a | yes |
| <a name="input_hive_partitioning_mode"></a> [hive\_partitioning\_mode](#input\_hive\_partitioning\_mode) | what mode of hive partitioning to use when reading data. The following modes are supported AUTO, STRINGS, and CUSTOM | `string` | n/a | yes |
| <a name="input_hive_source_uri_prefix"></a> [hive\_source\_uri\_prefix](#input\_hive\_source\_uri\_prefix) | A common for all source uris must be required. The prefix must end immediately before the partition key encoding begins | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A table name for the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_schema"></a> [schema](#input\_schema) | A JSON schema for the table. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed. If the API returns a different value for the same schema, e.g. it switched the order of values or replaced STRUCT field type with RECORD field type, we currently cannot suppress the recurring diff this causes. As a workaround, we recommend using the schema as returned by the API. | `string` | `""` | no |
| <a name="input_source_format"></a> [source\_format](#input\_source\_format) | Source format of table must be NEWLINE\_DELIMITED\_JSON, AVRO or PARQUET | `string` | n/a | yes |
| <a name="input_source_uris"></a> [source\_uris](#input\_source\_uris) | A list of the fully-qualified URIs that point to your data in Google Cloud. https://cloud.google.com/bigquery/docs/external-data-cloud-storage#wildcard-support | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The reference ID of the created resource |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The full link into the created resource |
<!-- END_TF_DOCS -->
