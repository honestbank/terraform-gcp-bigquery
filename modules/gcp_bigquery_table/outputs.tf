output "self_link" {
  description = "The full link into the created resource"
  value       = google_bigquery_table.google_bigquery_table.self_link
}

output "id" {
  description = "The reference ID of the created resource"
  value       = google_bigquery_table.google_bigquery_table.table_id
}

output "name" {
  value = var.name
}
