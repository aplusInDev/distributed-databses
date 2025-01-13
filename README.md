# Distributed Oracle Database Project

## Table of Contents
1. [Introduction](#introduction)
2. [Work Environment](#work-environment)
   - [Technical Architecture](#technical-architecture)
     - [Technologies Used](#technologies-used)
     - [Node Architecture](#node-architecture)
3. [Prerequisites](#prerequisites)
4. [Installation](#installation)
   - [Project Structure](#1-project-structure)
   - [Docker Compose Configuration](#2-docker-compose-configuration)
   - [Starting the Containers](#3-starting-the-containers)
   - [Installation Verification](#4-installation-verification)
5. [Connection Configuration](#connection-configuration)
   - [Central Node (Consolidation)](#central-node-consolidation)
   - [Fragmentation Nodes](#fragmentation-nodes)
     - [Node 1 (Horizontal Fragmentation)](#node-1-horizontal-fragmentation)
     - [Node 2 (Vertical Fragmentation)](#node-2-vertical-fragmentation)
     - [Node 3 (Mixed Fragmentation)](#node-3-mixed-fragmentation)
6. [Maintenance](#maintenance)
   - [Useful Commands](#useful-commands)
   - [Troubleshooting Common Issues](#troubleshooting-common-issues)
7. [Technical Documentation](#technical-documentation)

## Introduction
This project implements a distributed database environment using Oracle, demonstrating the practical implementation of data fragmentation concepts and communication between distributed databases.

## Work Environment

### Technical Architecture
The project's technical architecture is based on a modern and robust virtualized infrastructure, consisting of the following elements:

#### Technologies Used
- **Virtualization Platform**: Docker
- **DBMS**: Oracle XE 11g (Docker image: oracleinanutshell/oracle-xe-11g)
- **Network**: Docker Bridge (subnet 172.20.0.0/16)

#### Node Architecture
Our system consists of four distinct Oracle nodes:
- Three nodes dedicated to data fragmentation:
  - Node 1: Horizontal fragmentation
  - Node 2: Vertical fragmentation
  - Node 3: Mixed fragmentation
- One central node for data consolidation and synchronization

## Prerequisites
- Docker Engine
- Docker Compose
- Minimum 8 GB of RAM recommended
- 20 GB of available disk space

## Installation

### 1. Project Structure
```
project/
├── docker-compose.yml
├── scripts/
│   ├── central/
│   │   ├── Dockerfile
│   │   └── run.sh
│   ├── vm1/
│   │   ├── Dockerfile
│   │   └── run.sh
│   ├── vm2/
│   │   ├── Dockerfile
│   │   └── run.sh
│   └── vm3/
│       ├── Dockerfile
│       └── run.sh
```

### 2. Docker Compose Configuration
```yaml
services:
  oracle-vm1:
    build:
      context: ./scripts/vm1
    container_name: oracle-vm1
    ports: ["1521:1521"]

  oracle-vm2:
    build:
      context: ./scripts/vm2
    container_name: oracle-vm2
    ports: ["1522:1521"]

  oracle-vm3:
    build:
      context: ./scripts/vm3
    container_name: oracle-vm3
    ports: ["1523:1521"]

  oracle-central:
    build:
      context: ./scripts/central
    container_name: oracle-central
    ports: ["1524:1521"]
```

### 3. Starting the Containers
```bash
# Clone the repository
git clone https://github.com/aplusInDev/distributed-databses
cd distributed-databses

# Start the containers
docker-compose up -d
```

### 4. Installation Verification
```bash
docker-compose ps
```

## Connection Configuration

### Central Node (Consolidation)
- Host: localhost
- Port: 1524
- SID: XE
- User: system
- Password: oracle

### Fragmentation Nodes
#### Node 1 (Horizontal Fragmentation)
- Host: localhost
- Port: 1521
- SID: XE

#### Node 2 (Vertical Fragmentation)
- Host: localhost
- Port: 1522
- SID: XE

#### Node 3 (Mixed Fragmentation)
- Host: localhost
- Port: 1523
- SID: XE

## Maintenance

### Useful Commands
```bash
# Stop the containers
docker-compose down

# View logs
docker-compose logs [container-name]

# Restart services
docker-compose restart
```

### Troubleshooting Common Issues
1. **Port Conflict**: Ensure no service is already using ports 1521-1524
2. **Startup Failure**: Check logs with `docker-compose logs`
3. **Memory Issues**: Ensure sufficient available RAM

## Technical Documentation
For more details on the implementation and use of fragmentation features:
- Horizontal fragmentation: Node 1 (Port 1521)
- Vertical fragmentation: Node 2 (Port 1522)
- Mixed fragmentation: Node 3 (Port 1523)
