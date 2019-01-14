#!/usr/bin/env bash

# kubectl delete deployments. tiller-deploy
# kubectl delete svc tiller-deploy
# kubectl delete clusterrolebindings.rbac.authorization.k8s.io helm
# kubectl delete serviceaccounts helm
kubectl delete -n kube-system deployment `kubectl get deployments --all-namespaces | grep 'helm\|tiller' | awk '{print $2}'` 2> /dev/null
kubectl delete -n kube-system svc `kubectl get svc --all-namespaces | grep 'tiller' | awk '{print $2}'` 2> /dev/null
kubectl delete -n kube-system sa `kubectl get serviceaccounts --all-namespaces | grep 'helm\|tiller' | awk '{print $2}'` 2> /dev/null
kubectl delete -n kube-system clusterrolebindings.rbac.authorization.k8s.io `kubectl get clusterrolebindings.rbac.authorization.k8s.io --all-namespaces | grep 'helm\|tiller' | awk '{print $1}'` 2> /dev/null
