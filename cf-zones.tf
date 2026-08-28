resource "cloudflare_zone" "xnoto_dev" {
  account = {
    id = local.account_id
  }
  name = "xnoto.dev"
  type = "full"
}
