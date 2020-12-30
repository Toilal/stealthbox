# StealthBox

Share your favorite content remotely without spoiling your home network.

StealthBox is a set of [Docker](https://www.docker.com/) images, so you can install it on any linux server without
polluting it.

It embeds several applications that are configured together to automate file sharing in the cloud and download content
to your home:

- [Deluge](http://deluge-torrent.org/), a BitTorrent client.
- [Medusa](https://pymedusa.com/), an automatic shows downloader. (TODO)
- [CouchPotato](https://couchpota.to/), an automatic movies downloader. (TODO)
- [HeadPhones](https://github.com/rembo10/headphones), an automated music downloader. (TODO)
- [Sonarr](https://sonarr.tv/). (TODO)
- [Pydio](https://pyd.io/), a web application to view, edit and download files. (TODO)

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
