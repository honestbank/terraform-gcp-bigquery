# [Required] The data format.
# For AVRO files, specify "AVRO".
# For CSV files, specify "CSV".
# For newline-delimited JSON, specify "NEWLINE_DELIMITED_JSON".
# For Parquet files, specify "PARQUET".
# Source: https://cloud.google.com/bigquery/docs/reference/rest/v2/tables#externaldataconfiguration
# Supported source_formats: https://cloud.google.com/bigquery/docs/reference/rest/v2/tables#externaldataconfiguration
variable "external_data_source_format" {
  default     = "PARQUET"
  description = "Source format of table must be AVRO, CSV, NEWLINE_DELIMITED_JSON, or PARQUET"
  type        = string
  validation {
    condition     = contains(["AVRO", "CSV", "NEWLINE_DELIMITED_JSON", "PARQUET"], var.external_data_source_format)
    error_message = "Source format of table must be AVRO, CSV, NEWLINE_DELIMITED_JSON, or PARQUET"
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
