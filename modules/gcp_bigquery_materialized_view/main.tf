terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.13.0"
    }
  }
}

resource "google_bigquery_table" "materialized_view" {
  #checkov:skip=CKV_GCP_80:Cloud KMS based encryption is not supported for views"
  dataset_id          = var.dataset_id
  table_id            = var.name
  schema              = var.schema
  deletion_protection = var.deletion_protection
}
