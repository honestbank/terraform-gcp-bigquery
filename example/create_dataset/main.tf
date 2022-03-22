terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.13.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.2"
    }
  }
}

resource "random_id" "random_id" {
  byte_length = 4
}

resource "google_service_account" "owner" {
  account_id   = "datasetowner${random_id.random_id.hex}"
  display_name = "dataset_owner"
}

module "crate_bigquery_dataset" {
  source      = "../../modules/gcp_bigquery_dataset"
  name        = "dataset"
  description = "dataset's description"
  location    = "asia-southeast2"

  owner_email    = google_service_account.owner.email
  google_project = var.google_project
}
