#!/bin/bash

kubectl delete customresourcedefinitions.apiextensions.k8s.io certificates.certmanager.k8s.io
kubectl delete -f clusterIssuers.yaml