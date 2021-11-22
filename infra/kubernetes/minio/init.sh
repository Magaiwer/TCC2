#!/bin/bash
# gerenciador de pacotes kubernetes
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"${OS}_${ARCH}" &&
  "$KREW" install krew
)

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
bash

kubectl krew update
kubectl krew install minio
kubectl minio version
kubectl minio init

kubectl get pods -n minio-operator

kubectl krew install direct-csi
kubectl direct-csi install --crd
kubectl direct-csi drives ls
kubectl direct-csi drives format --drives /dev/sdb --force
# choose all the drives that direct-csi should manage and format them
kubectl direct-csi drives format --drives $DRIVE_SELECTOR_GLOB --nodes $NODE_SELECTOR_GLOB
# 'direct-csi-min-io' can now be specified as the storageclass in PodSpec.VolumeClaimTemplates
Access Key: 03s0aLu1txirg7c7
Secret Key: gJyaNMVGVbGnwl8lPSKVF5LB7rthiGWa