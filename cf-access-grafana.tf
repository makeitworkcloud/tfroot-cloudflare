# Machine access for CI-posted alerts. GitHub Actions workflows POST synthetic
# alerts to Grafana's embedded Alertmanager API (see dependabot-notify.yml in
# shared-workflows). This path-scoped app requires the existing "GitHub
# Actions" service token (the same token_id referenced by the warp app in
# cf-warp.tf); the rest of grafana.makeitwork.cloud is unaffected and stays
# behind Dex OIDC only.
resource "cloudflare_zero_trust_access_application" "grafana_alerts" {
  account_id       = local.account_id
  name             = "Grafana Alerts API"
  type             = "self_hosted"
  domain           = "grafana.makeitwork.cloud/api/alertmanager/grafana"
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
