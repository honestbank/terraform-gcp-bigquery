variable "connection_id" {
  description = "ID of the BigQuery connection"
  type        = string
}

variable "description" {
  description = "Description of the BigQuery connection"
  type        = string
  default     = ""
}

variable "location" {
  description = "GCP location, e.g. asia-southeast2"
  type        = string
  default     = "asia-southeast2"
}
