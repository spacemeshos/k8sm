# k8s 4 Spacemesh

Mini Spacemesh testnet inside k8s

## Prequisites

- Terraform (setup eks + worker nodes + IAM roles etc)
- AWS cli tools + a a valid IAM user with Admin privilidges (should be down-sacled once stabled)
- kubectl - kubernetes cli tool
- helm - kuberentes "package manager"
- jq - json query tool very useful when managing clusters and working with `json` outputs
- aws-iam-authenticator

## deployment/terraform

See [deployment/README.md](deployment/README.md)

## k8s-apps

This dir will include all the add-ons needed (this will probebly change in time):

- 01.helm - Installation of helm (./install.sh doe sthe trick at the moment) 
  see -> [k8s-apps/01.helm-install/README.md](k8s-apps/01.helm-install/README.md)
- 02.efk - install elasticsearch operator and efk for logging stack

## spacemesh-apps [ WIP ]

Curentelly let's just launch an instance of spacemesh-go app
Next steps:

- Define how to pass the instance token and ip to the rest of the nodes in the mesh (hint: probebly use init containers)
- Build test scearios && configuration files to setup various testing scenarios.

## Quickstart

- Install perreqs
- setup aws-cli (`aws configure --profile spacemesh`)
- set your AWS profile:
    ```sh
    export AWS_PROFILE=spacemesh
    ```
