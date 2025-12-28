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

# WARP enrollment application
resource "cloudflare_zero_trust_access_application" "warp" {
  account_id       = local.account_id
  name             = "Warp Login App"
  type             = "warp"
  session_duration = "24h"

  # Allow all configured identity providers
  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.email_otp.id,
    cloudflare_zero_trust_access_identity_provider.github.id,
  ]

  # Policies managed by Terraform (will replace existing manual policies)
  policies = [
    {
      name             = "makeitworkcloud-admins"
      decision         = "allow"
      session_duration = "24h"
      include = [{
        group = {
          id = cloudflare_zero_trust_access_group.admins.id
        }
      }]
    },
    {
      name             = "steven@makeitwork.cloud"
      decision         = "allow"
      session_duration = "24h"
      include = [{
        email = {
          email = "steven@makeitwork.cloud"
        }
      }]
    },
    {
      name             = "GitHub Actions"
      decision         = "non_identity"
      session_duration = "24h"
      include = [{
        service_token = {
          token_id = "635d3164-6e89-4b4b-9812-112b77fdd797"
        }
      }]
    }
  ]
}
