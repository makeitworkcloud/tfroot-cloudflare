terraform {
  required_version = "> 1.3"

  backend "s3" {}

  required_providers {
    sops = {
      source = "carlpett/sops"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

provider "sops" {}

provider "cloudflare" {
  api_token = data.sops_file.secret_vars.data["cloudflare_api_token"]
}
