output "self_link" {
  description = "The full link into the created resource"
  value       = google_bigquery_table.google_bigquery_table.self_link
}

output "id" {
  description = "The `table_id` of the created resource"
  value       = google_bigquery_table.google_bigquery_table.table_id
}

output "name" {
  description = "A passthrough of the `name` input variable"
  value       = var.name
}
