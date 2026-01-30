#!/bin/bash
openssl req -x509 -newkey rsa:2048 -nodes -days 365 \
  -keyout uaiso.key -out uaiso.crt \
  -subj "/CN=*.uaiso.lan" \
  -addext "subjectAltName = DNS:*.uaiso.lan, DNS:uaiso.lan"

kubectl create secret tls uaiso-tls-secret \
  --cert=uaiso.crt \
  --key=uaiso.key \
  -n kube-system

kubectl apply -f traefik.yaml

echo | openssl s_client -connect 127.0.0.1:443 -servername uaiso.lan 2>/dev/null | openssl x509 -noout -text
