resource "cloudflare_page_rule" "ansible_bypass" {
  zone_id  = local.zone_id
  target   = "ansible.makeitwork.cloud/*"
  priority = 1
  status   = "active"

  actions = {
    disable_security = true
    waf              = "off"
    browser_check    = "off"
  }
}
