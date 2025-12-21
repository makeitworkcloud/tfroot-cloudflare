data "sops_file" "secret_vars" {
  source_file = "${path.module}/secrets/secrets.yaml"
}

locals {
  account_id = data.sops_file.secret_vars.data["cloudflare_account_id"]
  zone_id    = data.sops_file.secret_vars.data["cloudflare_zone_id"]
}

data "cloudflare_zone" "makeitwork_cloud" {
  zone_id = local.zone_id
}
