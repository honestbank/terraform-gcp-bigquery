variable "google_project" {
  type        = string
  description = "Project where the test resources will be provisioned"
}

variable "google_credentials" {
  type        = string
  description = "Service account credentials for provisioning and asserting test resources"
}
