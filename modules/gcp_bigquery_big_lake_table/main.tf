locals {
  # All possible source formats: https://cloud.google.com/bigquery/docs/reference/rest/v2/tables#externaldataconfiguration
  # Schema disabled source_formats: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table#schema
  schema_disabled_source_formats = ["GOOGLE_SHEETS", "PARQUET", "AVRO", "ORC", "DATASTORE_BACKUP", "BIGTABLE", "NEWLINE_DELIMITED_JSON"]
  source_uris                    = length(var.source_uris) > 0 ? var.source_uris : ["${trim(var.hive_source_uri_prefix, "/")}/*"]
}

resource "google_bigquery_table" "google_bigquery_table" {
  # checkov:skip=CKV_GCP_80:Big Lake Table does not support CSEK. The normal practice is to use the key in GCS bucket.
  dataset_id          = var.dataset_id
  deletion_protection = var.deletion_protection
  description         = var.description
  table_id            = var.name

  # Terraform will detect changes to this property made by BigQuery, but we'll ignore them using the `lifecycle` block.
  schema = (var.schema == "" || var.connection_id == null) ? null : var.schema

  encryption_configuration {
    kms_key_name = var.dataset_kms_key_name
  }

  # Schema disabled configuration, containing AVRO, NEWLINE_DELIMITED_JSON, and Parquet
  dynamic "external_data_configuration" {
    for_each = (contains(local.schema_disabled_source_formats, var.source_format) == true ? toset(["external_data_configuration"]) : toset([]))
    content {
      autodetect    = var.autodetect
      connection_id = var.connection_id
      compression   = var.source_compression
      source_format = var.source_format
      source_uris   = local.source_uris

      dynamic "avro_options" {
        for_each = var.source_format == "AVRO" && var.avro_options != null ? toset(["avro_options"]) : toset([])
        content {
          use_avro_logical_types = var.avro_options.use_avro_logical_types
        }
      }

      dynamic "json_options" {
        for_each = var.source_format == "NEWLINE_DELIMITED_JSON" && var.json_options != null ? toset(["json_options"]) : toset([])
        content {
          encoding = var.json_options.encoding
        }
      }

      dynamic "parquet_options" {
        for_each = var.source_format == "PARQUET" && var.parquet_options != null ? toset(["parquet_options"]) : toset([])
        content {
          enable_list_inference = var.parquet_options.enable_list_inference
          enum_as_string        = var.parquet_options.enum_as_string
        }
      }

      hive_partitioning_options {
        mode              = var.hive_partitioning_mode
        source_uri_prefix = var.hive_source_uri_prefix
      }
    }
  }

  # Schema enabled configuration, containing CSV
  dynamic "external_data_configuration" {
    for_each = (contains(local.schema_disabled_source_formats, var.source_format) == false ? toset(["external_data_configuration"]) : toset([]))
    content {
      autodetect    = var.autodetect
      connection_id = var.connection_id
      compression   = var.source_compression
      source_format = var.source_format
      source_uris   = local.source_uris

      dynamic "csv_options" {
        for_each = var.source_format == "CSV" ? toset(["csv_options"]) : toset([])
        content {
          allow_jagged_rows     = var.csv_options.allow_jagged_rows
          allow_quoted_newlines = var.csv_options.allow_quoted_newlines
          encoding              = var.csv_options.encoding
          field_delimiter       = var.csv_options.field_delimiter
          quote                 = var.csv_options.quote
          skip_leading_rows     = var.csv_options.skip_leading_rows
        }
      }

      # See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table#nested_hive_partitioning_options
      # If you use external_data_configuration documented below and do not set
      # external_data_configuration.connection_id, schemas must be specified with
      # external_data_configuration.schema. Otherwise, schemas must be specified
      # with this top-level field.
      schema = var.connection_id == null ? var.schema : null

      hive_partitioning_options {
        mode              = var.hive_partitioning_mode
        source_uri_prefix = var.hive_source_uri_prefix
      }
    }
  }

  lifecycle {

    # See https://github.com/hashicorp/terraform-provider-google/issues/10919
    ignore_changes = [
      # BigQuery will return the effective schema, which contains differences (e.g. the partition column(s) is added to
      # it). Recreation of the table should only be based on `external_data_configuration.schema`, which is only stored
      # in the Terraform state, not BigQuery. This field contains exactly the input schema and can be used for diffs.
      schema,
    ]
  }
}
