output "self_link" {
  description = "The full link into the created resource"
  value       = google_bigquery_table.materialized_view.self_link
}

output "id" {
  description = "The reference ID of the created resource"
  value       = google_bigquery_table.materialized_view.table_id
}
