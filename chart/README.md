# etcd-operator helm chart

## Installation

```bash
helm repo add etcd-operator https://raw.githubusercontent.com/canonical/etcd-operator/master/chart
helm install etcd-operator etcd-operator/etcd-operator --namespace etcd --version 0.0.1
```

## Development

When the Helm charts are updated, make sure to run `helm package .` as well, to update the `.tgz` files. Bump the minor version when making backwards-incompatible changes.

### Development workflow

```bash
cd chart

# if making a backwards-incompatible change, bump minor
cp v0.0.1 v0.1.0

# ... edit templates, configuration, values, etc under etcd-operator ...

# package helm chart
(cd v0.1.0 && helm package etcd-operator)

# update repository index
helm repo index .
```
