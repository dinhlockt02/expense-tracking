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

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be either 'dev', 'stage'  or 'prod'."
  }
}

variable "google_client_id" {
  description = "Google Client ID for Cognito Identity Provider"
  type        = string
  sensitive   = true
}

variable "google_client_secret" {
  description = "Google Client Secret for Cognito Identity Provider"
  type        = string
  sensitive   = true
}

variable "callback_urls" {
  description = "List of allowed callback URLs for Cognito"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

variable "logout_urls" {
  description = "List of allowed logout URLs for Cognito"
  type        = list(string)
  default     = ["http://localhost:3000"]
}
