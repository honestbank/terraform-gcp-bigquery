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

resource "random_id" "random_id" {
  byte_length = 4
}

resource "google_kms_key_ring" "google_kms_key_ring" {
  name     = "${var.name}_${random_id.random_id.hex}"
  location = var.location
}

resource "google_kms_crypto_key" "google_kms_crypto_key" {
  #checkov:skip=CKV_GCP_82:Need to be able to delete because of integration test
  name            = "${var.name}_${random_id.random_id.hex}"
  key_ring        = google_kms_key_ring.google_kms_key_ring.id
  rotation_period = "7776000s"
}

resource "time_sleep" "time_sleep" {
  depends_on = [google_kms_crypto_key.google_kms_crypto_key]

  create_duration = "30s"
}

data "google_bigquery_default_service_account" "google_bigquery_default_service_account" {
}

resource "google_kms_crypto_key_iam_member" "google_kms_crypto_key_iam_member" {
  depends_on = [time_sleep.time_sleep]

  crypto_key_id = google_kms_crypto_key.google_kms_crypto_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_bigquery_default_service_account.google_bigquery_default_service_account.email}"
}

resource "google_bigquery_dataset" "google_bigquery_dataset" {
  depends_on = [google_kms_crypto_key_iam_member.google_kms_crypto_key_iam_member]

  dataset_id    = var.name
  friendly_name = var.name
  description   = var.description
  location      = var.location
  access {
    user_by_email = var.owner_email
    role          = "OWNER"
  }

  default_table_expiration_ms = var.default_table_expiration_ms

  default_encryption_configuration {
    kms_key_name = google_kms_crypto_key.google_kms_crypto_key.id
  }
}
