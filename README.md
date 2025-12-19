# UaiSo - Serious?

Unchained Artificial Intelligence Stack/Sandbox Ops/Open -- Why so serious about AI?

---

This project contains k3s (lightweight Kubernetes) deployment manifests for my home lab setup.

# Integration between XMPP, n8n, and AI (Ollama)

This project not only provisions services in the K3s cluster but also demonstrates how they can work together to create
a complete experience:

You can use any XMPP client (such as Pidgin, Gajim Dino, web-xmpp) to connect to the Openfire server.

A n8n workflow acts as a bridge, receiving messages from the user and sending them to the LLM running on Ollama, then
returning the response directly in the chat.

The architecture looks like this:

```
   User (XMPP Client) -> Openfire -> n8n -> Ollama -> n8n -> Openfire -> User (XMPP Client)
```

When it's running, is possible to "talk" with Ollama using jabber/xmpp client using n8n workflows.

You can use local models running on Ollama or different LLM cloud services
like [OpenAI](https://openai.com/), [Antropic](https://www.anthropic.com/), Deepseek, Google Gemini, Aws bedrock, Groq,
or any available n8n nodes.

---

home lab bare metal specs (potatoe computer with nvidia gpu):

- Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz
- 16 GB RAM DDR3 (Using about 3.2GB **without Other services list**)
- NVIDIA GeForce RTX 3050 8GB (Pcie 4.0 x16)
- SSD 256GB
- Pcie 2.0 x16
- Ubuntu Server 24.04 LTS
- k3s v1.33.6+k3s1 (b5847677)

[nvidia](_setup/baremetal/README.md) instructions

[k3s](_setup/k3s/README.md) instructions

create postgresql with pgvector extension, and deploy uaiso manifests:

```bash
kubectl apply -f postgresql/pgvector.yaml
kubectl rollout status statefulset/postgres -n postgresql
kubectl apply -f uaiso.yaml
```

K3s namespace uaiso deployments/statefulsets setup order:

| service readme                 | http ingress                                      |
|--------------------------------|---------------------------------------------------|
| [ollama](ollama/README.md)     | http://ollama.uaiso.lan                           |
| [openfire](openfire/README.md) | http://xmpp.uaiso.lan/ http://xmpp-adm.uaiso.lan/ |
| [rabbitmq](rabbitmq/README.md) | http://rabbitmq.uaiso.lan                         |
| [n8n](n8n/README.md)           | http://n8n.uaiso.lan/                             |

/etc/hosts file entrie to access the ingress routes from your local network:

```
<your-k3s-ipv4> n8n.uaiso.lan ollama.uaiso.lan xmpp.uaiso.lan xmpp-adm.uaiso.lan rabbitmq.uaiso.lan
```

---

# Notes

Don't expose this setup to the internet, it's for home lab use only. There's no security configured, no tls activated.

The openfire image is a custom build with pre-configured settings for easier setup.

There are [instructions to setup this lab inside aws](_setup/aws/README.md) g4dn instance.

It's possible to use ollama cloud without gpu, follow [ollama doc](ollama/README.md).

It's possible to use another chat integration instead of xmpp/openfire, like discord, slack, telegram, whatsapp, etc.
Just change the n8n workflow to use the desired chat node.

---

Other services:

- [grafana](grafana/README.md)
- [keycloak](keycloak/README.md)
- [kubeshark](kubeshark/README.md)
- [mcp-inspector](mcp-inspector/README.md)
- [onedev](onedev/README.md)
- [open-webui](open-webui/README.md)
- [zabbix](zabbix/README.md)

---

TODO:

- migrate bare metal to run inside proxmox vm with pci-e passthrough of nvidia gpu.
- helm charts for all services.
- automate server setup scripts using the helmcharts with --wait.
- upgrade n8n to 2.x.
- supabase
- flowise
- chatwoot
- evolution api
- dify
- typebot
- more db vectors for RAG labs: Qdrant and Milvus
- custom ubuntu container with dev, ops, network tools, ia-console tools.
- ssh-mcp-server (allow LLM to access the custom ubuntu container via ssh)
- playright test runner container
- playright mcp server (allow LLM to execute the playright test runner)
