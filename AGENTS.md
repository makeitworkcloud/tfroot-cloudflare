# Agent Instructions

OpenTofu root for Make IT Work Cloud Cloudflare infrastructure.

This root owns bootstrap and non-tunnel Cloudflare resources. `kustomize-cluster` owns workload TunnelBinding routes, workload CNAMEs, and ownership TXT records. For tunnel DNS conflicts, identify the current owner; do not import or recreate an operator-owned record here.

Use GitHub MCP and PR CI plans as validation authority. `main` is an environment-gated apply path; use scoped branches and PRs, never direct pushes. Shared workflow and runner ownership belongs to `shared-workflows` and `images/tfroot-runner`. Never expose API tokens, tunnel credentials, state, decrypted SOPS data, or sensitive plans.
