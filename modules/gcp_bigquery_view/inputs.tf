variable "dataset_id" {
  type        = string
  description = "The dataset ID to create the view in. Changing this forces a new resource to be created."
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "Whether or not to prevent Terraform from destroying the instance."
}

variable "description" {
  type        = string
  description = "The description of what the view does."
}

variable "name" {
  type        = string
  description = "A view name for the resource. Changing this forces a new resource to be created."
}

variable "query" {
  type        = string
  description = "The view query."
}
