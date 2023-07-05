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

module "org-policy" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.2.2"
  policy_for        = "project"
  project_id        = "rosy-crawler-389806"
  constraint        = "constraints/compute.disableGlobalSerialPortAccess"
  policy_type       = "boolean"
  organization_id   = "	494812795773"
  enforce           = true
  //exclude_folders   = ["folders/folder-1-id", "folders/folder-2-id"]
  //exclude_projects  = ["project3", "project4"]
}