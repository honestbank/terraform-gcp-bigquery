terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.13.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.7.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.2"
    }
  }
}

module "crate_bigquery_dataset" {
  source      = "../modules/gcp_bigquery_dataset"
  name        = "dataset"
  description = "dataset's description"
  location    = "asia-southeast2"

  owner_email    = "poc-bigquery@poc-bigquery-343507.iam.gserviceaccount.com"
  google_project = var.google_project
}
