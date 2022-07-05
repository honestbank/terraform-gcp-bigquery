variable "google_project" {
  type        = string
  description = "GCP project name that this dataset will be creating in."
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

variable "default_table_expiration_ms" {
  type        = number
  description = "The default lifetime of all tables in the dataset, in milliseconds. The minimum value is 3600000 milliseconds (one hour). Once this property is set, all newly-created tables in the dataset will have an expirationTime property set to the creation time plus the value in this property, and changing the value will only affect new tables, not existing ones. When the expirationTime for a given table is reached, that table will be deleted automatically. If a table's expirationTime is modified or removed before the table expires, or if you provide an explicit expirationTime when creating a table, that value takes precedence over the default expiration time indicated by this property"
}
