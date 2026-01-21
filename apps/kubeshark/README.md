# Kubeshark

Why kubeshark? Not AI related, but you can see how the LLM is talking to the outside world using MCP.

[https://github.com/kubeshark/kubeshark](https://github.com/kubeshark/kubeshark)

- http ingress: [http://ks.uaiso.lan](http://ks.uaiso.lan)

```bash
helm repo add kubeshark https://helm.kubehq.com
helm repo update
helm install kubeshark kubeshark/kubeshark -n kubeshark --create-namespace --values values.yaml
```
