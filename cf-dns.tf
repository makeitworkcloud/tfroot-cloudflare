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

resource "cloudflare_dns_record" "onion" {
  zone_id = local.zone_id
  type    = "CNAME"
  name    = "onion"
  content = "onion.makeitwork.cloud.s3-website-us-west-2.amazonaws.com"
  proxied = true
  ttl     = 1
}

# xnoto.dev is a separate Cloudflare zone with a public S3 website origin.
# These records do not alter makeitwork.cloud mail, tunnel, or workload DNS.
resource "cloudflare_dns_record" "xnoto_dev_root" {
  zone_id = cloudflare_zone.xnoto_dev.id
  type    = "CNAME"
  name    = "@"
  content = "xnoto.dev.s3-website.us-west-2.amazonaws.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "xnoto_dev_www" {
  zone_id = cloudflare_zone.xnoto_dev.id
  type    = "CNAME"
  name    = "www"
  content = "xnoto.dev.s3-website.us-west-2.amazonaws.com"
  proxied = true
  ttl     = 1
}
