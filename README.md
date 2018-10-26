# StealthBox

Share your favorite content remotely without spoiling your home network.

StealthBox is a set of [Docker](https://www.docker.com/) images, so you can install it on any linux server without 
polluting it.

It embeds several applications that are configured together to automate file sharing in the cloud and download content
to your home:

- [Deluge](http://deluge-torrent.org/), a BitTorrent client.
- [Medusa](https://pymedusa.com/), an automatic shows downloader.
- [CouchPotato](https://couchpota.to/), an automatic movies downloader.
- [HeadPhones](https://github.com/rembo10/headphones), an automated music downloader.
- [Sonarr](https://sonarr.tv/). (TODO)
- [Pydio](https://pyd.io/), a web application to view, edit and download files. (TODO)

## Requirements

- `docker 1.13.0+`
- `docker-compose 1.13.0+`

## Install

- Clone the github repository

```bash
$ git clone https://github.com/Toilal/stealthbox
$ cd stealthbox
```

- Copy `.env.dist` file to `.env` and customize settings

```bash
$ cp .env.dist .env
$ editor .env
```

- Symlink `docker-compose.override.standalone.yml` to `docker-compose.override.yml`

```bash
$ ln -s docker-compose.override.standalone.yml docker-compose.override.yml
```

- Copy `stealthbox-conf/stealthbox.json` to `stealthbox.json` and customize configuration.

```bash
$ cp stealthbox-conf/conf/stealthbox.json stealthbox.json
$ editor stealthbox.json
```

- Build docker images. It may take a long time, please be patient :)

```bash
$ docker-compose build
```

- Launch services.

```bash
$ docker-compose up
```

*You can edit `stealthbox.json` configuration at any time, but it requires to restart services again with 
`docker-compose restart` for changes to be effective.*

## URLs

- Deluge: [http://localhost:50080/deluge](http://localhost:50080/deluge)
- Medusa: [http://localhost:50080/medusa](http://localhost:50080/medusa)
- CouchPotato: [http://localhost:50080/couchpotato](http://localhost:50080/couchpotato)
- HeadPhones: [http://localhost:50080/headphones](http://localhost:50080/headphones)

*Note: Windows user must use the docker-machine ip instead of localhost.*
