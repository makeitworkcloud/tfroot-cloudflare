# Agent Instructions

## Repository Purpose

OpenTofu root module for Cloudflare infrastructure.

## Git Workflow

Use a feature branch and open a pull request rather than pushing directly to
`main`. A push to `main` can invoke `apply` after tests pass and configured
environment gates approve it. Do not push any branch unless explicitly
requested.

## Pre-commit Configuration

Pre-commit configuration is centralized at
`https://raw.githubusercontent.com/makeitworkcloud/images/main/tfroot-runner/pre-commit-config.yaml`. The root
`.pre-commit-config.yaml` is generated and ignored; do not edit it.

For local development, run:
```bash
make test
```

This refreshes the generated config from the canonical source on every run and
replaces it only when the content changed.

## CI/CD

This repo uses the shared `opentofu.yml` workflow from `shared-workflows`. Jobs
run natively on `arc-tf`; the runner pod already uses the `tfroot-runner` image,
so the workflow does not start a nested container. The shared workflow fetches
the canonical pre-commit config at runtime; this repository does not provide a
tracked copy.

### Failure Modes

**"manifest unknown" error:** The `tfroot-runner:latest` image doesn't exist in GHCR. Check if the `images` repo Build workflow succeeded.

**Pre-commit failures:** If hooks fail unexpectedly, the canonical config may
have changed. Re-run `make test` to refresh it and run the checks.

**Cloudflare API error 81053 (`record with that host already exists`) on
`cloudflare_dns_record.cluster_apps[...]`:** The `TunnelBinding` operator in
`kustomize-cluster` creates DNS records as soon as ArgoCD syncs. If a hostname
lands there before this root's apply creates it, the apply fails 81053 and the
plan could not warn about it (the record is not in state). Do not delete the
operator's record — it will be recreated. Import it instead, with
`CLOUDFLARE_API_TOKEN` and `ZONE_ID` extracted from SOPS in the same shell
(never printed):

```bash
AWS_PROFILE=makeitwork make init
REC_ID=$(curl -fsS -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=<fqdn>" | jq -r '.result[0].id')
AWS_PROFILE=makeitwork tofu import 'cloudflare_dns_record.cluster_apps["<name>"]' "$ZONE_ID/$REC_ID"
```

Then re-run the failed apply job. To avoid the race, merge this root's DNS
change before the kustomize-cluster `TunnelBinding` change when adding a new
cluster-app hostname.

## Related Repositories

- `images` - Contains tfroot-runner image and canonical pre-commit config
- `shared-workflows` - Contains the reusable OpenTofu workflow

## DNS Search Suffixes

Cloudflare provider 5.20 and later supports `dns_search_suffixes` on Zero Trust
device profiles. Local Domain Fallback is different: it selects which resolver
handles matching domains and does not configure the operating system's DNS
search suffix list.

## Importing Zone Settings

For DNS records created out-of-band (for example by the `TunnelBinding`
operator), see **Failure Modes** (error 81053) instead.

Cloudflare zone-setting import IDs use `<zone-id>/<setting-id>`. Obtain the
zone ID through the approved local secret workflow, then import each managed
setting explicitly, for example:

```bash
tofu import cloudflare_zone_setting.cache_level "$ZONE_ID/cache_level"
tofu import cloudflare_zone_setting.browser_cache_ttl "$ZONE_ID/browser_cache_ttl"
tofu import cloudflare_zone_setting.browser_check "$ZONE_ID/browser_check"
tofu import cloudflare_zone_setting.challenge_ttl "$ZONE_ID/challenge_ttl"
tofu import cloudflare_zone_setting.minify "$ZONE_ID/minify"
```
