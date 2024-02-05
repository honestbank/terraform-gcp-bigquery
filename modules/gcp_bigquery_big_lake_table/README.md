<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_table.google_bigquery_table](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autodetect"></a> [autodetect](#input\_autodetect) | Let BigQuery try to autodetect the schema and format of the table. | `bool` | `true` | no |
| <a name="input_avro_options"></a> [avro\_options](#input\_avro\_options) | Options for AVRO data. | <pre>object(<br>    {<br>      # If is set to true, indicates whether to interpret logical types as the corresponding BigQuery data type<br>      # (for example, TIMESTAMP), instead of using the raw type (for example, INTEGER).<br>      use_avro_logical_types = optional(bool)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_connection_id"></a> [connection\_id](#input\_connection\_id) | The connection specifying the credentials to be used to read external storage for Big Lake table | `string` | n/a | yes |
| <a name="input_csv_options"></a> [csv\_options](#input\_csv\_options) | Options for CSV data. | <pre>object(<br>    {<br>      # Default quote is required, see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table#quote<br>      quote = optional(string, "\"")<br>      #  Indicates if BigQuery should accept rows that are missing trailing optional columns.<br>      allow_jagged_rows = optional(bool)<br>      # Indicates if BigQuery should allow quoted data sections that contain newline characters in a CSV file.<br>      # The default value is false.<br>      allow_quoted_newlines = optional(bool)<br>      #  The character encoding of the data. The supported values are UTF-8 or ISO-8859-1.<br>      encoding = optional(string)<br>      # The separator for fields in a CSV file.<br>      field_delimiter = optional(string)<br>      # The number of rows at the top of a CSV file that BigQuery will skip when reading the data.<br>      skip_leading_rows = optional(number)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (\_). The maximum length is 1,024 characters. | `string` | n/a | yes |
| <a name="input_dataset_kms_key_name"></a> [dataset\_kms\_key\_name](#input\_dataset\_kms\_key\_name) | The name of the GCP KMS key used by the dataset specified in `var.dataset_id` | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether or not to prevent Terraform from destroying the instance. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | The field description. | `string` | n/a | yes |
| <a name="input_hive_partitioning_mode"></a> [hive\_partitioning\_mode](#input\_hive\_partitioning\_mode) | what mode of hive partitioning to use when reading data. The following modes are supported AUTO, CUSTOM, or STRINGS | `string` | `"AUTO"` | no |
| <a name="input_hive_source_uri_prefix"></a> [hive\_source\_uri\_prefix](#input\_hive\_source\_uri\_prefix) | A common for all source uris must be required. The prefix must end immediately before the partition key encoding begins | `string` | n/a | yes |
| <a name="input_json_options"></a> [json\_options](#input\_json\_options) | Options for JSON data. | <pre>object(<br>    {<br>      # The character encoding of the data. The supported values are UTF-8, UTF-16BE, UTF-16LE, UTF-32BE, and UTF-32LE.<br>      # The default value is UTF-8.<br>      encoding = optional(string)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | A table name for the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_parquet_options"></a> [parquet\_options](#input\_parquet\_options) | Options for Parquet data. | <pre>object(<br>    {<br>      # Indicates whether to infer Parquet ENUM logical type as STRING instead of BYTES by default.<br>      enum_as_string = optional(bool)<br>      # Indicates whether to use schema inference specifically for Parquet LIST logical type.<br>      enable_list_inference = optional(bool)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | A JSON schema for the table. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed. If the API returns a different value for the same schema, e.g. it switched the order of values or replaced STRUCT field type with RECORD field type, we currently cannot suppress the recurring diff this causes. As a workaround, we recommend using the schema as returned by the API. | `string` | `""` | no |
| <a name="input_source_compression"></a> [source\_compression](#input\_source\_compression) | Source data compression format. NONE or GZIP. | `string` | `"NONE"` | no |
| <a name="input_source_format"></a> [source\_format](#input\_source\_format) | Source data format - AVRO, CSV, NEWLINE\_DELIMITED\_JSON, PARQUET currently supported. | `string` | `"PARQUET"` | no |
| <a name="input_source_uris"></a> [source\_uris](#input\_source\_uris) | A list of the fully-qualified URIs that point to your data in Google Cloud. https://cloud.google.com/bigquery/docs/external-data-cloud-storage#wildcard-support | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The reference ID of the created resource |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The full link into the created resource |
<!-- END_TF_DOCS -->
