# Gates mcp.makeitwork.cloud (ToolHive VirtualMCPServer in kustomize-cluster
# workloads/mcp-gateway). MCP clients are headless HTTP agents, so machine
# access uses a dedicated service token (CF-Access-Client-* headers) rather
# than the browser OIDC flow; the admins policy stays for interactive debug.
resource "cloudflare_zero_trust_access_service_token" "mcp_gateway" {
  account_id = local.account_id
  name       = "mcp-gateway"
  # Non-expiring; rotate deliberately by bumping client_secret_version.
  duration = "forever"
}

resource "cloudflare_zero_trust_access_application" "mcp_gateway" {
  account_id       = local.account_id
  name             = "MCP Gateway"
  type             = "self_hosted"
  domain           = "mcp.makeitwork.cloud"
  session_duration = "24h"

  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.github.id,
  ]

  policies = [
    {
      name     = "mcp-gateway-clients"
      decision = "non_identity"
      include = [{
        service_token = {
          token_id = cloudflare_zero_trust_access_service_token.mcp_gateway.id
        }
      }]
    },
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

# Per-backend MCP endpoints (mcp-<name>.makeitwork.cloud) terminate on the
# same toolhive proxyrunners behind the same tunnel. One application per FQDN:
# Access domains cannot wildcard a name prefix, and first-level names are
# required anyway because Universal SSL only covers one subdomain level.
#
# This list controls Access applications only. Tunnel DNS is exclusively owned
# by TunnelBinding resources in kustomize-cluster.
locals {
  mcp_backends = [
    "makeitwork-apify",
    "makeitwork-argocd",
    "makeitwork-aws-docs",
    "makeitwork-context7",
    "makeitwork-github",
    "makeitwork-github-xnoto",
    "makeitwork-grafana",
    "makeitwork-kubernetes",
    "makeitwork-parallel-search",
    "makeitwork-terraform-docs",
  ]
}

resource "cloudflare_zero_trust_access_application" "mcp_gateway_backend" {
  for_each         = toset(local.mcp_backends)
  account_id       = local.account_id
  name             = "MCP ${each.key}"
  type             = "self_hosted"
  domain           = "mcp-${each.key}.makeitwork.cloud"
  session_duration = "24h"

  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.github.id,
  ]

  policies = [
    {
      name     = "mcp-gateway-clients"
      decision = "non_identity"
      include = [{
        service_token = {
          token_id = cloudflare_zero_trust_access_service_token.mcp_gateway.id
        }
      }]
    },
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
