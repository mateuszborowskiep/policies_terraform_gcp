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

module "disableGlobalSerialPortAccess" {
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

module "restrictTLSVersion" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.2.2"
  policy_for        = "project"
  project_id        = "rosy-crawler-389806"
  constraint        = "constraints/gcp.restrictTLSVersion"
  policy_type       = "list"
  organization_id   = "	494812795773"
  deny             = ["TLS_VERSION_1", "TLS_VERSION_1_1"]
  deny_list_length = 2
  //exclude_folders   = ["folders/folder-1-id", "folders/folder-2-id"]
  //exclude_projects  = ["project3", "project4"]
}

module "publicAccessPrevention" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.2.2"
  policy_for        = "project"
  project_id        = "rosy-crawler-389806"
  constraint        = "constraints/storage.publicAccessPrevention"
  policy_type       = "boolean"
  organization_id   = "494812795773"
  enforce           = true
}

module "resourceLocations" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.2.2"
  policy_for        = "project"
  project_id        = "rosy-crawler-389806"
  constraint        = "constraints/gcp.resourceLocations"
  policy_type       = "list"
  organization_id   = "494812795773"
  allow            = ["ZONE:europe-west1"]
  allow_list_length = 1
}

module "sqlrestrictPublicIp" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.2.2"
  policy_for        = "project"
  project_id        = "rosy-crawler-389806"
  constraint        = "constraints/sql.restrictPublicIp"
  policy_type       = "boolean"
  organization_id   = "494812795773"
  enforce           = true
}