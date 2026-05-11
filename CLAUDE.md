# k8s-common — development guide

## Purpose

Kubernetes and Helm utility library. Provides context switching with auto-version alignment via asdf, pod/deployment waiters, Helm chart validation, and per-cloud-provider kubeconfig helpers.

## Modules

| File | Key functions |
|------|--------------|
| `lib/kube-config.sh` | `prepare_and_check_k8s_context_generic`, `set_asdf_kubectl_version`, `watch_if_exists` |
| `lib/kube.sh` | `k()` (namespaced kubectl), `wait_for_pod/deployment/statefulset`, `get_single_pod_name` |
| `lib/helm.sh` | `chart_check`, `helm_repo_add`, `helm_test_build`, `h()` (namespaced helm) |
| `lib/kube-config-gcp.sh` | GKE context setup, gcloud auth |
| `lib/kube-config-aws.sh` | EKS context setup, AWS_PROFILE handling |
| `lib/kube-config-azure.sh` | AKS context setup (stub — `set_azure_profile` TBD) |
| `lib/kube-config-local.sh` | Local/minikube context |

## Loading convention

```bash
if type dep &>/dev/null; then
    dep include log2/k8s-common kube-config
    dep include log2/k8s-common kube
else
    include log2/k8s-common lib/kube-config.sh
    include log2/k8s-common lib/kube.sh
fi
```

## Environment expectations

- `NAMESPACE` — set by calling `.envrc` before calling `k()` or `h()`
- `CLUSTER_NAME` — used by `prepare_and_check_k8s_context_generic`
- `RELEASE_NAME` — used by Helm functions in `helm.sh`

These are set by convention in consumer `.envrc` files, not declared in this library.

## Shellcheck notes

- SC2153 disabled on `NAMESPACE` in `kube.sh` — it's a caller convention, not a typo
- SC2317 disabled on nested functions in `helm.sh` — `isDeployed`/`getVersion` are called by name from `chart_check`
- SC2086 disabled on `EXTRA_HELM_OPTIONS` in `helm.sh` — intentional word splitting for multiple flags

## Pre-commit

- `shfmt -i 4 -bn -ci -fn`
- `shellcheck --severity=warning`
