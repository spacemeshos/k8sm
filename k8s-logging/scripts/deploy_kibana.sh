#!/bin/bash

set -x
# output:

ELASTICSEARCH_URL="http://elasticsearch-client:9200"

helm install \
      --set env.ELASTICSEARCH_URL=${ELASTICSEARCH_URL} \
      --set files."kibana\.yml"."elasticsearch\.url"=${ELASTICSEARCH_URL} \
      --set nodeSelector.role="infra" \
      --set service.type="NodePort" \
      --set image.repository="docker.elastic.co/kibana/kibana" \
      --name kibana \
      --namespace logging \
      stable/kibana
