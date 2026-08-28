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

**TunnelBinding DNS errors:** `cloudflare-operator` exclusively owns DNS for
hostnames served through `ClusterTunnel` resources. An `unmanaged FQDN present`
error means another system owns the CNAME. Do not import or recreate that
record in this root; resolve ownership through the corresponding
`TunnelBinding` in `kustomize-cluster`.

## Related Repositories

- `images` - Contains tfroot-runner image and canonical pre-commit config
- `shared-workflows` - Contains the reusable OpenTofu workflow
- `kustomize-cluster` - Owns Cloudflare Tunnel routes and their DNS CNAMEs

## DNS Search Suffixes

Cloudflare provider 5.20 and later supports `dns_search_suffixes` on Zero Trust
device profiles. Local Domain Fallback is different: it selects which resolver
handles matching domains and does not configure the operating system's DNS
search suffix list.

## Importing Zone Settings

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
