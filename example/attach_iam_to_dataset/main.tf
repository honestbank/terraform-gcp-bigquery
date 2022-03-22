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

// create a google service account to become dataset owner
resource "google_service_account" "owner" {
  account_id   = "datasetowner${random_id.random_id.hex}"
  display_name = "dataset_owner"
}

// creating the BigQuery dataset at Jakarta
module "create_bigquery_dataset" {
  source = "../../modules/gcp_bigquery_dataset"
  // name of the dataset, this will have run number as suffix but the friendly name will be exactly what we set
  name = "dataset"
  // description describe the dataset
  description = "dataset's description"
  // location of the resource which here is Jakarta
  location = "asia-southeast2"
  // email of the owner of the account, can be either user or service account
  owner_email = google_service_account.owner.email
  // indicate the Google project that this resource will be created in
  google_project = var.google_project
}

// create a google service account to become dataset viewer
resource "google_service_account" "viewer" {
  account_id   = "datasetviewer${random_id.random_id.hex}"
  display_name = "dataset_viewer"
}

// attach viewer service account to the dataset
module "attach_viewer_to_dataset" {
  source = "../../modules/gcp_bigquery_dataset_iam_policy"

  // created customer managed key from the dataset
  customer_managed_key_id = module.create_bigquery_dataset.customer_managed_key_id
  // created dataset id that this will attach itself to
  dataset_id = module.create_bigquery_dataset.id
  // service account email in the format user:name@email.com for Google account, and serviceAccount:name@project.iam.gserviceaccount.com for a service account
  member = "serviceAccount:${google_service_account.viewer.email}"
  // the role we that this user will be allowed to do
  role = "roles/bigquery.dataViewer"
}

// create a google service account to become dataset editor
resource "google_service_account" "editor" {
  account_id   = "dataseteditor${random_id.random_id.hex}"
  display_name = "dataset_editor"
}

// attach editor service account to the dataset
module "attach_editor_to_dataset" {
  source = "../../modules/gcp_bigquery_dataset_iam_policy"

  // created customer managed key from the dataset
  customer_managed_key_id = module.create_bigquery_dataset.customer_managed_key_id
  // created dataset id that this will attach itself to
  dataset_id = module.create_bigquery_dataset.id
  // service account email in the format user:name@email.com for Google account, and serviceAccount:name@project.iam.gserviceaccount.com for a service account
  member = "serviceAccount:${google_service_account.editor.email}"
  // the role we that this user will be allowed to do
  role = "roles/bigquery.dataEditor"
}
