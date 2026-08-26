# tfroot-cloudflare

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.3 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 5.0 |
| <a name="provider_sops"></a> [sops](#provider\_sops) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [cloudflare_dns_record.cluster_apps](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.mx_primary](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.mx_secondary](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.onion](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.root](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.spf](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.www](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_ruleset.cache_rules](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/ruleset) | resource |
| [cloudflare_zero_trust_access_application.alertmanager](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.grafana_alerts](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.k3s](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.mcp_gateway](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.warp](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_group.admins](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_group) | resource |
| [cloudflare_zero_trust_access_identity_provider.github](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_identity_provider) | resource |
| [cloudflare_zero_trust_access_service_token.mcp_gateway](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_service_token) | resource |
| [cloudflare_zero_trust_organization.main](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_organization) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared.warp](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared_route.private_network](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared_route) | resource |
| [cloudflare_zone_setting.brotli](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.browser_cache_ttl](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.browser_check](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.cache_level](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.challenge_ttl](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.early_hints](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.minify](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.polish](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.rocket_loader](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared.cluster_apps](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zero_trust_tunnel_cloudflared) | data source |
| [cloudflare_zone.makeitwork_cloud](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zone) | data source |
| [sops_file.secret_vars](https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_mcp_gateway_service_token_client_id"></a> [mcp\_gateway\_service\_token\_client\_id](#output\_mcp\_gateway\_service\_token\_client\_id) | CF-Access-Client-Id for MCP gateway clients |
| <a name="output_mcp_gateway_service_token_client_secret"></a> [mcp\_gateway\_service\_token\_client\_secret](#output\_mcp\_gateway\_service\_token\_client\_secret) | CF-Access-Client-Secret for MCP gateway clients |
| <a name="output_tunnel_ids"></a> [tunnel\_ids](#output\_tunnel\_ids) | Cloudflare Tunnel IDs for reference in kustomize-cluster ConfigMaps |
<!-- END_TF_DOCS -->

## Kubernetes API access

This root manages the Cloudflare side of kubectl connectivity:

- `cf-warp.tf` defines the GitHub identity provider and
  `makeitworkcloud:admins` Access group.
- `cf-access-k3s.tf` applies that group to the migration fallback at
  `k3s.makeitwork.cloud`.
- `cf-tunnels.tf` keeps the `api` and `k3s` CNAMEs pointed at the
  operator-owned `cluster-apps-k3s` tunnel.

The separate `kustomize-cluster/workloads/kubectl-tunnel` desired state owns
the in-cluster route from that tunnel to the Kubernetes API Service.

Normal kubectl access connects directly to `https://api.makeitwork.cloud` and
relies on a Dex-issued OIDC token plus Kubernetes RBAC. Cloudflare Access still
protects the legacy TCP route at `k3s.makeitwork.cloud` during migration. The
canonical kubeconfig and `kubelogin` procedure lives in the
[`kustomize-cluster` README](https://github.com/makeitworkcloud/kustomize-cluster#kubectl-access).
Do not store kubeconfigs, Access tokens, client certificates, or Cloudflare
credentials in this repository.

The CNAME and the `TunnelBinding` are coordinated control points. When
retiring a hostname, reconcile the binding first so cloudflare-operator clears
its `_managed.<fqdn>` TXT record, then remove the hostname here and review the
OpenTofu plan before apply.
