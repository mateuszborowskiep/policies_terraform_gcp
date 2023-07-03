terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "~> 4.0"
      }
    }
}

# Enable the Organization Policy API
resource "google_project_service" "orgpolicy_api" {
  service = "orgpolicy.googleapis.com"
  project = "rosy-crawler-389806"
}

# Define the policy to restrict public IP addresses
resource "google_org_policy_policy" "restrict_public_ips" {
  provider = google-beta
  name = "organizations/494812795773/policies/gcp.RestricPublicIPs"
  parent = "organizations/494812795773"
  depends_on = [
    google_project_service.orgpolicy_api
  ]
    spec {
      rules {
        enforce = "constraints/compute.disableGlobalSerialPortAccess"
      }
    }
  }