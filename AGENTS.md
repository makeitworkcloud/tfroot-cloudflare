# Agent Instructions

## Repository Purpose

OpenTofu root module for Cloudflare infrastructure.

## Push Access

Agents are authorized to push directly to `main` in this repository.

## Pre-commit Configuration

Pre-commit configuration is **centralized** in `makeitworkcloud/images/tfroot-runner/pre-commit-config.yaml`. The CI workflow fetches this config at runtime.

**Do not** create or modify `.pre-commit-config.yaml` in this repository.

For local development, run:
```bash
make test
```

This automatically fetches the canonical config if not present.

## CI/CD

This repo uses the shared `opentofu.yml` workflow from `shared-workflows`. It runs on `ubuntu-latest` with the `tfroot-runner` container from GHCR.

### Failure Modes

**"manifest unknown" error:** The `tfroot-runner:latest` image doesn't exist in GHCR. Check if the `images` repo Build workflow succeeded.

**Pre-commit failures:** If hooks fail unexpectedly, the canonical config may have changed. Delete `.pre-commit-config.yaml` locally and re-run `make test` to fetch the latest.

## Related Repositories

- `images` - Contains tfroot-runner image and canonical pre-commit config
- `shared-workflows` - Contains the reusable OpenTofu workflow and canonical pre-commit config

## Known Limitations

### WARP cannot push DNS search domains (as of 2026-05)

Investigated whether the `warp-connector` tunnel + Zero Trust device profile could push `makeitwork.cloud` as an OS-level DNS search domain so `ssh hero` resolves to `hero.makeitwork.cloud` while WARP is connected, and is removed on disconnect.

**Conclusion: not possible today.** Cloudflare documents the feature as in development:
> "Support for DNS suffix search lists in the Cloudflare One Client is currently in development."
> — https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/cloudflare-one-client/configure/route-traffic/#add-a-dns-suffix

Workaround they recommend is per-device manual config (System Settings → Network → DNS → Search Domains on macOS, equivalents elsewhere).

#### What does NOT solve it

`cloudflare_zero_trust_device_default_profile_local_domain_fallback` (and the per-profile variant) only changes **which resolver handles `*.suffix` queries** — it does **not** add the suffix to the OS search list. WARP installs a local DNS proxy that handles whatever the OS sends; if the OS hasn't expanded `hero` → `hero.makeitwork.cloud` (which needs a search domain), WARP never sees the FQDN. Don't add this resource thinking it fixes the shortname problem — it won't.

(Local Domain Fallback may still be worth adding for unrelated reasons — keeping internal-only hostnames out of Gateway logs, or pointing them at a private resolver — but it's a separate concern.)

#### Watch for these signals that the blocker has lifted

Revisit when any of these appear:

1. The Cloudflare docs page above stops saying "in development" and adds a Dashboard / API / Terraform tab for "DNS suffix search lists" (or similar — Cloudflare may name it "Override search domains" or "Search domain list").
2. The `cloudflare/cloudflare` Terraform provider gains a new attribute on `cloudflare_zero_trust_device_default_profile` / `..._device_custom_profile` — likely named `dns_search_domains`, `search_domains`, `match_domains`, or similar. Grep the provider changelog: https://github.com/cloudflare/terraform-provider-cloudflare/blob/main/CHANGELOG.md
3. A new top-level Terraform resource appears under `docs/resources/` matching `zero_trust_device_*_search*` or `zero_trust_device_*_dns_suffix*`.
4. The WARP MDM XML schema (https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/cloudflare-one-client/deployment/mdm-deployment/parameters/) gains a `search_domains` / `dns_suffix` key — usually the API/Terraform support follows shortly after.
5. Cloudflare changelog / blog announces the feature: https://developers.cloudflare.com/cloudflare-one/changelog/

When it lands, the fix is small: add the new attribute (or new resource) to `cf-warp.tf`, scoped to the makeitworkcloud-admins group, with `makeitwork.cloud` in the search list. Verify on a test device that `scutil --dns` (macOS) shows `makeitwork.cloud` in the search domains while WARP is connected and that the entry disappears on disconnect.
