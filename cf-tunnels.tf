# Cloudflare Tunnels — connect cloudflared pods to Cloudflare's edge.
#
# The cluster-apps tunnel is created and owned by cloudflare-operator
# (see kustomize-cluster/operators/cloudflare/cluster-tunnel.yaml). Tunnel
# credentials live in the cluster's Secret. DNS records for app endpoints
# are reconciled by TunnelBinding resources, not managed here.

resource "cloudflare_zero_trust_tunnel_cloudflared" "warp" {
  account_id = local.account_id
  name       = "warp-connector"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_route" "private_network" {
  account_id = local.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.warp.id
  network    = local.warp_private_network
}
