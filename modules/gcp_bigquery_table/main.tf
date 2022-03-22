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

resource "google_bigquery_table" "google_bigquery_table" {
  dataset_id          = var.dataset_id
  table_id            = "${var.name}${random_id.random_id.hex}"
  friendly_name       = var.name
  schema              = var.schema
  deletion_protection = var.deletion_protection

  encryption_configuration {
    kms_key_name = var.customer_managed_key_id
  }
}
