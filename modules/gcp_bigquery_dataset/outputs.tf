output "id" {
  description = "The `dataset_id` of the created resource"
  value       = google_bigquery_dataset.google_bigquery_dataset.dataset_id
}

output "self_link" {
  description = "The full link into the created resource"
  value       = google_bigquery_dataset.google_bigquery_dataset.self_link
}

output "customer_managed_key_id" {
  description = "The reference ID of the created customer managed key"
  value       = google_kms_crypto_key.google_kms_crypto_key.id
}
