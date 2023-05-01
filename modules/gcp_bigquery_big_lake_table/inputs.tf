variable "autodetect" {
  type        = bool
  description = "Let BigQuery try to autodetect the schema and format of the table."
}

variable "connection_id" {
  type        = string
  description = "The connection specifying the credentials to be used to read external storage for Big Lake table"
}

variable "dataset_id" {
  type        = string
  description = "A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024 characters."
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
  description = "Source format of table must be NEWLINE_DELIMITED_JSON, AVRO or PARQUET"
  validation {
    condition     = contains(["NEWLINE_DELIMITED_JSON", "AVRO", "PARQUET"], var.source_format)
    error_message = "Source format of table must be NEWLINE_DELIMITED_JSON, AVRO or PARQUET"
  }
}

variable "source_uris" {
  type        = list(string)
  description = "A list of the fully-qualified URIs that point to your data in Google Cloud. https://cloud.google.com/bigquery/docs/external-data-cloud-storage#wildcard-support"
}