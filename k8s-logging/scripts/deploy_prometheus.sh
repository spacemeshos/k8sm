#!/bin/bash

set -x
# output:

helm install \
      --set server.nodeSelector.role="infra" \
      --set server.service.type="NodePort" \
      --set pushgateway.nodeSelector.role="infra" \
      --set kubeStateMetrics.nodeSelector.role="infra" \
      --set alertmanager.nodeSelector.role="infra" \
      --set rbac.create=true \
      --set server.persistentVolume.enabled=false \
      --set alertmanager.persistentVolume.enabled=false \
      --set alertmanager.enabled=false \
      --set kubeStateMetrics.enabled=false \
      --set nodeExporter.enabled=false \
      --set pushgateway.enabled=false \
      --name prometheus \
      --namespace monitor \
      stable/prometheus
