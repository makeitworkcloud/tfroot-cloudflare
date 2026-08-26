# OpenCode can execute commands against its mounted workspace. Require the
# existing GitHub-backed admins group before traffic reaches the origin.
resource "cloudflare_zero_trust_access_application" "opencode" {
  account_id       = local.account_id
  name             = "OpenCode"
  type             = "self_hosted"
  domain           = "opencode.makeitwork.cloud"
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
