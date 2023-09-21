output "main_dataset_id" {
  description = "The `dataset_id` of the main dataset"
  value       = google_bigquery_dataset.google_bigquery_main_dataset.dataset_id
}

output "main_dataset_self_link" {
  description = "The full link into the main dataset"
  value       = google_bigquery_dataset.google_bigquery_main_dataset.self_link
}

output "masked_dataset_id" {
  description = "The `dataset_id` of the masked dataset"
  value       = google_bigquery_dataset.google_bigquery_masked_dataset.dataset_id
}

output "masked_dataset_self_link" {
  description = "The full link into the masked dataset"
  value       = google_bigquery_dataset.google_bigquery_masked_dataset.self_link
}

output "masked_dataset_customer_managed_key_id" {
  description = "The reference ID of the created customer managed key"
  value       = google_kms_crypto_key.masked_dataset_kms_crypto_key.id
}

output "dataset_customer_managed_key_id" {
  description = "The reference ID of the created customer managed key"
  value       = google_kms_crypto_key.main_dataset_kms_crypto_key.id
}
