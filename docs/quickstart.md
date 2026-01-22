# Quickstart

## K3s
### Easy install

From script as root, and deploy squid proxy:

```bash
git clone https://github.com/uaiso-serious/infra.git
./infra/_setup/k3s/k3s.sh
kubectl apply -f ./infra/apps/squid.yaml
```

Follow [squid](apps/squid.md) instructions, to configure your browser.

---

### Pro install

Follow k3s official docs: [https://docs.k3s.io/](https://docs.k3s.io/)

Edit file coredns-custom.yaml, change 127.0.0.1 to your k3s server ipv4 address.

Deploy coredns-custom.yaml

```bash
kubectl apply -f coredns-custom.yaml
```

restart coredns pods

```bash
kubectl -n kube-system rollout restart deployment coredns
```

Choose one [DNS workaround](dns.md)

---

## Apps

Check apps folder with yaml manifests and README.md instructions for each app.

Simple yaml example:

```bash
kubectl apply -f ./infra/apps/n8n/n8n.yaml
```
