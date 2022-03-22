# Terraform GCP BigQuery component module

This Terraform component module provide utility to create

* BigQuery dataset and attach dataset IAM
* BigQuery table with predefined JSON schema

The user of this component need to provide google credentials with permissions
* Owner for creating - because we need to be able to create customer managed key and BigQuery dataset
* BigQuery Admin - to create BigQuery table inside the dataset, GCP need this permission

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
