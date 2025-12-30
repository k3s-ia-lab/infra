# DNS considerations

the traefik ingress is configured to route *.uaiso.lan domains to the services deployed in the k3s cluster.

There's a squid proxy running on &lt;your-k3s-ipv4&gt; port 3128.

Use http proxy in your browser to resolve the *.uaiso.lan dns and access the ingress routes.

You can configure your browser to use a http proxy manually, or use an extension like FoxyProxy.

[FoxyProxy for Chrome](https://chromewebstore.google.com/search/foxyproxy)

[FoxyProxy for Firefox](https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/)

---

# Squid proxy

The [basic.sh](../basic.sh) script changes the system's `/etc/hosts` file to add the necessary DNS entries for the
services deployed in the K3s cluster. And deploy a squid proxy running on &lt;your-k3s-ipv4&gt; port 3128.

---

# Options without the embeddded proxy strategy

## Option 1: You have control over your home network dns server

- your router allows you to add custom dns entries (like dd-wrt, openwrt, etc)
- you have a pihole or similar dns server in your home network
- you have a local dns server (bind, unbound, etc)

## Option 2: You are admin of your computer

- you can put one entrie to your computer's hosts file (/etc/hosts in linux/macos, C:\Windows\System32\drivers\etc\hosts
  in windows)

```text
<your-k3s-ipv4> n8n.uaiso.lan ollama.uaiso.lan xmpp.uaiso.lan xmpp-adm.uaiso.lan rabbitmq.uaiso.lan grafana.uaiso.lan auth.uaiso.lan ks.uaiso.lan mcp-inspector.uaiso.lan mcp-inspector-proxy.uaiso.lan onedev.uaiso.lan open-webui.uaiso.lan zabbix.uaiso.lan
```

## Option 3: Create your own ssh tunnel with dynamic port forwarding

```bash
ssh -D 1080 -N youruser@<your-k3s-ipv4>
```

Then configure your browser to use a socks5 proxy on localhost:1080

## Option 4: Use a VPN that allows custom dns entries

- create a vpn service like openvpn, wireguard, tinc, etc
- configure the vpn server to push custom dns entries for *.uaiso.lan to the clients
- connect your computer to the vpn

## Option 5: SOCKS5 Proxy deployment with SSH Dynamic Port Forwarding

[README_SOCKS.md](README_SOCKS.md)
---

Probably there are more workarounds, feel free to try, it's your lab playground. You can become a DNS ninja!
