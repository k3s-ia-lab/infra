create mcp-inspector

```bash
kubectl apply -f mcp-inspector.yaml
```

/etc/hosts file entrie to access mcp-inspector ingress route from your local network:

```
<your-k3s-ipv4> mcp-inspector.uaiso.lan mcp-inspector-proxy.uaiso.lan
```

mcp inspector:

- url http://mcp-inspector.uaiso.lan
