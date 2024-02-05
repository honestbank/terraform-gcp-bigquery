variable "autodetect" {
  type        = bool
  description = "Let BigQuery try to autodetect the schema and format of the table."
  default     = true
}

variable "source_compression" {
  type        = string
  description = "Source data compression format. NONE or GZIP."
  validation {
    condition     = contains(["NONE", "GZIP"], var.source_compression)
    error_message = "source_compression can only be NONE or GZIP"
  }
  default = "NONE"
}

variable "connection_id" {
  type        = string
  description = "The connection specifying the credentials to be used to read external storage for Big Lake table"
}

variable "avro_options" {
  type = object(
    {
      # If is set to true, indicates whether to interpret logical types as the corresponding BigQuery data type
      # (for example, TIMESTAMP), instead of using the raw type (for example, INTEGER).
      use_avro_logical_types = optional(bool)
    }
  )
  default     = null
  description = "Options for AVRO data."
}

variable "csv_options" {
  type = object(
    {
      # Default quote is required, see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table#quote
      quote = optional(string, "\"")
      #  Indicates if BigQuery should accept rows that are missing trailing optional columns.
      allow_jagged_rows = optional(bool)
      # Indicates if BigQuery should allow quoted data sections that contain newline characters in a CSV file.
      # The default value is false.
      allow_quoted_newlines = optional(bool)
      #  The character encoding of the data. The supported values are UTF-8 or ISO-8859-1.
      encoding = optional(string)
      # The separator for fields in a CSV file.
      field_delimiter = optional(string)
      # The number of rows at the top of a CSV file that BigQuery will skip when reading the data.
      skip_leading_rows = optional(number)
    }
  )
  default     = null
  description = "Options for CSV data."
}

variable "json_options" {
  type = object(
    {
      # The character encoding of the data. The supported values are UTF-8, UTF-16BE, UTF-16LE, UTF-32BE, and UTF-32LE.
      # The default value is UTF-8.
      encoding = optional(string)
    }
  )
  default     = null
  description = "Options for JSON data."
}

variable "parquet_options" {
  type = object(
    {
      # Indicates whether to infer Parquet ENUM logical type as STRING instead of BYTES by default.
      enum_as_string = optional(bool)
      # Indicates whether to use schema inference specifically for Parquet LIST logical type.
      enable_list_inference = optional(bool)
    }
  )
  default     = null
  description = "Options for Parquet data."
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
  default     = false
}

variable "description" {
  type        = string
  description = "The field description."
}

variable "hive_partitioning_mode" {
  type        = string
  description = "what mode of hive partitioning to use when reading data. The following modes are supported AUTO, CUSTOM, or STRINGS"
  validation {
    condition     = contains(["AUTO", "CUSTOM", "STRINGS"], var.hive_partitioning_mode)
    error_message = "Hive partitioning mod must be AUTO, CUSTOM, or STRINGS"
  }
  default = "AUTO"
}

variable "hive_source_uri_prefix" {
  type        = string
  description = "A common for all source uris must be required. The prefix must end immediately before the partition key encoding begins"
  validation {
    condition     = !endswith(var.hive_source_uri_prefix, "*")
    error_message = "hive_source_uri_prefix should not end with an `*`"
  }
}

variable "name" {
  type        = string
  description = "A table name for the resource. Changing this forces a new resource to be created."
}

variable "schema" {
  type        = string
  description = "A JSON schema for the table. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed. If the API returns a different value for the same schema, e.g. it switched the order of values or replaced STRUCT field type with RECORD field type, we currently cannot suppress the recurring diff this causes. As a workaround, we recommend using the schema as returned by the API."
  default     = ""
}

variable "source_format" {
  type        = string
  description = "Source data format - AVRO, CSV, NEWLINE_DELIMITED_JSON, PARQUET currently supported."
  validation {
    condition     = contains(["AVRO", "CSV", "NEWLINE_DELIMITED_JSON", "PARQUET"], var.source_format)
    error_message = "Source format of table must be one of AVRO, CSV, NEWLINE_DELIMITED_JSON, PARQUET."
  }
  default = "PARQUET"
}

variable "source_uris" {
  type        = list(string)
  description = "A list of the fully-qualified URIs that point to your data in Google Cloud. https://cloud.google.com/bigquery/docs/external-data-cloud-storage#wildcard-support"
  default     = []
}
