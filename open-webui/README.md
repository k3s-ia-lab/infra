This setup needs [keycloak](../keycloak/README.md)

create openwebui databases
```bash
kubectl exec -n k3s-ia-lab postgres-0 -- bash -c "echo 'create database openwebui;' | psql -U postgres"
kubectl exec -n k3s-ia-lab postgres-0 -- bash -c "echo 'create database openwebuipgvector;' | psql -U postgres"
```

create open-webui
```bash
kubectl apply -f open-webui.yaml
```

/etc/hosts file entrie to access keycloak ingress route from your local network:
```
<your-k3s-ipv4> open-webui.k3s-ia-lab.lan
```

open-webui (needs keycloak with k3s-ia-lab realm, user added to realm, create openwebui pgsql db, needs first setup):
- url http://open-webui.k3s-ia-lab.lan/
- volume mount /mnt/data/open-webui
