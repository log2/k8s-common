# k8s-common — status

## Health: good core, incomplete Azure

- GCP and generic paths used in production (owncluster, MyIA)
- AWS path functional but less exercised
- Azure: `set_azure_profile` is a stub (function body is `:`)

## Known issues

- `kube-config-azure.sh`: `set_azure_profile` is unimplemented — not a problem as long as no consumer calls it
- `kube.sh`: `create_namespace_if_not_exists` has a bug — it hardcodes `flux` as the namespace in the create call instead of using the `$namespace` argument
- `helm.sh`: `getVersion` uses `.$1.deployment.image.tag` as the jq path, which is overly specific and only works with one particular values structure

## Tech debt

- `prepare_and_check_k8s_context` (deprecated) is still present — kept for backward compatibility but should be removed once no consumers use it
- `wait_for_statefulset` is a no-op with a log message (K8s issue #79606) — callers need to use a workaround
- `helm_test_build` has `target=target` hardcoded as a local var then immediately used — no input param

## Dependencies

- `log2/shell-common` (log, req, asdf)
- `kubectl`, `helm`, `jq`, `yq` at runtime (enforced via `req_ver`)
