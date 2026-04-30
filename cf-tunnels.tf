# Cloudflare Tunnels — connect cloudflared pods to Cloudflare's edge.
#
# The cluster-apps tunnel is created and owned by cloudflare-operator
# (see kustomize-cluster/operators/cloudflare/cluster-tunnel.yaml). Tunnel
# credentials live in the cluster's Secret. CNAME records for the apps
# fronted by that tunnel are managed below.

# Look up the cluster-apps tunnel by name so DNS records can target it
# without hard-coding a UUID that changes if the operator recreates it.
data "cloudflare_zero_trust_tunnel_cloudflared" "cluster_apps" {
  account_id = local.account_id
  filter = {
    name = "cluster-apps-k3s"
  }
}

# Hostnames fronted by the cluster-apps tunnel. The TunnelBinding in
# kustomize-cluster picks up traffic for each FQDN; this CNAME just tells
# Cloudflare's edge which tunnel to route requests through.
locals {
  cluster_apps_hostnames = [
    "argocd",
    "grafana",
    "status",
    "ansible",
  ]
}

resource "cloudflare_dns_record" "cluster_apps" {
  for_each = toset(local.cluster_apps_hostnames)
  zone_id  = local.zone_id
  type     = "CNAME"
  name     = each.value
  content  = "${data.cloudflare_zero_trust_tunnel_cloudflared.cluster_apps.id}.cfargotunnel.com"
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
