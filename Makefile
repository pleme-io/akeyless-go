# akeyless-go regeneration via forge-gen.
#
# This repo is a pure autogen output of the akeyless OpenAPI 3.0 spec.
# `make regenerate` is the single source of truth for every .go file in the
# tree (excluding LICENSE, CLAUDE.md, flake.nix, flake.lock, Makefile, and
# api/openapi.yaml itself, which is the vendored input).

PACKAGE_NAME    ?= akeyless
PACKAGE_VERSION ?= 0.1.0
GIT_USER_ID     ?= pleme-io
GIT_REPO_ID     ?= akeyless-go
SPEC            ?= api/openapi.yaml
OUT_DIR         ?= .forge-gen-out

.PHONY: regenerate verify clean help

help: ## Show this help
	@awk 'BEGIN{FS=":.*?##"} /^[a-zA-Z_-]+:.*?##/{printf "  %-12s %s\n",$$1,$$2}' $(MAKEFILE_LIST)

regenerate: ## Regenerate the SDK from api/openapi.yaml via forge-gen
	@rm -rf $(OUT_DIR)
	nix shell nixpkgs#openapi-generator-cli --command \
	  forge-gen generate \
	    --spec $(SPEC) \
	    --sdks go \
	    --output $(OUT_DIR) \
	    --git-user-id $(GIT_USER_ID) \
	    --git-repo-id $(GIT_REPO_ID) \
	    --additional-properties packageName=$(PACKAGE_NAME),packageVersion=$(PACKAGE_VERSION),withGoMod=true
	@cp -r $(OUT_DIR)/sdk/go/. .
	@rm -rf $(OUT_DIR)
	@echo ""
	@echo "Regeneration complete. Verify with: make verify"

verify: ## Build sanity check
	go build ./...
	@echo "Build clean."

clean: ## Remove regen scratch dir
	rm -rf $(OUT_DIR)
