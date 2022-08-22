output "table_id" {
  description = "The full link into the created resource"
  value       = module.table_main.id
}

output "view_id" {
  description = "The reference ID of the created resource"
  value       = module.view_masked.id
}
