# cloudflare-operator owns the cluster-apps tunnel and all tunnel-host CNAME
# records through ClusterTunnel and TunnelBinding resources in
# kustomize-cluster. This root retains only non-tunnel Cloudflare resources.

resource "cloudflare_zero_trust_tunnel_cloudflared" "warp" {
  account_id = local.account_id
  name       = "warp-connector"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_route" "private_network" {
  account_id = local.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.warp.id
  network    = local.warp_private_network
}
