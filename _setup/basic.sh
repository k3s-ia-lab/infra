#!/bin/bash

mkdir -p /mnt/k3s-data /mnt/data/{n8n,ollama} /root/.ssh
chmod -R 777 /mnt/data

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--data-dir /mnt/k3s-data" sh -

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh

wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_linux_amd64.deb
dpkg -i k9s_linux_amd64.deb

HOST_IP=$(hostname -I | awk '{print $1}')

echo "
$HOST_IP n8n.uaiso.lan \
ollama.uaiso.lan \
xmpp.uaiso.lan \
xmpp-adm.uaiso.lan \
rabbitmq.uaiso.lan \
grafana.uaiso.lan \
auth.uaiso.lan \
ks.uaiso.lan \
mcp-inspector.uaiso.lan \
mcp-inspector-proxy.uaiso.lan \
onedev.uaiso.lan \
open-webui.uaiso.lan \
zabbix.uaiso.lan" >> /etc/hosts

sed -i "s/127\.0\.0\.1/$HOST_IP/g" ./infra/_setup/k3s/coredns-custom.yaml
kubectl apply -f ./infra/_setup/k3s/coredns-custom.yaml

echo "y" | ssh-keygen -t ed25519 -C "openssh docker image public ed25519 uaiso-key" -f uaiso-key -q -N ""
cat uaiso-key.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
kubectl create ns ssh-socks5
kubectl create secret generic ssh-key-secret --from-file=ed25519=/root/.ssh/uaiso-key --namespace=ssh-socks5

sed -i "s/127\.0\.0\.1/$HOST_IP/g" ./infra/_setup/k3s/ssh-socks5.yaml
kubectl apply -f ./infra/_setup/k3s/ssh-socks5.yaml

kubectl apply -f ./infra/postgresql/pgvector.yaml
kubectl rollout status statefulset/postgres -n postgresql
kubectl apply -f ./infra/uaiso.yaml

cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
