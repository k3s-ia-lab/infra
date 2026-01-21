# Zabbix

Why zabbix? Not AI related, gather hardware metrics like GPU usage, temperature, power consumption, used by grafana.

http ingress: [http://zabbix.uaiso.lan](http://zabbix.uaiso.lan)

---

[https://www.zabbix.com/download?zabbix=7.4&os_distribution=ubuntu&os_version=24.04&components=agent_2&db=&ws=](https://www.zabbix.com/download?zabbix=7.4&os_distribution=ubuntu&os_version=24.04&components=agent_2&db=&ws=)

```bash
wget https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.4+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.4+ubuntu24.04_all.deb
apt update
apt install zabbix-agent2
apt install zabbix-agent2-plugin-nvidia-gpu
```

edit config /etc/zabbix/zabbix_agent2.conf

```text
Server=0.0.0.0/0
```

start agent

```bash
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2
```
