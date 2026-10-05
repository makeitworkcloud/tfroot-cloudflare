resource "cloudflare_ruleset" "response_headers" {
  zone_id     = local.zone_id
  name        = "Response header transforms"
  description = "Hostname-scoped response security headers"
  kind        = "zone"
  phase       = "http_response_headers_transform"

  rules = [
    {
      ref    = "opencode_hsts"
      action = "rewrite"
      action_parameters = {
        headers = {
          "strict-transport-security" = {
            operation = "set"
            value     = "max-age=86400"
          }
        }
      }
      expression  = "(http.host eq \"opencode.makeitwork.cloud\" and ssl)"
      description = "One-day HSTS for the OpenCode HTTPS hostname only"
      enabled     = true
    }
  ]
}
