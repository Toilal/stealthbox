# StealthBox

Share your favorite content remotely without spoiling your home network.

StealthBox is a set of [Docker](https://www.docker.com/) images, so you can install it on any linux server without
polluting it.

It embeds several applications that are configured together to automate file sharing in the cloud and download content
to your home:

- [Deluge](https://deluge-torrent.org/), a BitTorrent client.
- [Jackett](https://github.com/Jackett/Jackett).
- [Sonarr](https://sonarr.tv/).
- [Radarr](https://radarr.video/).
- [Lidarr](https://lidarr.audio/).

## Requirements

- A linux box with a wildcard domain name configured (`domain.tld`)
- [docker-devbox](https://github.com/gfi-centre-ouest/docker-devbox)

## Install

- Clone the github repository

```bash
$ git clone https://github.com/Toilal/stealthbox
$ cd stealthbox
```

- Create `ddb.local.yml` file with the following content. You should customize your accounts and passwords.

```yaml
core:
  env:
    current: prod
  domain:
    ext: domain.tld
docker:
  reverse_proxy:
    certresolver: letsencrypt
stealthbox:
  deluge:
    password: "box"
  ssh:
    login: "box"
    password: "box"
```

- Generate all files based on your configuration.

```bash
$ ddb configure
```

- Build docker-compose stack.

```bash
$ docker-compose build
```

- Start docker-compose stack.

```bash
$ docker-compose up -d
```

## URLs

You can get URLs and ports of all services by running the following command

```bash
$ ddb info
```
