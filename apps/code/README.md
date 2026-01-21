# Code

Why code? Not AI related, but can integrate vscode with code autocompletion LLMs.

- http ingress: [http://code.uaiso.lan](http://code.uaiso.lan)
- password: get from secret

```bash
echo $(kubectl get secret --namespace code code-code-server -o jsonpath="{.data.password}" | base64 --decode)
```
