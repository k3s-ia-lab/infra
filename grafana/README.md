create grafana
```bash
kubectl apply -f grafana.yaml
```

/etc/hosts file entrie to access grafana ingress route from your local network:
```
<your-k3s-ipv4> grafana.k3s-ia-lab.lan
```

http://grafana.k3s-ia-lab.lan/
