terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.7.2"
    }
  }
}

locals {
  schema             = [for item in var.schema : { name : item.name, type : item.type, mode : item.mode }]
  non_pii_columns    = [for item in var.schema : item.name if !item.pii]
  hashed_pii_columns = [for item in var.schema : "SHA512(${item.name}) AS ${item.name}" if item.pii]
}

module "table_main" {
  source                  = "../gcp_bigquery_table"
  customer_managed_key_id = var.customer_managed_key_id
  dataset_id              = var.table_dataset_id
  deletion_protection     = var.deletion_protection
  description             = var.description
  name                    = var.name
  schema                  = jsonencode(local.schema)
}

resource "time_sleep" "wait_for_table" {
  create_duration = "60s"
  depends_on      = [module.table_main]
}

module "view_masked" {
  source              = "../gcp_bigquery_materialized_view"
  dataset_id          = var.view_dataset_id
  deletion_protection = var.deletion_protection
  description         = "Materialized view with PII data masked from ${var.name} table in ${var.table_dataset_id} dataset"
  name                = "${var.name}_view_masked"
  query               = <<EOF
SELECT
${join(",\n", concat(local.non_pii_columns, local.hashed_pii_columns))}
FROM ${var.table_dataset_id}.${module.table_main.name}
EOF
  depends_on = [
    time_sleep.wait_for_table
  ]
}
