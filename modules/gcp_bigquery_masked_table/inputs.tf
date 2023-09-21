variable "name" {
  type        = string
  description = "A table name for the resource. Changing this forces a new resource to be created."
}

variable "description" {
  type        = string
  description = "The field description."
}

variable "deletion_protection" {
  type        = bool
  description = "Whether or not to prevent Terraform from destroying the instance."
}

variable "schema" {
  type = list(object({ name : string, type : string, pii : bool, mode : string }))
}

variable "table_dataset_customer_managed_key_id" {
  type        = string
  description = "Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table. The BigQuery Service Account associated with your project requires access to this encryption key."
}

variable "table_dataset_id" {
  type        = string
  description = "ID of the dataset on which the tables should be created"
}

variable "view_dataset_customer_managed_key_id" {
  type        = string
  description = "Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table. The BigQuery Service Account associated with your project requires access to this encryption key."
}

variable "view_dataset_id" {
  type        = string
  description = "ID of the dataset on which view should be created"
}
