resource "cloudflare_zero_trust_access_application" "alertmanager" {
  account_id       = local.account_id
  name             = "Alertmanager API"
  type             = "self_hosted"
  domain           = "alertmanager.makeitwork.cloud"
  session_duration = "24h"

  policies = [
    {
      name     = "GitHub Actions"
      decision = "non_identity"
      include = [{
        service_token = {
          token_id = "635d3164-6e89-4b4b-9812-112b77fdd797"
        }
      }]
    }
  ]
}
