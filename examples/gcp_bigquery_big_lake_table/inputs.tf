# [Required] The data format.
# For CSV files, specify "CSV".
# For Google sheets, specify "GOOGLE_SHEETS".
# For newline-delimited JSON, specify "NEWLINE_DELIMITED_JSON".
# For Avro files, specify "AVRO".
# For Google Cloud Datastore backups, specify "DATASTORE_BACKUP".
# For Apache Iceberg tables, specify "ICEBERG".
# For ORC files, specify "ORC".
# For Parquet files, specify "PARQUET".
# [Beta] For Google Cloud Bigtable, specify "BIGTABLE".
# Source: https://cloud.google.com/bigquery/docs/reference/rest/v2/tables#externaldataconfiguration

variable "external_data_source_format" {
  default     = "PARQUET"
  description = "Source format of table must be NEWLINE_DELIMITED_JSON, AVRO or PARQUET"
  type        = string
  validation {
    condition     = contains(["AVRO", "CSV", "NEWLINE_DELIMITED_JSON", "PARQUET"], var.external_data_source_format)
    error_message = "Source format of table must be NEWLINE_DELIMITED_JSON, AVRO or PARQUET"
  }
}

variable "google_credentials" {
  type        = string
  description = "Google Cloud Platform credentials"
}

variable "google_project" {
  type        = string
  description = "Project that dataset will be created"
}
