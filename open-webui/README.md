This setup needs:

- [postgresql](../postgresql/README.md)
- [keycloak](../keycloak/README.md)

create open-webui

```bash
kubectl apply -f open-webui.yaml
```

/etc/hosts file entrie to access open-webui ingress route from your local network:

```
<your-k3s-ipv4> open-webui.uaiso.lan
```

open-webui (needs keycloak with uaiso realm, user added to realm, create openwebui pgsql db, needs first setup):

- url http://open-webui.uaiso.lan/
