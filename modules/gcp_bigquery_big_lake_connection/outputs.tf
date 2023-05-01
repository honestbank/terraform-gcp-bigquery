output "id" {
  description = "The reference ID of the created resource"
  value       = google_bigquery_connection.big_lake_connection.id
}
output "connection_id" {
  description = "The reference ID of the created resource"
  value       = google_bigquery_connection.big_lake_connection.connection_id
}

output "service_account_id" {
  description = "Build-in service account that is populated after connection has been created"
  value       = google_bigquery_connection.big_lake_connection.cloud_resource[0].service_account_id
}
