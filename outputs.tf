# Tunnel IDs (safe to expose - needed for kustomize-cluster ConfigMaps)
# NOTE: Tunnel secrets are NOT output here - they are managed via SOPS
# in both this repo (secrets/secrets.yaml) and kustomize-cluster

output "tunnel_ids" {
  description = "Cloudflare Tunnel IDs for reference in kustomize-cluster ConfigMaps"
  value = {
    cluster_apps = cloudflare_zero_trust_tunnel_cloudflared.cluster_apps.id
    warp         = cloudflare_zero_trust_tunnel_cloudflared.warp.id
  }
}
