resource "cloudflare_dns_record" "root" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "@"
  content = "makeitwork.cloud.s3-website.us-west-2.amazonaws.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "www" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "www"
  content = "makeitwork.cloud.s3-website.us-west-2.amazonaws.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "mx_primary" {
  zone_id  = local.zone_id
  type     = "MX"
  name     = "@"
  content  = "mx1.privateemail.com"
  priority = 10
  ttl      = 1
}

resource "cloudflare_dns_record" "mx_secondary" {
  zone_id  = local.zone_id
  type     = "MX"
  name     = "@"
  content  = "mx2.privateemail.com"
  priority = 20
  ttl      = 1
}

resource "cloudflare_dns_record" "spf" {
  zone_id = local.zone_id
  type    = "TXT"
  name    = "@"
  content = "v=spf1 include:spf.privateemail.com ~all"
  ttl     = 1
}

# Onion hidden service static site
resource "cloudflare_dns_record" "onion" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "onion"
  content = "onion.makeitwork.cloud.s3-website-us-west-2.amazonaws.com"
  proxied = true
  ttl     = 1
}

# OpenShift cluster records (pointing to ltc for local WARP resolution)
resource "cloudflare_dns_record" "api" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "api"
  content = "ltc.makeitwork.cloud"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "apps" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "apps"
  content = "ltc.makeitwork.cloud"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "apps_wildcard" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "*.apps"
  content = "ltc.makeitwork.cloud"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "openshift_image_registry" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "default-route-openshift-image-registry"
  content = "ltc.makeitwork.cloud"
  proxied = false
  ttl     = 1
}
