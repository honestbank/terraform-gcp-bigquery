terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.13.0"
    }
  }
}

resource "google_bigquery_table" "google_bigquery_table" {
  dataset_id          = var.dataset_id
  table_id            = var.name
  schema              = var.schema
  deletion_protection = var.deletion_protection

  encryption_configuration {
    kms_key_name = var.customer_managed_key_id
  }

  dynamic "materialized_view" {
    for_each = var.materialized_view
    content {
      query = materialized_view.value["query"]
    }
  }

  dynamic "view" {
    for_each = var.view
    content {
      query = view.value["query"]
    }
  }
}
