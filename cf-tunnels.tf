# The cluster-apps tunnel has a durable lifecycle outside Kubernetes so a
# replacement cluster can reconnect to the same tunnel ID. cloudflare-operator
# owns its local ingress configuration and workload DNS through TunnelBindings.
resource "cloudflare_zero_trust_tunnel_cloudflared" "cluster_apps" {
  account_id = local.account_id
  name       = "cluster-apps-k3s"
  config_src = "local"

  lifecycle {
    prevent_destroy = true
  }
}

import {
  to = cloudflare_zero_trust_tunnel_cloudflared.cluster_apps
  id = "03f750691b4ad4d59aa4b7205adaa108/d17bee03-8687-46a7-831b-df48aacdea1e"
}

locals {
  cluster_bootstrap_hostnames = ["api", "k3s"]
}

resource "cloudflare_dns_record" "cluster_bootstrap" {
  for_each = toset(local.cluster_bootstrap_hostnames)
  zone_id  = local.zone_id
  type     = "CNAME"
  name     = each.value
  content  = "${cloudflare_zero_trust_tunnel_cloudflared.cluster_apps.id}.cfargotunnel.com"
  proxied  = true
  ttl      = 1
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "warp" {
  account_id = local.account_id
  name       = "warp-connector"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_route" "private_network" {
  account_id = local.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.warp.id
  network    = local.warp_private_network
}
