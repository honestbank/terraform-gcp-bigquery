locals {
  # All possible source formats: https://cloud.google.com/bigquery/docs/reference/rest/v2/tables#externaldataconfiguration
  # Schema disabled source_formats: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table#schema
  schema_disabled_source_formats = ["GOOGLE_SHEETS", "PARQUET", "AVRO", "ORC", "DATASTORE_BACKUP", "BIGTABLE"]
}

resource "google_bigquery_table" "google_bigquery_table" {
  # checkov:skip=CKV_GCP_80:Big Lake Table does not support CSEK. The normal practice is to use the key in GCS bucket.
  dataset_id          = var.dataset_id
  deletion_protection = var.deletion_protection
  description         = var.description
  table_id            = var.name

  # Terraform will detect changes to this property made by BigQuery, but we'll ignore them using the `lifecycle` block.
  schema = var.schema

  encryption_configuration {
    kms_key_name = var.dataset_kms_key_name
  }

  # AVRO - Schema disabled
  dynamic "external_data_configuration" {
    for_each = (var.source_format == "AVRO" ? toset(["external_data_configuration_avro"]) : toset([]))

    content {
      autodetect    = var.autodetect
      connection_id = var.connection_id
      source_format = var.source_format
      source_uris   = var.source_uris

      avro_options {
        use_avro_logical_types = var.avro_options_use_avro_logical_types
      }

      hive_partitioning_options {
        mode              = var.hive_partitioning_mode
        source_uri_prefix = var.hive_source_uri_prefix
      }
    }
  }

  # CSV - Schema allowed
  dynamic "external_data_configuration" {
    for_each = (var.source_format == "CSV" ? toset(["external_data_configuration_csv"]) : toset([]))
    content {
      autodetect    = var.autodetect
      connection_id = var.connection_id
      source_format = var.source_format
      source_uris   = var.source_uris

      # Use the exact same schema here. This one won't be changed by BigQuery, however Terraform will still detect
      # intentional changes to this field.
      schema = var.schema

      csv_options {
        quote                 = var.csv_options_quote
        allow_jagged_rows     = var.csv_options_allow_jagged_rows
        allow_quoted_newlines = var.csv_options_allow_quoted_newlines
        encoding              = var.csv_options_encoding
        field_delimiter       = var.csv_options_field_delimiter
        skip_leading_rows     = var.csv_options_skip_leading_rows
      }

      hive_partitioning_options {
        mode              = var.hive_partitioning_mode
        source_uri_prefix = var.hive_source_uri_prefix
      }
    }
  }

  # JSON - Schema allowed
  dynamic "external_data_configuration" {
    for_each = (var.source_format == "NEWLINE_DELIMITED_JSON" ? toset(["external_data_configuration_json"]) : toset([]))
    content {
      autodetect    = var.autodetect
      connection_id = var.connection_id
      source_format = var.source_format
      source_uris   = var.source_uris

      # Use the exact same schema here. This one won't be changed by BigQuery, however Terraform will still detect
      # intentional changes to this field.
      schema = var.schema

      json_options {
        encoding = var.json_options_encoding
      }

      hive_partitioning_options {
        mode              = var.hive_partitioning_mode
        source_uri_prefix = var.hive_source_uri_prefix
      }
    }
  }

  # Parquet - Schema disabled
  dynamic "external_data_configuration" {
    for_each = (var.source_format == "PARQUET" ? toset(["external_data_configuration_parquet"]) : toset([]))

    content {
      autodetect    = var.autodetect
      connection_id = var.connection_id
      source_format = var.source_format
      source_uris   = var.source_uris

      parquet_options {
        enum_as_string        = var.parquet_options_enum_as_string
        enable_list_inference = var.parquet_options_enable_list_inference
      }

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
