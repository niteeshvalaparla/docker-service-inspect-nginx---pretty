## Docker Swarm + Consul Service Discovery Challenge

## Overview

This project demonstrates a secure multi-node Docker Swarm environment deployed on AWS EC2 instances.

### Infrastructure

* Node-A (Docker Swarm Manager)
* Node-B (Docker Swarm Worker)
* Amazon Linux 2023
* Docker Engine
* Docker Swarm
* Overlay Network
* Consul Service Discovery

## Security

Configured AWS Security Groups with:

* TCP 22 (SSH)
* TCP 2377 (Docker Swarm Manager)
* TCP/UDP 7946 (Swarm Node Communication)
* UDP 4789 (Overlay Networking)
* TCP 8500 (Consul UI)
* UDP 8600 (Consul DNS)

## Docker Swarm Setup

Manager Node:

```bash
docker swarm init
```

Worker Node:

```bash
docker swarm join --token <TOKEN> <MANAGER-IP>:2377
```

## Overlay Network

```bash
docker network create -d overlay app-network
```

## Services

### Nginx

```bash
docker service create \
--name nginx \
--network app-network \
nginx
```

### Apache

```bash
docker service create \
--name apache \
--network app-network \
httpd
```

## Consul Service Discovery

Run Consul:

```bash
docker run -d \
--name consul \
-p 8500:8500 \
-p 8600:8600/udp \
hashicorp/consul agent -server -bootstrap-expect=1 -ui -client=0.0.0.0
```

Register Service:

```bash
curl --request PUT --data @nginx.json \
http://localhost:8500/v1/agent/service/register
```

DNS Verification:

```bash
dig @127.0.0.1 -p 8600 nginx.service.consul
```

Result:

```text
nginx.service.consul -> 172.17.0.2
```

## Outcome

Successfully demonstrated:

* Docker Swarm clustering
* Overlay networking
* Multi-node container deployment
* Consul-based service discovery
* DNS-based service resolution
* Secure AWS deployment
## Infrastructure as Code

Terraform configuration is available in the `terraform/` directory.

Resources provisioned:

- AWS EC2 Node-A
- AWS EC2 Node-B
- AWS Security Group
- Network access configuration
