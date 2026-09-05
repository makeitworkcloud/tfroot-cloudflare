output "hero_host_config_warp_service_token_client_id" {
  description = "Cloudflare Access service-token client ID for hero-host-config WARP enrollment"
  value       = cloudflare_zero_trust_access_service_token.hero_host_config_warp.client_id
}

output "hero_host_config_warp_service_token_client_secret" {
  description = "Cloudflare Access service-token client secret for hero-host-config WARP enrollment"
  value       = cloudflare_zero_trust_access_service_token.hero_host_config_warp.client_secret
  sensitive   = true
}
