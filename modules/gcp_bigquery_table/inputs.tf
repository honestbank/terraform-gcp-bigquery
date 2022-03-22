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

variable "schema" {
  type        = string
  description = "A JSON schema for the table. ~>NOTE: Because this field expects a JSON string, any changes to the string will create a diff, even if the JSON itself hasn't changed. If the API returns a different value for the same schema, e.g. it switched the order of values or replaced STRUCT field type with RECORD field type, we currently cannot suppress the recurring diff this causes. As a workaround, we recommend using the schema as returned by the API."
  default     = ""
}

variable "deletion_protection" {
  type        = bool
  description = "Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply that would delete the instance will fail."
}

variable "customer_managed_key_id" {
  type        = string
  description = "Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table. The BigQuery Service Account associated with your project requires access to this encryption key."
}
