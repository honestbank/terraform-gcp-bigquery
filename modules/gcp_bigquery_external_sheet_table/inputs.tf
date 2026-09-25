variable "dataset_id" {
  type        = string
  description = "A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024 characters."
}

variable "name" {
  type        = string
  description = "A table name for the resource. Changing this forces a new resource to be created."
}

variable "description" {
  type        = string
  description = "The field description."
}

variable "spreadsheet_id" {
  type        = string
  description = "The ID of the Google Sheets spreadsheet, taken from its URL. In `https://docs.google.com/spreadsheets/d/<id>/edit` the ID is the `<id>` segment."

  validation {
    condition     = can(regex("^[A-Za-z0-9_-]{20,}$", var.spreadsheet_id))
    error_message = "spreadsheet_id must be the bare ID from the spreadsheet URL, not the full URL."
  }
}

variable "range" {
  type        = string
  description = "The tab and cell range that BigQuery reads, for example `Engineering!A:Z`, or a named range. Leave it null to read the first tab of the spreadsheet."
  default     = null
}

variable "skip_leading_rows" {
  type        = number
  description = "The number of rows at the top of the range that BigQuery skips. Keep the default of 1 when the first row holds the column headers and `autodetect` is true."
  default     = 1
}

variable "autodetect" {
  type        = bool
  description = "Let BigQuery detect the column names and types from the sheet. Set it to false when you supply `schema`, because the two inputs conflict."
  default     = true
}

variable "schema" {
  type        = string
  description = "A JSON schema for the table. Supply it, and set `autodetect` to false, when the sheet holds columns that BigQuery detects incorrectly. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed."
  default     = ""
}

variable "ignore_unknown_values" {
  type        = bool
  description = "Let BigQuery ignore values that the schema does not cover, instead of a query failure. A spreadsheet often grows extra comment columns, so the default is true."
  default     = true
}

variable "max_bad_records" {
  type        = number
  description = "The number of bad records that BigQuery accepts before a query fails."
  default     = 0
}

variable "deletion_protection" {
  type        = bool
  description = "Whether or not to prevent Terraform from destroying the instance."
  default     = true
}
