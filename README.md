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
| [cloudflare_dns_record.cluster_bootstrap](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.mx_primary](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.mx_secondary](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.onion](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.root](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.spf](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.www](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.xnoto_dev_root](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.xnoto_dev_www](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_ruleset.cache_rules](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/ruleset) | resource |
| [cloudflare_ruleset.response_headers](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/ruleset) | resource |
| [cloudflare_zero_trust_access_application.alertmanager](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.grafana_alerts](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.k3s](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.mcp_gateway](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.mcp_gateway_backend](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_application.warp](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_group.admins](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_group) | resource |
| [cloudflare_zero_trust_access_identity_provider.github](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_identity_provider) | resource |
| [cloudflare_zero_trust_access_service_token.hero_host_config_warp](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_service_token) | resource |
| [cloudflare_zero_trust_access_service_token.mcp_gateway](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_service_token) | resource |
| [cloudflare_zero_trust_organization.main](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_organization) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared.cluster_apps](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared.warp](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared_route.private_network](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared_route) | resource |
| [cloudflare_zone.xnoto_dev](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone) | resource |
| [cloudflare_zone_setting.brotli](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.browser_cache_ttl](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.browser_check](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.cache_level](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.challenge_ttl](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.early_hints](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.minify](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.polish](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.rocket_loader](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.xnoto_dev_ssl](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone.makeitwork_cloud](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zone) | data source |
| [sops_file.secret_vars](https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_hero_host_config_warp_service_token_client_id"></a> [hero\_host\_config\_warp\_service\_token\_client\_id](#output\_hero\_host\_config\_warp\_service\_token\_client\_id) | Cloudflare Access service-token client ID for hero-host-config WARP enrollment |
| <a name="output_hero_host_config_warp_service_token_client_secret"></a> [hero\_host\_config\_warp\_service\_token\_client\_secret](#output\_hero\_host\_config\_warp\_service\_token\_client\_secret) | Cloudflare Access service-token client secret for hero-host-config WARP enrollment |
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
- `cf-tunnels.tf` owns the `api` and `k3s` CNAMEs.
- The `ClusterTunnel` and `TunnelBinding` manifests in
  `kustomize-cluster/workloads/kubectl-tunnel` own their routes with DNS
  updates disabled.

Normal kubectl access connects directly to `https://api.makeitwork.cloud` and
relies on a Dex-issued OIDC token plus Kubernetes RBAC. Cloudflare Access still
protects the legacy TCP route at `k3s.makeitwork.cloud` during migration. The
canonical kubeconfig and `kubelogin` procedure lives in the
[`kustomize-cluster` README](https://github.com/makeitworkcloud/kustomize-cluster#kubectl-access).
Do not store kubeconfigs, Access tokens, client certificates, or Cloudflare
credentials in this repository.

This root owns only the bootstrap tunnel DNS required to reach the Kubernetes
API before cluster workloads are available. `TunnelBinding` owns workload
tunnel DNS, including the MCP gateway endpoints. Do not add a workload hostname
to this OpenTofu root.

## OpenCode HSTS

`cf-opencode-hsts.tf` configures the zone response-header ruleset with a rule
matching only HTTPS requests to `opencode.makeitwork.cloud`. It sets
`Strict-Transport-Security: max-age=86400` (one day), without
`includeSubDomains` or `preload`. Native OpenCode authentication and existing
HTTPS redirection are unchanged. No Cloudflare Access, workload DNS/tunnel,
or AWX cleanup is included.

This root owns the response-header entrypoint. Review and preserve its full
rule list before adding other header rules; do not create a competing
entrypoint or adopt an existing one without reviewing its rules. PR CI plans
validate the proposed changes; `main` runs a fresh environment-associated
apply, not the saved PR plan. Merge and apply authorization are separate.

After approved apply, verify the HTTPS UI and unauthenticated API responses
carry the header, native phone login and session continuity still work, and
sibling hostnames are unaffected. A successful plan is not live verification.

For rollback, first serve `max-age=0` over HTTPS through this rule, then remove
it after the rollback has been reviewed and applied. Simply removing the
header does not clear browser policies; they otherwise expire up to one day
after their last receipt. Preserve HTTPS throughout.
