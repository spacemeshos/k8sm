#!/usr/bin/env bash

helm init --service-account helm --dry-run --debug > helm-init.yml
[[ -f ./helm-rbac-cluster-wide.yml ]] && kubectl create -f helm-rbac-cluster-wide.yml || echo "you should be creating a role and rolebindg for helm ..."
kubectl create -f helm-init.yml
