module "cognito" {
  source               = "./modules/cognito"
  user_pool_name       = var.user_pool_name
  environment          = var.environment
  google_client_id     = var.google_client_id
  google_client_secret = var.google_client_secret
  callback_urls        = var.callback_urls
  logout_urls          = var.logout_urls
}
