output "zone_name" {
  description = "Cloudflare zone name"
  value       = data.cloudflare_zone.makeitwork_cloud.name
}
