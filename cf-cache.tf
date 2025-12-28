# Zone-level cache and performance settings
# Import commands (replace $ZONE_ID with cloudflare_zone_id from secrets):
#   tofu import cloudflare_zone_setting.cache_level $ZONE_ID/cache_level
#   tofu import cloudflare_zone_setting.browser_cache_ttl $ZONE_ID/browser_cache_ttl
#   tofu import cloudflare_zone_setting.browser_check $ZONE_ID/browser_check
#   tofu import cloudflare_zone_setting.challenge_ttl $ZONE_ID/challenge_ttl
#   tofu import cloudflare_zone_setting.minify $ZONE_ID/minify

resource "cloudflare_zone_setting" "cache_level" {
  zone_id    = local.zone_id
  setting_id = "cache_level"
  value      = "aggressive"
}

resource "cloudflare_zone_setting" "browser_cache_ttl" {
  zone_id    = local.zone_id
  setting_id = "browser_cache_ttl"
  value      = 14400
}

resource "cloudflare_zone_setting" "browser_check" {
  zone_id    = local.zone_id
  setting_id = "browser_check"
  value      = "on"
}

resource "cloudflare_zone_setting" "challenge_ttl" {
  zone_id    = local.zone_id
  setting_id = "challenge_ttl"
  value      = 1800
}

resource "cloudflare_zone_setting" "minify" {
  zone_id    = local.zone_id
  setting_id = "minify"
  value = {
    css  = "off"
    html = "off"
    js   = "off"
  }
}
