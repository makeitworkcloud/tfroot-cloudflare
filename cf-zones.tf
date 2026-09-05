resource "cloudflare_zone" "xnoto_dev" {
  account = {
    id = local.account_id
  }
  name = "xnoto.dev"
  type = "full"
}

# The S3 website endpoint supports HTTP only. Cloudflare terminates visitor
# TLS and uses HTTP exclusively for this public, static origin.
resource "cloudflare_zone_setting" "xnoto_dev_ssl" {
  zone_id    = cloudflare_zone.xnoto_dev.id
  setting_id = "ssl"
  value      = "flexible"
}
