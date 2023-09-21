variable "dataset_id" {
  type        = string
  description = "A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024 characters."
}

variable "name" {
  type        = string
  description = "A table name for the resource. Changing this forces a new resource to be created."
}

variable "dataset_encryption_key_name" {
  description = "The KMS key used to encrypt the dataset specified in var.dataset_id"
  type        = string
}

variable "description" {
  type        = string
  description = "The field description."
}

variable "deletion_protection" {
  type        = bool
  description = "Whether or not to prevent Terraform from destroying the instance."
}

variable "query" {
  type        = string
  description = "A query that BigQuery executes and persist the data in cache"
}
