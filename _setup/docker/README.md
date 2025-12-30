# Running k3s in Docker

https://dev.to/olymahmud/running-a-kubernetes-cluster-with-k3s-30lo

## Requirements

- Docker installed and running
- kubectl installed

```bash
docker run -d --rm --name k3s-server \
  --privileged \
  -p 6443:6443 \
  -p 3128:3128 \
  -v k3s-data:/var/lib/rancher/k3s \
  --hostname k3s-server \
  rancher/k3s:v1.35.0-k3s1 server \
  --node-name k3s-server
```

Get the kubeconfig file from the k3s server container:

```bash
docker cp k3s-server:/etc/rancher/k3s/k3s.yaml ~/k3s.yaml
export KUBECONFIG=~/k3s.yaml
```

clone repo and run script

```bash
git clone https://github.com/uaiso-serious/infra.git
./infra/_setup/docker/docker.sh
```
