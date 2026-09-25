variable "google_project" {
  type        = string
  description = "Project that dataset will be created"
}

variable "google_credentials" {
  type        = string
  description = "JSON GCP IAM credentials that have GCP Owner and BigQuery Admin Role granted"
}

variable "test_spreadsheet_id" {
  type        = string
  description = "The ID of a Google Sheets spreadsheet that the test service account can read. The spreadsheet must be shared with that service account, because BigQuery reads the sheet when it detects the schema."
}

variable "test_range" {
  type        = string
  description = "The tab and cell range to read from the test spreadsheet, for example `Sheet1!A:Z`."
  default     = null
}
