# etcd-operator helm chart

## Installation

```bash
helm repo add etcd-operator https://raw.githubusercontent.com/canonical/etcd-operator/master/charts
helm install etcd-operator etcd-operator/etcd-operator --namespace etcd --version 0.0.1
```

## Development

When the Helm charts are updated, make sure to run `helm package .` as well, to update the `.tgz` files. Bump the minor version when making backwards-incompatible changes.

Make sure that `latest` is a symlink that always points to the latest minor version.

### Development workflow

```bash
cd chart

# if making a backwards-incompatible change, bump minor
cp v0.0.1 v0.1.0
rm latest && ln -s v0.1.0 latest

# ... edit templates, configuration, values, etc under etcd-operator ...

# package helm chart
(cd latest && helm package etcd-operator)

# update repository index
helm repo index .
```
