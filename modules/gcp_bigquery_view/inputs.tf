variable "dataset_id" {
  type        = string
  description = "The dataset ID to create the view in. Changing this forces a new resource to be created."
}

variable "name" {
  type        = string
  description = "A view name for the resource. Changing this forces a new resource to be created."
}

variable "description" {
  type        = string
  description = "The field description."
}

variable "query" {
  type        = string
  description = "The view query"
}
