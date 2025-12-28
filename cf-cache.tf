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
    css  = "on"
    html = "on"
    js   = "off"
  }
}

resource "cloudflare_zone_setting" "brotli" {
  zone_id    = local.zone_id
  setting_id = "brotli"
  value      = "on"
}

resource "cloudflare_zone_setting" "early_hints" {
  zone_id    = local.zone_id
  setting_id = "early_hints"
  value      = "on"
}

resource "cloudflare_zone_setting" "rocket_loader" {
  zone_id    = local.zone_id
  setting_id = "rocket_loader"
  value      = "off"
}

resource "cloudflare_zone_setting" "polish" {
  zone_id    = local.zone_id
  setting_id = "polish"
  value      = "off"
}

resource "cloudflare_zone_setting" "prefetch_preload" {
  zone_id    = local.zone_id
  setting_id = "prefetch_preload"
  value      = "on"
}

# Cache rule for static HTML at root domain
resource "cloudflare_ruleset" "cache_rules" {
  zone_id     = local.zone_id
  name        = "Cache Rules"
  description = "Cache static HTML content"
  kind        = "zone"
  phase       = "http_request_cache_settings"

  rules = [
    {
      action = "set_cache_settings"
      action_parameters = {
        cache = true
        edge_ttl = {
          mode    = "override_origin"
          default = 3600 # 1 hour edge cache
        }
        browser_ttl = {
          mode = "respect_origin"
        }
      }
      expression  = "((http.host eq \"makeitwork.cloud\") or (http.host eq \"www.makeitwork.cloud\")) and ((http.request.uri.path eq \"/\") or (ends_with(http.request.uri.path, \".html\")))"
      description = "Cache root and HTML pages for 1 hour at edge"
      enabled     = true
    }
  ]
}
