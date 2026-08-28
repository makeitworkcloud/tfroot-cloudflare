# The cluster-apps tunnel is created by cloudflare-operator. This root owns the
# two bootstrap DNS records that provide access to the Kubernetes API before
# cluster workloads can reconcile. Workload tunnel DNS is managed by the
# corresponding TunnelBinding in kustomize-cluster.
data "cloudflare_zero_trust_tunnel_cloudflared" "cluster_apps" {
  account_id = local.account_id
  filter = {
    name = "cluster-apps-k3s"
  }
}

locals {
  cluster_bootstrap_hostnames = ["api", "k3s"]
}

resource "cloudflare_dns_record" "cluster_bootstrap" {
  for_each = toset(local.cluster_bootstrap_hostnames)
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
