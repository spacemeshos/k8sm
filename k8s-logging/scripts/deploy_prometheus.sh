#!/bin/bash


set -x
# output:

helm install prometheus --set server.nodeSelector.role="infra" \
      --set server.service.type="NodePort" \
      --set pushgateway.nodeSelector.role="infra" \
      --set kubeStateMetrics.nodeSelector.role="infra" \
      --set alertmanager.nodeSelector.role="infra" \
      --set rbac.create=true \
      --set server.persistentVolume.enabled=true \
      --set server.persistentVolume.size="52Gi" \
      --set server.resources.limits.cpu="3" \ # Todo we need more but our gcp machine type has only 4
      --set server.resources.limits.memory="16Gi" \ # Todo we need more for heavy queries
      --set alertmanager.persistentVolume.enabled=false \
      --set alertmanager.enabled=false \
      --set kubeStateMetrics.enabled=false \
      --set nodeExporter.enabled=false \
      --set pushgateway.enabled=false \
      --set server.retention="48h" \
      --namespace monitor \
      stable/prometheus

kubectl apply -f prom-service.yml -n monitor