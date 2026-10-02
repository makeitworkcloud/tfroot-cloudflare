resource "cloudflare_zero_trust_access_application" "openclaw" {
  account_id       = local.account_id
  name             = "OpenClaw"
  type             = "self_hosted"
  domain           = "openclaw.makeitwork.cloud"
  session_duration = "24h"

  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.github.id,
  ]

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
    }
  ]
}
