https://www.kubehq.com/

https://github.com/kubeshark/kubeshark

```bash
helm repo add kubeshark https://helm.kubehq.com
helm repo update
helm install kubeshark kubeshark/kubeshark -n kubeshark --create-namespace --values values.yaml
```

/etc/hosts file entrie to access kubeshark ingress route from your local network:
```
<your-k3s-ipv4> ks.k3s-ia-lab.lan
```

http://ks.k3s-ia-lab.lan
