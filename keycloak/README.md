create pgsql database
```bash
kubectl exec -n k3s-ia-lab postgres-0 -- bash -c "echo 'create database keycloak;' | psql -U postgres"
```

create keycloak
```bash
kubectl apply -f keycloak.yaml
```

/etc/hosts file entrie to access keycloak ingress route from your local network:
```
<your-k3s-ipv4> auth.k3s-ia-lab.lan
```

keycloak (needs create keycloak pgsql db, initial setup):
- url: http://auth.k3s-ia-lab.lan/
- user: admin
- password: admin
