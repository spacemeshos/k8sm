#!/bin/bash
helm repo add akomljen-charts \ https://raw.githubusercontent.com/komljen/helm-charts/master/charts/

helm install --name es-operator \
    --namespace logging \
    akomljen-charts/elasticsearch-operator

# helm install --name efk \
#     --namespace logging \
#     akomljen-charts/efk

helm upgrade efk --install -f ./efk/values.yaml ./efk --namespace logging
