#!/bin/bash

set -x
# output:

helm install grafana \
      --set nodeSelector.role="infra" \
      --set service.type="NodePort" \
      --set persistence.enabled="true" \
      --set datasources."datasources\.yaml".apiVersion=1 \
      --set datasources."datasources\.yaml".datasources[0].name=Prometheus \
      --set datasources."datasources\.yaml".datasources[0].type=prometheus \
      --set datasources."datasources\.yaml".datasources[0].url=http://prometheus-server.monitor.svc.cluster.local:80 \
      --set datasources."datasources\.yaml".datasources[0].access=proxy \
      --set datasources."datasources\.yaml".datasources[0].isDefault=true \
      --namespace monitor \
      stable/grafana

kubectl apply -f grafana_service.yml -n monitor