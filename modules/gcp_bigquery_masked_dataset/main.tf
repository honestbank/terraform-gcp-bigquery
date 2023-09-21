resource "random_id" "random_id" {
  byte_length = 4
}

resource "google_kms_key_ring" "google_kms_key_ring" {
  name     = "${var.name}_${random_id.random_id.hex}"
  location = var.location
}

resource "google_kms_crypto_key" "main_dataset_kms_crypto_key" {
  #checkov:skip=CKV_GCP_82:Need to be able to delete because of integration test
  #checkov:skip=CKV2_GCP_6:Keys are not exported but used in modules
  name            = "${var.name}-${random_id.random_id.hex}"
  key_ring        = google_kms_key_ring.google_kms_key_ring.id
  rotation_period = "7776000s" # 90 days
}

resource "google_kms_crypto_key" "masked_dataset_kms_crypto_key" {
  #checkov:skip=CKV_GCP_82:Need to be able to delete because of integration test
  #checkov:skip=CKV2_GCP_6:Keys are not exported but used in modules
  name            = "${var.name}-masked-${random_id.random_id.hex}"
  key_ring        = google_kms_key_ring.google_kms_key_ring.id
  rotation_period = "7776000s" # 90 days
}

data "google_bigquery_default_service_account" "google_bigquery_default_service_account" {
}

resource "google_kms_crypto_key_iam_member" "main_dataset_kms_crypto_key_iam_member" {
  crypto_key_id = google_kms_crypto_key.main_dataset_kms_crypto_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_bigquery_default_service_account.google_bigquery_default_service_account.email}"
}

resource "google_kms_crypto_key_iam_member" "masked_dataset_kms_crypto_key_iam_member" {
  crypto_key_id = google_kms_crypto_key.masked_dataset_kms_crypto_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_bigquery_default_service_account.google_bigquery_default_service_account.email}"
}

resource "google_bigquery_dataset" "google_bigquery_main_dataset" {
  depends_on = [google_kms_crypto_key_iam_member.main_dataset_kms_crypto_key_iam_member]

  dataset_id    = var.name
  friendly_name = var.name
  description   = var.description
  location      = var.location

  default_encryption_configuration {
    kms_key_name = google_kms_crypto_key.main_dataset_kms_crypto_key.id
  }
}

resource "google_bigquery_dataset" "google_bigquery_masked_dataset" {
  depends_on = [google_kms_crypto_key_iam_member.main_dataset_kms_crypto_key_iam_member]

  dataset_id    = "${var.name}_masked"
  friendly_name = "${var.name}_masked"
  description   = "Collection of PII masked data from ${var.name} dataset"
  location      = var.location

  default_encryption_configuration {
    kms_key_name = google_kms_crypto_key.masked_dataset_kms_crypto_key.id
  }
}
