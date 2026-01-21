# Onedev

Why onedev? A nice self-hosted git server with CI/CD with MCP server.

[https://github.com/theonedev/onedev](https://github.com/theonedev/onedev)

- http ingress: [http://onedev.uaiso.lan](http://onedev.uaiso.lan)

```bash
kubectl exec -n postgresql postgres-0 -- bash -c "echo 'create database onedev;' | psql -U postgres"
helm repo add onedev https://code.onedev.io/onedev/~helm
helm repo update onedev
helm install onedev onedev/onedev -n onedev --create-namespace --values values.yaml
```
