#!/bin/bash

set -x
# output:

helm install \
      --set nodeSelector.role="infra" \
      --set service.type="NodePort" \
      --set persistence.enabled="true" \
      --set datasources."datasources\.yaml".apiVersion=1 \
      --set datasources."datasources\.yaml".datasources[0].name=Prometheus \
      --set datasources."datasources\.yaml".datasources[0].type=prometheus \
      --set datasources."datasources\.yaml".datasources[0].url=http://prom.spacemesh.io \
      --set datasources."datasources\.yaml".datasources[0].access=proxy \
      --set datasources."datasources\.yaml".datasources[0].isDefault=true \
      --name grafana \
      --namespace monitor \
      stable/grafana
