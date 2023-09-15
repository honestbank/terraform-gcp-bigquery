variable "autodetect" {
  type        = bool
  description = "Let BigQuery try to autodetect the schema and format of the table."
}

variable "avro_options_use_avro_logical_types" {
  default     = true
  description = "If is set to true, indicates whether to interpret logical types as the corresponding BigQuery data type (for example, TIMESTAMP), instead of using the raw type (for example, INTEGER)."
  type        = bool
}

variable "connection_id" {
  type        = string
  description = "The connection specifying the credentials to be used to read external storage for Big Lake table"
}

variable "csv_options_quote" {
  default     = "\""
  description = "The value that is used to quote data sections in a CSV file. If your data does not contain quoted sections, set the property value to an empty string. If your data contains quoted newline characters, you must also set the allow_quoted_newlines property to true. The API-side default is \", specified in Terraform escaped as \". Due to limitations with Terraform default values, this value is required to be explicitly set."
  type        = string
}

variable "csv_options_allow_jagged_rows" {
  default     = true
  description = "Indicates if BigQuery should accept rows that are missing trailing optional columns."
  type        = bool
}

variable "csv_options_allow_quoted_newlines" {
  default     = false
  description = "Indicates if BigQuery should allow quoted data sections that contain newline characters in a CSV file. The default value is false."
  type        = bool
}

variable "csv_options_encoding" {
  default     = "UTF-8"
  description = "The character encoding of the data. The supported values are UTF-8 or ISO-8859-1."
  type        = string
  validation {
    condition     = contains(["UTF-8", "ISO-8859-1"], var.csv_options_encoding)
    error_message = "Only UTF-8 or ISO-8859-1 are supported."
  }
}

variable "csv_options_field_delimiter" {
  default     = ","
  description = "The separator for fields in a CSV file."
  type        = string
}

variable "csv_options_skip_leading_rows" {

}


variable "dataset_id" {
  type        = string
  description = "A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024 characters."
}

variable "dataset_kms_key_name" {
  description = "The name of the GCP KMS key used by the dataset specified in `var.dataset_id`"
  type        = string
}

variable "deletion_protection" {
  type        = bool
  description = "Whether or not to prevent Terraform from destroying the instance."
}

variable "description" {
  type        = string
  description = "The field description."
}

variable "hive_partitioning_mode" {
  type        = string
  description = "what mode of hive partitioning to use when reading data. The following modes are supported AUTO, STRINGS, and CUSTOM"
  validation {
    condition     = contains(["AUTO", "STRINGS", "CUSTOM"], var.hive_partitioning_mode)
    error_message = "Source format of table must be NEWLINE_DELIMITED_JSON, AVRO or PARQUET"
  }
}

variable "hive_source_uri_prefix" {
  type        = string
  description = "A common for all source uris must be required. The prefix must end immediately before the partition key encoding begins"
}

variable "json_options_encoding" {
  default     = "UTF-8"
  description = "The character encoding of the data. The supported values are UTF-8, UTF-16BE, UTF-16LE, UTF-32BE, and UTF-32LE. The default value is UTF-8."
  type        = string
}

variable "name" {
  type        = string
  description = "A table name for the resource. Changing this forces a new resource to be created."
}

variable "parquet_options_enum_as_string" {
  default     = false
  description = "Indicates whether to infer Parquet ENUM logical type as STRING instead of BYTES by default."
  type        = bool
}

variable "parquet_options_enable_list_inference" {
  default     = false
  description = "Indicates whether to use schema inference specifically for Parquet LIST logical type."
  type        = bool
}

variable "schema" {
  type        = string
  description = "A JSON schema for the table. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed. If the API returns a different value for the same schema, e.g. it switched the order of values or replaced STRUCT field type with RECORD field type, we currently cannot suppress the recurring diff this causes. As a workaround, we recommend using the schema as returned by the API."
  default     = ""
}

variable "source_format" {
  type        = string
  description = "Source data format - AVRO, CSV, JSON, PARQUET currently supported."
  validation {
    condition     = contains(["AVRO", "CSV", "NEWLINE_DELIMITED_JSON", "PARQUET"], var.source_format)
    error_message = "Source format of table must be one of AVRO, CSV, JSON, PARQUET."
  }
}

variable "source_uris" {
  type        = list(string)
  description = "A list of the fully-qualified URIs that point to your data in Google Cloud. https://cloud.google.com/bigquery/docs/external-data-cloud-storage#wildcard-support"
}
