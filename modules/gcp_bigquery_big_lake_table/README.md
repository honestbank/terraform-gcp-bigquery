<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.63.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.63.1 |

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
| <a name="input_avro_options_use_avro_logical_types"></a> [avro\_options\_use\_avro\_logical\_types](#input\_avro\_options\_use\_avro\_logical\_types) | If is set to true, indicates whether to interpret logical types as the corresponding BigQuery data type (for example, TIMESTAMP), instead of using the raw type (for example, INTEGER). | `bool` | `true` | no |
| <a name="input_connection_id"></a> [connection\_id](#input\_connection\_id) | The connection specifying the credentials to be used to read external storage for Big Lake table | `string` | n/a | yes |
| <a name="input_csv_options_allow_jagged_rows"></a> [csv\_options\_allow\_jagged\_rows](#input\_csv\_options\_allow\_jagged\_rows) | Indicates if BigQuery should accept rows that are missing trailing optional columns. | `bool` | `true` | no |
| <a name="input_csv_options_allow_quoted_newlines"></a> [csv\_options\_allow\_quoted\_newlines](#input\_csv\_options\_allow\_quoted\_newlines) | Indicates if BigQuery should allow quoted data sections that contain newline characters in a CSV file. The default value is false. | `bool` | `false` | no |
| <a name="input_csv_options_encoding"></a> [csv\_options\_encoding](#input\_csv\_options\_encoding) | The character encoding of the data. The supported values are UTF-8 or ISO-8859-1. | `string` | `"UTF-8"` | no |
| <a name="input_csv_options_field_delimiter"></a> [csv\_options\_field\_delimiter](#input\_csv\_options\_field\_delimiter) | The separator for fields in a CSV file. | `string` | `","` | no |
| <a name="input_csv_options_quote"></a> [csv\_options\_quote](#input\_csv\_options\_quote) | The value that is used to quote data sections in a CSV file. If your data does not contain quoted sections, set the property value to an empty string. If your data contains quoted newline characters, you must also set the allow\_quoted\_newlines property to true. The API-side default is ", specified in Terraform escaped as ". Due to limitations with Terraform default values, this value is required to be explicitly set. | `string` | `"\""` | no |
| <a name="input_csv_options_skip_leading_rows"></a> [csv\_options\_skip\_leading\_rows](#input\_csv\_options\_skip\_leading\_rows) | n/a | `any` | n/a | yes |
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (\_). The maximum length is 1,024 characters. | `string` | n/a | yes |
| <a name="input_dataset_kms_key_name"></a> [dataset\_kms\_key\_name](#input\_dataset\_kms\_key\_name) | The name of the GCP KMS key used by the dataset specified in `var.dataset_id` | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether or not to prevent Terraform from destroying the instance. | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The field description. | `string` | n/a | yes |
| <a name="input_hive_partitioning_mode"></a> [hive\_partitioning\_mode](#input\_hive\_partitioning\_mode) | what mode of hive partitioning to use when reading data. The following modes are supported AUTO, STRINGS, and CUSTOM | `string` | n/a | yes |
| <a name="input_hive_source_uri_prefix"></a> [hive\_source\_uri\_prefix](#input\_hive\_source\_uri\_prefix) | A common for all source uris must be required. The prefix must end immediately before the partition key encoding begins | `string` | n/a | yes |
| <a name="input_json_options_encoding"></a> [json\_options\_encoding](#input\_json\_options\_encoding) | The character encoding of the data. The supported values are UTF-8, UTF-16BE, UTF-16LE, UTF-32BE, and UTF-32LE. The default value is UTF-8. | `string` | `"UTF-8"` | no |
| <a name="input_name"></a> [name](#input\_name) | A table name for the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_parquet_options_enable_list_inference"></a> [parquet\_options\_enable\_list\_inference](#input\_parquet\_options\_enable\_list\_inference) | Indicates whether to use schema inference specifically for Parquet LIST logical type. | `bool` | `false` | no |
| <a name="input_parquet_options_enum_as_string"></a> [parquet\_options\_enum\_as\_string](#input\_parquet\_options\_enum\_as\_string) | Indicates whether to infer Parquet ENUM logical type as STRING instead of BYTES by default. | `bool` | `false` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | A JSON schema for the table. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed. If the API returns a different value for the same schema, e.g. it switched the order of values or replaced STRUCT field type with RECORD field type, we currently cannot suppress the recurring diff this causes. As a workaround, we recommend using the schema as returned by the API. | `string` | `""` | no |
| <a name="input_source_format"></a> [source\_format](#input\_source\_format) | Source data format - AVRO, CSV, JSON, PARQUET currently supported. | `string` | n/a | yes |
| <a name="input_source_uris"></a> [source\_uris](#input\_source\_uris) | A list of the fully-qualified URIs that point to your data in Google Cloud. https://cloud.google.com/bigquery/docs/external-data-cloud-storage#wildcard-support | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The reference ID of the created resource |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The full link into the created resource |
<!-- END_TF_DOCS -->
