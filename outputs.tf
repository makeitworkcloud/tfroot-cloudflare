# Tunnel IDs (safe to expose - needed for kustomize-cluster ConfigMaps)
# NOTE: Tunnel secrets are NOT output here - they are managed via SOPS
# in both this repo (secrets/secrets.yaml) and kustomize-cluster

output "tunnel_ids" {
  description = "Cloudflare Tunnel IDs for reference in kustomize-cluster ConfigMaps"
  value = {
    warp = cloudflare_zero_trust_tunnel_cloudflared.warp.id
  }
}

# Clients send these as CF-Access-Client-Id / CF-Access-Client-Secret headers.
output "mcp_gateway_service_token_client_id" {
  description = "CF-Access-Client-Id for MCP gateway clients"
  value       = cloudflare_zero_trust_access_service_token.mcp_gateway.client_id
}

output "mcp_gateway_service_token_client_secret" {
  description = "CF-Access-Client-Secret for MCP gateway clients"
  value       = cloudflare_zero_trust_access_service_token.mcp_gateway.client_secret
  sensitive   = true
}
