variable "cf_org_name" {
  type        = string
  description = "cloud.gov organization name"
}

variable "cf_space_name" {
  type        = string
  description = "cloud.gov space name for app deployment"
}

variable "app_name" {
  type        = string
  description = "Drupal application name"
}

variable "cf_users" {
  type        = set(string)
  description = "Set of cloud.gov usernames that can deploy the application"
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
