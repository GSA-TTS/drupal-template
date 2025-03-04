# create a cloud.gov space to host the app and services
module "space" {
  source = "github.com/gsa-tts/terraform-cloudgov//cg_space?ref=v2.2.0"

  cf_org_name          = var.cf_org_name
  cf_space_name        = var.cf_space_name
  deployers            = var.cf_users
  allow_ssh            = var.allow_ssh
  security_group_names = ["trusted_local_networks_egress", "public_networks_egress"]
}

# provision a database, s3 bucket, and deploy the application
module "drupal" {
  source = "github.com/gsa-tts/terraform-cloudgov//drupal?ref=v2.2.0"

  cf_org_name   = var.cf_org_name
  cf_space      = module.space.space
  name          = var.app_name
  app_memory    = "512M"
  source_dir    = "${path.root}/.."
  rds_plan_name = var.rds_plan_name
  s3_plan_name  = var.s3_plan_name

  app_environment = {
    SITE_RECIPE = ""
  }

  depends_on = [module.space]
}
