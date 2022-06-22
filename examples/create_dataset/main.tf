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
  name = "dataset_${random_id.random_id.hex}"
  // description describe the dataset
  description = "dataset's description"
  // location of the resource which here is Jakarta
  location = "asia-southeast2"
  // email of the owner of the account, can be either user or service account
  owner_email = google_service_account.owner.email
  // indicate the Google project that this resource will be created in
  google_project = var.google_project
}
