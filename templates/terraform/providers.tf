terraform {
  required_version = "~> 1.10"
  required_providers {
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = ">=1.3.0"
    }
  }
}

# no-config will pull authentication from cf-cli@8's credential file
# useful to avoid having to create service accounts
# use ENV vars to configure with a service account in CI/CD
provider "cloudfoundry" {}
