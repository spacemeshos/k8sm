# k8sm

mini spacemesh testnet inside k8s

## Prequisites

- Terraform (setup eks + worker nodes + IAM roles etc)
- AWS cli tools + a a valid IAM user with Admin provilidges (could be downnsacled once stable)
- kubectl
- helm
- jq
- aws-iam-authenticator

## consifg K8s storage class

## deployment/k8s/terraform

## deployment/k8s/addons

## deployment/k8s/addons/helm

## deployment/k8s/addons/efk

## deployment/k8s/addons/prometheus-operator

## deployment/k8s/addons/elasticsearch-operator



## Quickstart

* install perreqs
* setup aws-cli (`aws configure --profile spacemesh`)
* `export AWS_PROFILE=spacemesh` 
* 