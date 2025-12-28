data "sops_file" "secret_vars" {
  source_file = "${path.module}/secrets/secrets.yaml"
}

locals {
  account_id                = data.sops_file.secret_vars.data["cloudflare_account_id"]
  zone_id                   = data.sops_file.secret_vars.data["cloudflare_zone_id"]
  github_warp_client_id     = data.sops_file.secret_vars.data["github_warp_client_id"]
  github_warp_client_secret = data.sops_file.secret_vars.data["github_warp_client_secret"]

  # Private networks (CIDR protected via SOPS)
  warp_private_network = data.sops_file.secret_vars.data["warp_private_network"]
}

data "cloudflare_zone" "makeitwork_cloud" {
  zone_id = local.zone_id
}
