#!/bin/sh

kubectl apply -f ./infra/_setup/k3s/squid.yaml
kubectl -n squid rollout status deployment/squid

kubectl apply -f ./infra/postgresql/pgvector.yaml
kubectl -n postgresql rollout status statefulset/postgres

kubectl apply -f ./infra/uaiso.yaml

kubectl -n uaiso rollout status statefulset/openfire
kubectl -n uaiso cp ./infra/openfire/openfire_init.sh openfire-0:/tmp/openfire_init.sh
kubectl -n uaiso exec openfire-0 -- bash -c "/tmp/openfire_init.sh"
kubectl -n uaiso delete pod openfire-0
kubectl -n uaiso rollout status statefulset/openfire

kubectl -n uaiso rollout status statefulset/ollama
kubectl -n uaiso exec ollama-0 -- bash -c "ollama pull gemma3:270m"

kubectl -n uaiso rollout status deployment/rabbitmq

kubectl -n uaiso rollout status statefulset/n8n
kubectl -n uaiso exec n8n-0 -- ash -c "git clone https://github.com/uaiso-serious/infra.git /tmp/infra"
kubectl -n uaiso exec n8n-0 -- ash -c "n8n import:entities --truncateTables --inputDir=/tmp/infra/n8n/entities --keyFile=/tmp/infra/n8n/keyfile.txt"
kubectl -n uaiso exec n8n-0 -- ash -c "cd .n8n/nodes;npm i n8n-nodes-xmpp@1.0.121"
kubectl -n uaiso exec n8n-0 -- ash -c "n8n import:credentials --separate --input=/tmp/infra/n8n/credentials"
kubectl -n uaiso exec n8n-0 -- ash -c "n8n import:workflow --separate --input=/tmp/infra/n8n/workflows"

# fix pgsql to activate workflow https://github.com/n8n-io/n8n/issues/21210
kubectl -n postgresql exec -i postgres-0 -- psql -U postgres n8n < infra/n8n/workflow_history_fix.sql

kubectl -n uaiso exec n8n-0 -- ash -c "n8n update:workflow --id=rAczBsYXmwUPlMg2 --active=true"
kubectl -n uaiso delete pod n8n-0
kubectl -n uaiso rollout status statefulset/n8n

echo "--- Hello world setup complete! Say hi to severino bot on XMPP!"
