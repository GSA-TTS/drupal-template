# TTS Drupal Template

This repository aims to simplify the process of getting a `drupal/cms` app running in cloud.gov

> [!IMPORTANT]
> This script is very much a work in progress. All aspects should be independently validated before using.

PRs and ideas for improvement VERY much welcome.

## Bootstrap application and run locally

1. Clone this repository
1. Run `./bootstrap.sh PATH_TO_NEW_DIR`
1. `bootstrap.sh` will finish by presenting you in a `ddev ssh` console
1. At that command line, run `./init.sh`

### Deploy to Cloud.gov

Follow these steps to deploy your app:

1. Go to the directory where you bootstrapped the app (`PATH_TO_NEW_DIR` above)

    ```shell
    cd PATH_TO_NEW_DIR
    ```

1. `cd terraform`
1. `terraform init`
1. `terraform validate`
1. Create a `terraform/terraform.tfvars` file to define the required variables:

    - `cf_org_name` - Organization name on Cloud.gov where Drupal should be deployed
    - `cf_space_name` - Space name on Cloud.gov in `cf_org_name` where Drupal should be deployed. **This space will be created.**
    - `app_name` - Name of deployed Drupal application
    - `cf_users` - List of usernames that can deploy the application within `cf_space_name`

1. `terraform apply` to deploy to your new space

#### Log in to your Drupal site

1. View the root credentials for logging in:

    ```shell
    cf curl "/v3/service_instances/$(terraform output -raw credentials_id)/credentials"
    ```

    Make note of the `ROOT_USER_NAME` and `ROOT_USER_PASS` credentials

1. From `terraform output`, visit the URL in `route`:

    ```shell
    terraform output -raw route
    ```

1. Click the "Log in" button on the page
1. Use the `ROOT_USER_NAME` and `ROOT_USER_PASS` values from the root user credentials to log in

## Disclaimers

This template does not do _many_ things needed for a well-architected federal application. You are responsible for:

1. Updating the terraform modules for proper multiple environment setup and shared backend
1. Implementing egress control for the space
1. CI/CD tests and scans
1. Compliance documentation
1. Proper authentication either through SSO or with MFA
1. etc.
