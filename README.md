# Deploy cert-manager
## Kustomize (Incomplete)

This kustomize setup will Deploy `cert-manager` to provision Certificates.

### To Deploy

1. Change directory into any environment directory, e.g. `tst`, or specify the directory
   when using `kustomize` e.g. `kustomize build directory_here`
2. Run `kustomize build` to build the `yaml` and either output into a file to apply
   later or pipe into `kubectl`:
    * Output to a file: `kustomize build > cert-manager.yaml`
    * Pipe directly to `kubectl`: `kustomize build | kubectl apply -f -`
    * Using `kubectl`'s built in `kustomize`: `kubectl apply -k`
      * Please note that the version of `kustomize` that ships with `kubectl` is
        likely to be behind the main release of `kustomize` and may not work
3. Check the operator is running with `kubectl -n cert-manager get pods,certificate,secret,issuer`

## Helm Chart v0.9.1
### Installing the Chart
```sh
## IMPORTANT: you MUST install the cert-manager CRDs **before** installing the
## cert-manager Helm chart
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.9/deploy/manifests/00-crds.yaml
Sleep 15

## IMPORTANT: if the cert-manager namespace **already exists**, you MUST ensure
## it has an additional label on it in order for the deployment to succeed
kubectl create namespace cert-manager
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

## Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io || true
helm repo update

## Install the cert-manager helm chart
helm install --name cert-manager --namespace cert-manager --version v0.9.1 jetstack/cert-manager
```
