variable "cf_org_name" {
  type        = string
  description = "Organization name on Cloud.gov where Drupal should be deployed"
}

variable "cf_space_name" {
  type        = string
  description = "Space name on Cloud.gov in `cf_org_name` where Drupal should be deployed. **This space will be created.**"
}

variable "app_name" {
  type        = string
  description = "Drupal application name"
}

variable "cf_users" {
  type        = set(string)
  description = "Set of Cloud.gov usernames that can deploy the application"
}

variable "allow_ssh" {
  type        = bool
  description = "flag to allow ssh into cg_space_name"
  default     = false
}

variable "rds_plan_name" {
  type        = string
  default     = "small-mysql"
  description = "The rds plan to provision for the app"
}

variable "s3_plan_name" {
  type        = string
  default     = "basic-sandbox"
  description = "The s3 plan to provision for the app"
}
