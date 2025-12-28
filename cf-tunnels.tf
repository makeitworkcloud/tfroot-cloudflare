# Cloudflare Tunnels for OpenShift workloads
# Tunnels connect cloudflared pods to Cloudflare edge network
#
# Tunnel credentials are managed separately in kustomize-cluster via SOPS/KSOPS.

# =============================================================================
# HTTP Tunnels (ingress-based)
# =============================================================================

# ArgoCD tunnel
resource "cloudflare_zero_trust_tunnel_cloudflared" "argocd" {
  account_id = local.account_id
  name       = "argocd"
}

resource "cloudflare_dns_record" "argocd_tunnel" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "argocd"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.argocd.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

# Grafana tunnel
resource "cloudflare_zero_trust_tunnel_cloudflared" "grafana" {
  account_id = local.account_id
  name       = "grafana"
}

resource "cloudflare_dns_record" "grafana_tunnel" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "grafana"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.grafana.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

# Uptime Kuma tunnel (status.makeitwork.cloud)
resource "cloudflare_zero_trust_tunnel_cloudflared" "uptime_kuma" {
  account_id = local.account_id
  name       = "uptime-kuma"
}

resource "cloudflare_dns_record" "status_tunnel" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "status"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.uptime_kuma.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

# AWX tunnel (ansible.makeitwork.cloud)
resource "cloudflare_zero_trust_tunnel_cloudflared" "awx" {
  account_id = local.account_id
  name       = "awx"
}

resource "cloudflare_dns_record" "ansible_tunnel" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "ansible"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.awx.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

# =============================================================================
# WARP Connector (IP routing for Zero Trust VPN)
# =============================================================================

resource "cloudflare_zero_trust_tunnel_cloudflared" "warp" {
  account_id = local.account_id
  name       = "warp-connector"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_route" "private_network" {
  account_id = local.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.warp.id
  network    = local.warp_private_network
}
