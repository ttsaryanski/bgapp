# BGApp Project

## Description

The goal of this project is to automatically build and deploy a complete **Docker Swarm cluster** infrastructure using Vagrant and VirtualBox. Vagrant automatically provisions a virtual machine with Docker configured in Swarm mode, enabling automatic service orchestration, scaling, and high availability. The infrastructure allows you to scale services dynamically based on demand - from a single container to multiple replicas across the cluster.

## Main Goals

- �️ **VM Provisioning**: Automatically create and configure VirtualBox VM via Vagrant
- 🐳 **Docker Swarm Cluster**: Initialize and manage a Docker Swarm cluster for production-grade orchestration
- 📈 **Dynamic Scaling**: Scale services up or down instantly based on demand
- 🚀 **Fully Automated Deployment**: One-command setup from bare metal to running cluster
- 🛡️ **High Availability**: Automatic service recovery and load balancing
- 💾 **Database**: Initialization and management of PostgreSQL/MySQL database
- 🔄 **Container Orchestration**: Automatic container placement, networking, and service management

---

## Project Structure

```
.
├── docker-compose.yaml      # Docker Swarm service stack configuration (deploy services with scaling)
├── Dockerfile.web           # Docker image for the web application
├── README.md                # This file
├── db/                      # Database
│   └── db_setup.sql         # SQL script for database initialization
├── infra/                   # Infrastructure scripts
│   ├── deploy-services.sh   # Script for deploying services to Swarm cluster
│   ├── docker-config.sh     # Docker Swarm initialization and configuration
│   ├── open-firewall-ports.sh # Opening firewall ports
│   ├── swarm_token          # Docker Swarm join token for multi-node cluster
│   └── Vagrantfile          # Vagrant configuration for VM
└── web/                     # Web application
    ├── config.php           # Configuration file
    └── index.php            # Application entry point
```

---

## Components

### 1. **Docker & Swarm Orchestration** 🐳

- `Dockerfile.web` - Defines how the Docker image for the web server is built
- `docker-compose.yaml` - Defines Swarm services with replica scaling configuration
- Docker Swarm Mode - Enables clustering, load balancing, and automatic service recovery

### 2. **Web Application** 💻

- `web/` directory contains the PHP application
- `config.php` - Configuration settings
- `index.php` - Application entry point

### 3. **Database** 💾

- `db/db_setup.sql` - SQL script for initialization
- Automatically deployed when containers start

### 4. **Docker Swarm & Automation** 🖥️

- `Vagrantfile` - Automatically creates and configures the entire VirtualBox VM
- `docker-config.sh` - Initializes Docker Swarm mode and configures cluster settings
- `deploy-services.sh` - Deploys and manages services in the Swarm cluster with scaling
- `open-firewall-ports.sh` - Opens required ports for Swarm communication
- `swarm_token` - Token for joining additional nodes to the cluster (for multi-node setup)

---

## Getting Started

### Prerequisites

- **VirtualBox** installed
- **Vagrant** installed
- Sufficient disk space (~5GB) and RAM (4GB+) allocated to VirtualBox

### Automatic Installation & Deployment

Everything is automated with a single command:

```bash
# Start the entire infrastructure (VM creation, provisioning, and service deployment)
vagrant up
```

That's it! Vagrant will:

1. ✅ Create and configure the VirtualBox VM
2. ✅ Install Docker and initialize Docker Swarm cluster
3. ✅ Configure Swarm cluster settings and networks
4. ✅ Open firewall ports for Swarm communication
5. ✅ Deploy all services with initial replicas to the cluster

**Scale services (e.g., 3 replicas of web service):**

```bash
docker service scale bgapp_web=3
```

**Check service status:**

```bash
docker service ls
docker service ps bgapp_web
```

**To stop everything:**

```bash
vagrant halt
```

**To destroy the cluster and start fresh:**

```bash
vagrant destroy
vagrant up
```

---

## Usage

After successful deployment:

- 🌐 Web application: http://localhost (or configured port) - load balanced across replicas
- 🗄️ Database: Accessible from containers in the Swarm cluster
- 📊 Swarm Dashboard: View cluster status with `docker node ls`

### Scaling Services

Scale the web service to 5 replicas:

```bash
docker service scale bgapp_web=5
```

Scale the database service:

```bash
docker service scale bgapp_db=2
```

View all running services and their replicas:

```bash
docker service ls
docker service ps bgapp_web
```

Update service configuration:

```bash
docker service update --env-add KEY=value bgapp_web
```

---

## Notes

- All configuration variables can be found in `docker-compose.yaml`
- Docker Swarm service logs: `docker service logs bgapp_web`
- View cluster nodes: `docker node ls`
- View cluster status: `docker node inspect <node-id>`
- Services automatically restart on failure (configurable via compose file)
- Load balancing is automatic for all replicated services
- To extend to multi-node cluster, use the `swarm_token` file to join additional nodes

---

**Created:** 2026-06-22
