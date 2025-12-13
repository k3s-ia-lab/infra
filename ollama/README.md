ollama [ollama README.md](ollama/README.md):
- url: http://ollama-service.k3s-ia-lab.svc.cluster.local:11434 (k8s internal)
- no apikey
- volume mount /mnt/data/ollama

pull the llama3.2 3b model:
```bash
kubectl -n k3s-ia-lab exec ollama-0 -- bash -c "ollama pull llama3.2:3b"
```