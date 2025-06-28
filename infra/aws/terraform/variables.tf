variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "user_pool_name" {
  description = "The name of the Cognito User Pool"
  type        = string
  default     = "expense-tracker-user-pool"
}

variable "environment" {
  description = "value of the environment"
  type        = string
  default     = "dev"
}

variable "google_client_id" {
  description = "Google Client ID for Cognito Identity Provider"
  type        = string
}

variable "google_client_secret" {
  description = "Google Client Secret for Cognito Identity Provider"
  type        = string
}