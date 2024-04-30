variable "google_project" {
  type        = string
  default     = null
  description = "GCP project name that this dataset will be creating in. Defaults to Google provider project"
}

variable "name" {
  type        = string
  description = "A descriptive name for the dataset"
}

variable "description" {
  type        = string
  description = "A user-friendly description of the dataset"
}

variable "location" {
  type        = string
  description = "The geographic location where the dataset should reside. See official docs. \nThere are two types of locations, regional or multi-regional. A regional location is a specific geographic place, such as Tokyo, and a multi-regional location is a large geographic area, such as the United States, that contains at least two geographic places. \nThe default value is multi-regional location US. Changing this forces a new resource to be created."
}

variable "owner_email" {
  type        = string
  description = "An email address of a user to grant access to. For example bigquery@bigquery-prod-343507.iam.gserviceaccount.com"
}
