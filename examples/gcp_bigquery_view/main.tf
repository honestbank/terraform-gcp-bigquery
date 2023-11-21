terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.13.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.2"
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

module "bigquery_dataset" {
  source         = "../../modules/gcp_bigquery_dataset"
  name           = "dataset_${random_id.random_id.hex}"
  description    = "Used for testing gcp_bigquery_view"
  location       = "asia-southeast2"
  owner_email    = google_service_account.owner.email
  google_project = var.google_project
}

module "bigquery_table" {
  #checkov:skip=CKV_GCP_121:Deletion protection is not needed for test resources.
  source                  = "../../modules/gcp_bigquery_table"
  dataset_id              = module.bigquery_dataset.id
  name                    = "staff"
  description             = "Used for testing gcp_bigquery_view"
  deletion_protection     = false
  schema                  = <<EOF
[
  {
    "mode": "REQUIRED",
    "name": "id",
    "type": "INTEGER"
  },
  {
    "mode": "REQUIRED",
    "name": "department",
    "type": "STRING"
  }
]
EOF
  customer_managed_key_id = module.bigquery_dataset.customer_managed_key_id
}

module "bigquery_view" {
  source = "../../modules/gcp_bigquery_view"

  dataset_id  = module.bigquery_dataset.id
  name        = "view"
  description = "Used for testing gcp_bigquery_view"
  query       = "SELECT * FROM ${module.bigquery_dataset.id}.${module.bigquery_table.id} WHERE department='engineering'"
}
