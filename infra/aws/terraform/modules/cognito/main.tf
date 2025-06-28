variable "user_pool_name" { type = string }
variable "environment" { type = string }
variable "google_client_id" { type = string }
variable "google_client_secret" { type = string }
variable "callback_urls" { type = list(string) }
variable "logout_urls" { type = list(string) }

resource "aws_cognito_user_pool" "main" {
  name = "${var.user_pool_name}-${var.environment}"

  username_attributes = ["email"]
  mfa_configuration   = "OFF"

  account_recovery_setting {
    recovery_mechanism {
      priority = 1
      name     = "verified_email"
    }
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = false
    required            = true
  }

  schema {
    name                = "name"
    attribute_data_type = "String"
    mutable             = true
    required            = true
  }

  schema {
    name                = "picture"
    attribute_data_type = "String"
    mutable             = true
    required            = false
  }
}

resource "aws_cognito_identity_provider" "google" {
  user_pool_id  = aws_cognito_user_pool.main.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    client_id        = var.google_client_id
    client_secret    = var.google_client_secret
    authorize_scopes = "email profile openid"
  }

  attribute_mapping = {
    email   = "email"
    name    = "name"
    picture = "picture"
  }
}

resource "aws_cognito_user_pool_client" "webapp" {
  name         = "${var.user_pool_name}-webapp-client"
  user_pool_id = aws_cognito_user_pool.main.id

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  supported_identity_providers         = ["Google"]

  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  depends_on = [aws_cognito_identity_provider.google]
}

output "user_pool_id" {
  value = aws_cognito_user_pool.main.id
}
output "user_pool_webapp_client_id" {
  value = aws_cognito_user_pool_client.webapp.id
}
