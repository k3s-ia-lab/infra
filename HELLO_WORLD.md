# Integration between XMPP, n8n, and AI (Ollama)

The architecture looks like this:

XMPP Client <-> Openfire <-> n8n <-> Ollama LLM Integration

![xmpp_llm.svg](xmpp_llm.svg)

<!--
@startuml
title XMPP Client <-> Openfire <-> n8n <-> Ollama LLM Integration
actor "User (XMPP Client)" as User
participant "Openfire" as Openfire
participant "n8n" as n8n
participant "Ollama" as Ollama

User -> Openfire : Send message
Openfire -> n8n : Forwards message
n8n -> Ollama : Ask LLM with message
Ollama -> n8n : Return LLM response
n8n -> Openfire : Forwards response
Openfire -> User : Delivery response
@enduml
-->

When it's running, is possible to "talk" with Ollama using jabber/xmpp client using n8n workflows.

You can use any XMPP client (such as Pidgin, Gajim Dino) to connect to the Openfire server.
Web-xmpp included inside openfire, no need to install xmpp client to test.

A n8n workflow acts as a bridge, receiving messages from the user and sending them to the LLM running on Ollama, then
returning the response directly in the chat.

Don't worry... n8n is not just a bridge, you can create more complex workflows, expose MCP tools to the LLM (like ssh
and playright, custom MCP servers), RAG, VectorDB, and **much more**.

## Why jabber/xmpp? This is old stuff! What's next? Using irc, or BBS with phone lines?

XMPP is an open standard protocol, and running your own XMPP server gives you full control over your data and privacy.
Don't need to rely on third-party services and their rules and rate limits.

Also, after installing, your setup is 100% off-grid, no internet required.

But... I like the irc idea... maybe in the future.

---

# K3s namespace uaiso deployments/statefulsets details:

| service readme                 | http ingress                                      |
|--------------------------------|---------------------------------------------------|
| [ollama](ollama/README.md)     | http://ollama.uaiso.lan                           |
| [openfire](openfire/README.md) | http://xmpp.uaiso.lan/ http://xmpp-adm.uaiso.lan/ |
| [rabbitmq](rabbitmq/README.md) | http://rabbitmq.uaiso.lan                         |
| [n8n](n8n/README.md)           | http://n8n.uaiso.lan/                             |
