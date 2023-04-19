output "service_account_id" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = google_bigquery_connection.big_lake_connection.cloud_resource[0].service_account_id
}

output "id" {
  description = "The reference ID of the created resource"
  value       = google_bigquery_connection.big_lake_connection.connection_id
}
