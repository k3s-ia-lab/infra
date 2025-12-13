postgres with pgvector extension:
- dns host: postgres-lb.postgresql.svc.cluster.local (k8s internal)
- ip <your-k3s-ipv4>
- port: 5432
- user: postgres
- password: mysecurepassword
- volume mount /mnt/data/postgres

Create databases
```bash
kubectl exec -n k3s-ia-lab postgres-0 -- bash -c "echo 'create database openwebui;' | psql -U postgres"
kubectl exec -n k3s-ia-lab postgres-0 -- bash -c "echo 'create database openwebuipgvector;' | psql -U postgres"
kubectl exec -n k3s-ia-lab postgres-0 -- bash -c "echo 'create database keycloak;' | psql -U postgres"
kubectl exec -n k3s-ia-lab postgres-0 -- bash -c "echo 'create database zabbix;' | psql -U postgres"
kubectl exec -n k3s-ia-lab postgres-0 -- bash -c "echo 'create database zabbixweb;' | psql -U postgres"
```
