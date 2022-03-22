variable "dataset_id" {
  type        = string
  description = "The dataset ID."
}

variable "member" {
  type        = string
  description = "Identities that will be granted the privilege in role. If this is a Google account use user:name@email.com, if this is a service account use serviceAccount:name@project.iam.gserviceaccount.com"
}

variable "role" {
  type        = string
  description = "The role that should be applied. Only one google_bigquery_dataset_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}."
}

variable "customer_managed_key_id" {
  type        = string
  description = "The crypto key ID, in the form {project_id}/{location_name}/{key_ring_name}/{crypto_key_name} or {location_name}/{key_ring_name}/{crypto_key_name}. In the second form, the provider's project setting will be used as a fallback."
}
