# Chatwoot

Why Chatwoot? Not AI related, nice to monitor chatbots and customer interactions.

[https://github.com/chatwoot/chatwoot](https://github.com/chatwoot/chatwoot)

ingress: [http://chatwoot.uaiso.lan](http://chatwoot.uaiso.lan)

```bash
helm repo add chatwoot https://chatwoot.github.io/charts
helm repo update
helm install chatwoot chatwoot/chatwoot -n chatwoot --create-namespace --version 2.0.9 --values values.yaml
```
