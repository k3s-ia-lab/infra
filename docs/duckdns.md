# Duckdns

[https://www.duckdns.org/spec.jsp](https://www.duckdns.org/spec.jsp)

example curl to dns challenge:

```bash
TOKEN="some-token"
DOMAINS="example"
TXT="some=chalenge"
curl "https://www.duckdns.org/update?token=${TOKEN}&domains=${DOMAINS}&txt=${TXT}&verbose=true&clear=false"
```
