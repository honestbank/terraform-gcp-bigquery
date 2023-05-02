terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.63.1"
    }
  }
}

resource "google_bigquery_table" "google_bigquery_table" {
  # checkov:skip=CKV_GCP_80:Big Lake Table does not support CSEK. The normal practice is to use the key in GCS bucket.
  dataset_id          = var.dataset_id
  deletion_protection = var.deletion_protection
  description         = var.description
  schema              = var.schema
  table_id            = var.name

  external_data_configuration {
    autodetect    = var.autodetect
    connection_id = var.connection_id
    source_format = var.source_format
    source_uris   = var.source_uris

    hive_partitioning_options {
      mode              = var.hive_partitioning_mode
      source_uri_prefix = var.hive_source_uri_prefix
    }
  }
}
