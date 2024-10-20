# vps-bootstrap

The intent of this repository is to serve as an umbrella for various configurations including a cloud-config/init.

This is a complementary project to the `cp` API server.

## Default Installs

### OS Packages

The following OS packages are installed as part of [cloud-config](cloud-config).

- apt-transport-https
- ca-certificates
- curl
- debian-archive-keyring
- debian-keyring
- git
- jq
- software-properties-common

### Services

Podman is installed via [bootstrap.sh](bootstrap.sh).

- **podman** - configured with the ReST API which runs on port `8081`

## Optional Services

For convenience, configurations for optional services are co-located here. The `cp` API retrieves configurations as
needed for the following optional services:

- **graphana**
- **otel-collector**
- **prometheus**
- **traefik** - configured with LetsEncrypt and Cloudflare for DNS challenge for automatic TLS certificate provisioning. 

