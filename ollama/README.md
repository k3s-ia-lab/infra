ollama:
- url: http://ollama-service.k3s-ia-lab.svc.cluster.local:11434 (k8s internal)
- http ingress: http://ollama.k3s-ia-lab.lan (external access)
- no apikey
- volume mount /mnt/data/ollama

---

# If you have Nvidia GPU installed and the NVIDIA GPU Operator deployed in your k3s cluster, your ollama pod should be up and running.

pull the llama3.2 3b model:
```bash
kubectl -n k3s-ia-lab exec ollama-0 -- bash -c "ollama pull llama3.2:3b"
```

---

# Don't have Nvidia GPU?

replace the ollama deployment with the cpu version in ollama-no-gpu.yaml:
```bash
kubectl -n k3s-ia-lab apply -f ollama-no-gpu.yaml
```

Note that the cpu version will be very slow for inference, and the yaml ram resource is limited to 1Gi to avoid ram leak and crashes.

Alternatively, you can try ollama cloud https://docs.ollama.com/cloud.

Create account, follow the instructions.

Enter pod and login:
```bash
kubectl -n k3s-ia-lab exec -it ollama-0 -- bash 
```

Call login command:
```text
ollama signin
```
follow the instructions to login ollama cloud.

try small model, bigger models will eat tokens/quota very fast:
```bash
ollama pull ministral-3:3b-cloud
```

available cloud models:

https://ollama.com/search?c=cloud