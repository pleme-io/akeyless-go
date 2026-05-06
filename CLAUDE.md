# akeyless-go

> **★★★ CSE / Knowable Construction.** This repo operates under
> **Constructive Substrate Engineering** — canonical specification at
> [`pleme-io/theory/CONSTRUCTIVE-SUBSTRATE-ENGINEERING.md`](https://github.com/pleme-io/theory/blob/main/CONSTRUCTIVE-SUBSTRATE-ENGINEERING.md).
> The Compounding Directive (operational rules: solve once, load-bearing
> fixes only, idiom-first, models stay current, direction beats velocity)
> is in the org-level pleme-io/CLAUDE.md ★★★ section. Read both before
> non-trivial changes.

Auto-generated Go SDK for the Akeyless API. 604 endpoints, ~1170 typed
models. Generated from the official OpenAPI 3.0 spec via `forge-gen`
(which wraps `openapi-generator-cli`).

## Substrate posture

This repo is a **pure autogen output** — no hand-written Go. The single
authored input is `api/openapi.yaml` (vendored from akeyless's official
spec); everything else (`api_v2.go`, `client.go`, `configuration.go`, all
1170+ `model_*.go`, all `docs/*.md`) regenerates deterministically from
that spec via `make regenerate`.

Hand-edits to generated `.go` files are reverted on the next regeneration.
If you need to change behavior, change the OpenAPI spec or extend
`forge-gen`'s `--additional-properties` plumbing — never the output.

## Regenerating

```bash
make regenerate
```

Under the hood, this runs:

```bash
nix shell nixpkgs#openapi-generator-cli --command \
  forge-gen generate \
    --spec api/openapi.yaml \
    --sdks go \
    --output .forge-gen-out \
    --git-user-id pleme-io \
    --git-repo-id akeyless-go \
    --additional-properties packageName=akeyless,packageVersion=0.1.0,withGoMod=true
```

Then promotes `.forge-gen-out/sdk/go/*` to the repo root.

`forge-gen` transparently transcodes the YAML spec to JSON before
invocation (the akeyless OpenAPI's datetime literals trip
`openapi-generator-cli`'s YAML parser — see
[OpenAPITools/openapi-generator#9203](https://github.com/OpenAPITools/openapi-generator/issues/9203)).

### Refreshing the spec from upstream

```bash
curl -sSfL https://raw.githubusercontent.com/akeylesslabs/akeyless-go/main/api/openapi.yaml \
  -o api/openapi.yaml
make regenerate
go build ./...
```

## Generator details

| Setting | Value |
|---------|-------|
| Generator | `openapi-generator-cli` v7.21.0 (via `forge-gen`) |
| Target | `go` |
| Module path | `github.com/pleme-io/akeyless-go` |
| Source spec | `api/openapi.yaml` (vendored from `akeylesslabs/akeyless-go`) |
| OpenAPI version | 3.0.0 |
| API version | 3.0 |

## History

This repo was originally a fork of `akeylesslabs/akeyless-go`. On
2026-05-06 it was rebuilt as a pure autogen output to match
pleme-io's substrate posture (Pillar 12: generation over composition).
The pre-autogen state is preserved on the `pre-autogen-backup-2026-05-06`
branch.
