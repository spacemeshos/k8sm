#!/bin/bash

set -x
u output:
RELEASE="elasticsearch"
REPLICAS=3
MIN_REPLICAS=2
ES_JAVA_OPTS="\-Xms256m \-Xmx256m"

helm install \
      --set master.replicas=${REPLICAS} \
      --set master.nodeSelector.role="infra" \
      --set master.podDisruptionBudget.minAvailable=${MIN_REPLICAS} \
      --set data.replicas=${REPLICAS} \
      --set data.nodeSelector.role="infra" \
      --set data.resources.limits.cpu="2" \
      --set data.persistence.size="50Gi" \
      --set client.replicas="${MIN_REPLICAS}" \
      --set client.resources.limits.cpu="2" \
      --set client.nodeSelector.role="infra" \
      --set client.serviceType="NodePort" \
      --set image.repository="docker.elastic.co/elasticsearch/elasticsearch" \
      --set cluster.env.MINIMUM_MASTER_NODES=${MIN_REPLICAS} \
      --set cluster.env.RECOVER_AFTER_MASTER_NODES=${MIN_REPLICAS} \
      --set cluster.env.EXPECTED_MASTER_NODES=${MIN_REPLICAS} \
      --set cluster.xpackEnable=true \
      --set cluster.env.XPACK_MONITORING_ENABLED=true \
      --name ${RELEASE} \
      --namespace logging \
      stable/elasticsearch
