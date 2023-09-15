resource "google_bigquery_dataset_iam_member" "google_bigquery_dataset_iam_member" {
  dataset_id = var.dataset_id
  role       = var.role
  member     = var.member
}

resource "google_kms_crypto_key_iam_member" "google_kms_crypto_key_iam_member" {
  crypto_key_id = var.customer_managed_key_id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = var.member
}
