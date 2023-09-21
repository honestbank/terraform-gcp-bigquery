output "id" {
  description = "The `dataset_id` of the created BigQuery Dataset"
  value       = google_bigquery_dataset.google_bigquery_dataset.dataset_id
}

output "self_link" {
  description = "The `self_link` attribute of the created BigQuery Dataset"
  value       = google_bigquery_dataset.google_bigquery_dataset.self_link
}

output "customer_managed_key_id" {
  description = "The `id` attribute of the created KMS crypto key"
  value       = google_kms_crypto_key.google_kms_crypto_key.id
}
