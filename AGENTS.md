# Agent Instructions

OpenTofu root for Make IT Work Cloud Cloudflare infrastructure.

This root owns the durable `cluster-apps-k3s` tunnel identity, bootstrap DNS, and non-tunnel Cloudflare resources. `kustomize-cluster` references that tunnel with `existingTunnel` and owns local ingress configuration, workload CNAMEs, and ownership TXT records through `TunnelBinding`. Do not manage local cloudflared configuration or workload DNS here.

Use GitHub MCP and PR CI plans as validation authority. `main` is an environment-gated apply path; use scoped branches and PRs, never direct pushes. Shared workflow and runner ownership belongs to `shared-workflows` and `images/tfroot-runner`. Never expose API tokens, tunnel credentials, state, decrypted SOPS data, or sensitive plans.
