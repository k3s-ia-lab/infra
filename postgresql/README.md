postgres with pgvector extension:
- dns host: postgres-lb.postgresql.svc.cluster.local (k8s internal)
- ip <your-k3s-ipv4>
- port: 5432
- user: postgres
- password: mysecurepassword
- volume mount /mnt/data/postgres
