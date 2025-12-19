create keycloak

```bash
kubectl apply -f keycloak.yaml
```

/etc/hosts file entrie to access keycloak ingress route from your local network:

```
<your-k3s-ipv4> auth.uaiso.lan
```

keycloak (needs create keycloak pgsql db, initial setup):

- url: http://auth.uaiso.lan/
- user: admin
- password: admin
