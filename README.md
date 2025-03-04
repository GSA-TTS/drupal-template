TTS Drupal Template
===================

This repository aims to simplify the process of getting a `drupal/cms` app running in cloud.gov

> [!IMPORTANT]
> This script is very much a work in progress. All aspects should be independently validated before using.

PRs and ideas for improvement VERY much welcome.

## Usage

1. Clone this repository
1. Run `./bootstrap.sh PATH_TO_NEW_DIR`
1. `bootstrap.sh` will finish by presenting you in a `ddev ssh` console
1. At that command line, run `./init.sh`
1. Use terraform to deploy your app

### Terraform deploy

Follow these steps (starting from within your app directory) to deploy your app

1. `cd terraform`
1. `terraform init`
1. `terraform validate`
1. Create a `terraform/vars.auto.tfvars` file to define the required variables
1. `terraform apply` to deploy to your new space

## Disclaimers

This template does not do _many_ things needed for a well-architected federal application. You are responsible for:

1. Updating the terraform modules for proper multiple environment setup and shared backend
1. Implementing egress control for the space
1. CI/CD tests and scans
1. Compliance documentation
1. Proper authentication either through SSO or with MFA
1. etc.
