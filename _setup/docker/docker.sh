#!/bin/bash

kubectl -n kube-system rollout status deployment/coredns
kubectl -n kube-system scale deployment/coredns --replicas 0
HOST_IP=$(docker exec k3s-server ash -c "hostname -i | awk '{print $1}'")
sed -i "s/127\.0\.0\.1/$HOST_IP/g" ./infra/_setup/k3s/coredns-custom.yaml
kubectl apply -f ./infra/_setup/k3s/coredns-custom.yaml
kubectl -n kube-system scale deployment/coredns --replicas 1
kubectl -n kube-system rollout status deployment/coredns
