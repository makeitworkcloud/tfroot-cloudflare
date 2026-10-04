data "cloudflare_rulesets" "opencode_hsts_preflight" {
  zone_id   = local.zone_id
  max_items = 1000

  lifecycle {
    postcondition {
      condition     = length(self.rulesets) < 1000
      error_message = "Ruleset discovery reached its limit; stop and review the complete inventory before adding HSTS."
    }
    postcondition {
      condition = length([
        for ruleset in self.rulesets : ruleset.id
        if ruleset.kind == "zone" && ruleset.phase == "http_response_headers_transform"
      ]) == 0
      error_message = "An existing response-header ruleset requires ownership review before adding OpenCode HSTS."
    }
  }
}

output "opencode_hsts_existing_response_header_rulesets" {
  description = "Preflight count of existing zone response-header rulesets; must be zero before HSTS creation."
  value = length([
    for ruleset in data.cloudflare_rulesets.opencode_hsts_preflight.rulesets : ruleset.id
    if ruleset.kind == "zone" && ruleset.phase == "http_response_headers_transform"
  ])
}
