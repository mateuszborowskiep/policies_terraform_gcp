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
  name = "projects/rosy-crawler-389806/policies/gcp.RestricPublicIPs"
  parent = "projects/rosy-crawler-389806"
  depends_on = [
    google_project_service.orgpolicy_api
  ]
    spec {
      rules {
        enforce = "constraints/compute.disableGlobalSerialPortAccess"
      }
    }
  }