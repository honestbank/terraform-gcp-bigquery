output "id" {
  value = google_bigquery_dataset.google_bigquery_dataset.dataset_id
}

output "self_link" {
  value = google_bigquery_dataset.google_bigquery_dataset.self_link
}

output "customer_managed_key_id" {
  value = google_kms_crypto_key.google_kms_crypto_key.id
}
