resource "cloudflare_ruleset" "zone_custom_firewall" {
  zone_id     = local.zone_id
  name        = "Custom Firewall Rules"
  description = "Custom firewall rules for the zone"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules = [
    {
      action = "skip"
      action_parameters = {
        products = [
          "bic",
          "securityLevel",
          "uaBlock",
          "zoneLockdown"
        ]
      }
      expression  = "(http.host eq \"ansible.makeitwork.cloud\")"
      description = "Skip WAF checks for Ansible"
      enabled     = true
    }
  ]
}
