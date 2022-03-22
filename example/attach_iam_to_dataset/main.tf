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

module "create_bigquery_dataset" {
  source = "../../modules/gcp_bigquery_dataset"

  name        = "dataset"
  description = "dataset's description"
  location    = "asia-southeast2"

  owner_email    = google_service_account.owner.email
  google_project = var.google_project
}

resource "google_service_account" "viewer" {
  account_id   = "datasetviewer${random_id.random_id.hex}"
  display_name = "dataset_viewer"
}

module "attach_viewer_to_dataset" {
  source = "../../modules/gcp_bigquery_dataset_iam_policy"

  customer_managed_key_id = module.create_bigquery_dataset.customer_managed_key_id
  dataset_id              = module.create_bigquery_dataset.id
  member                  = "serviceAccount:${google_service_account.viewer.email}"
  role                    = "roles/bigquery.dataViewer"
}

resource "google_service_account" "editor" {
  account_id   = "dataseteditor${random_id.random_id.hex}"
  display_name = "dataset_editor"
}

module "attach_editor_to_dataset" {
  source = "../../modules/gcp_bigquery_dataset_iam_policy"

  customer_managed_key_id = module.create_bigquery_dataset.customer_managed_key_id
  dataset_id              = module.create_bigquery_dataset.id
  member                  = "serviceAccount:${google_service_account.editor.email}"
  role                    = "roles/bigquery.dataEditor"
}
