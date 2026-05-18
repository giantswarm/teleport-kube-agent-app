##@ Giant Swarm customizations

PATCH_DIR := patches

.PHONY: apply-patches
apply-patches: ## Re-apply GS customization patches after `vendir sync`.
	@echo "====> $@"
	@for patch in $(PATCH_DIR)/*.patch; do \
		echo "Applying $$patch"; \
		git apply --verbose "$$patch" || { echo "Failed to apply $$patch"; exit 1; }; \
	done

.PHONY: regenerate-patches
regenerate-patches: ## Regenerate patches from current uncommitted changes to the vendored chart.
	@echo "====> $@"
	@git diff HEAD -- helm/teleport-kube-agent/charts/teleport-kube-agent/templates/_helpers.tpl    > $(PATCH_DIR)/01-helpers-registry-template.patch
	@git diff HEAD -- helm/teleport-kube-agent/charts/teleport-kube-agent/templates/delete_hook.yaml > $(PATCH_DIR)/02-delete_hook-image-registry.patch
	@git diff HEAD -- helm/teleport-kube-agent/charts/teleport-kube-agent/templates/deployment.yaml  > $(PATCH_DIR)/03-deployment-image-registry.patch
	@git diff HEAD -- helm/teleport-kube-agent/charts/teleport-kube-agent/templates/hook.yaml        > $(PATCH_DIR)/04-hook-alpine-version.patch
	@git diff HEAD -- helm/teleport-kube-agent/charts/teleport-kube-agent/templates/statefulset.yaml > $(PATCH_DIR)/05-statefulset-image-and-proxy.patch
	@git diff HEAD -- helm/teleport-kube-agent/charts/teleport-kube-agent/values.schema.json        > $(PATCH_DIR)/06-subchart-schema-image-object.patch
