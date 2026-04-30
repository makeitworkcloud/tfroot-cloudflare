# Cloudflare Access application protecting the k3s API server tunnel.
#
# Pairs with the TunnelBinding in kustomize-cluster (workloads/kubectl-tunnel)
# that fronts kubernetes.default.svc:443 over k3s.makeitwork.cloud as a TCP
# tunnel. Clients reach the apiserver via:
#
#   cloudflared access tcp --hostname k3s.makeitwork.cloud --url localhost:6443
#
# `cloudflared access` runs the Access OIDC flow against this app before the
# TCP tunnel opens, so only org admins authenticated via GitHub can connect.
resource "cloudflare_zero_trust_access_application" "k3s" {
  account_id       = local.account_id
  name             = "k3s API"
  type             = "self_hosted"
  domain           = "k3s.makeitwork.cloud"
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
