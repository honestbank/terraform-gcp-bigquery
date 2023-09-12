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
  deletion_protection = var.deletion_protection

  materialized_view {
    query = var.query
  }

  # This 'encryption_configuration' block is required to prevent drift, even though a view holds no data. If omitted,
  # the materialized view will still inherit the key used by the dataset and shows up as a diff in the Terraform plan,
  # resulting in Terraform forcing a replacement.
  encryption_configuration {
    kms_key_name = var.dataset_encryption_key_name
  }
}
