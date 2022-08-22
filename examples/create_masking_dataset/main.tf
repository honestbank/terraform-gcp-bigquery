variable "google_project" {
  type        = string
  description = "Project that dataset will be created"
}

resource "google_service_account" "owner" {
  account_id   = "datasetowner"
  display_name = "dataset_owner"
}

module "masked_dataset" {
  source         = "../../modules/gcp_bigquery_masking_dataset"
  description    = "description of the dataset"
  google_project = var.google_project
  location       = "asia-southeast2"
  name           = "dataset_name"
  owner_email    = google_service_account.owner.email
}
