# Cloudflare Tunnels for OpenShift workloads
# Tunnels connect cloudflared pods to Cloudflare edge network
#
# The cluster-apps tunnel is managed by cloudflare-operator in OpenShift.
# Tunnel credentials are managed in kustomize-cluster via SOPS/KSOPS.
# DNS records are managed here to point to the consolidated tunnel.

# =============================================================================
# Consolidated HTTP Tunnel (managed by cloudflare-operator)
# =============================================================================

# Consolidated tunnel for all HTTP workloads
# Lifecycle managed by cloudflare-operator ClusterTunnel resource in OpenShift
# Import: tofu import cloudflare_zero_trust_tunnel_cloudflared.cluster_apps 03f750691b4ad4d59aa4b7205adaa108/1ac3a39c-7d97-422e-88e5-1f82b6334bbb
resource "cloudflare_zero_trust_tunnel_cloudflared" "cluster_apps" {
  account_id = local.account_id
  name       = "cluster-apps"

  lifecycle {
    # Tunnel is managed by cloudflare-operator, prevent Terraform from modifying/deleting
    ignore_changes = all
  }
}

# =============================================================================
# DNS Records (pointing to consolidated tunnel)
# =============================================================================

resource "cloudflare_dns_record" "argocd_tunnel" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "argocd"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.cluster_apps.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "grafana_tunnel" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "grafana"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.cluster_apps.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "status_tunnel" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "status"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.cluster_apps.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "ansible_tunnel" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "ansible"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.cluster_apps.id}.cfargotunnel.com"
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
