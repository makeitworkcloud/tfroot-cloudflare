# Zero Trust / WARP configuration

# Organization settings
resource "cloudflare_zero_trust_organization" "main" {
  account_id  = local.account_id
  name        = "makeitworkcloud.cloudflareaccess.com"
  auth_domain = "makeitworkcloud.cloudflareaccess.com"

  allow_authenticate_via_warp = false
  is_ui_read_only             = false
}

# Email OTP identity provider (existing, imported)
resource "cloudflare_zero_trust_access_identity_provider" "email_otp" {
  account_id = local.account_id
  name       = "Email OTP"
  type       = "onetimepin"

  config = {}
}

# GitHub identity provider for WARP enrollment
resource "cloudflare_zero_trust_access_identity_provider" "github" {
  account_id = local.account_id
  name       = "GitHub"
  type       = "github"

  config = {
    client_id     = local.github_warp_client_id
    client_secret = local.github_warp_client_secret
  }
}

# Access group for makeitworkcloud admins
resource "cloudflare_zero_trust_access_group" "admins" {
  account_id = local.account_id
  name       = "makeitworkcloud-admins"

  include = [{
    github_organization = {
      identity_provider_id = cloudflare_zero_trust_access_identity_provider.github.id
      name                 = "makeitworkcloud"
      team                 = "admins"
    }
  }]
}
