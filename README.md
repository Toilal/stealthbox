# StealthBox

Share your favorite content remotely without spoiling your home network.

StealthBox is a set of [Docker](https://www.docker.com/) images, so you can install it on any linux server without 
polluting it.

It embeds several applications that are configured together to automate file sharing in the cloud and download content
to your home:

- [Deluge](http://deluge-torrent.org/), a BitTorrent client.
- [SickRage](http://sickrage.tv), an automatic shows downloader.
- [CouchPotato](https://couchpota.to/), an automatic movies downloader.
- [HeadPhones](https://github.com/rembo10/headphones), an automated music downloader.
- [FlexGet](http://flexget.com/), a multipurpose automation tool
- [Pydio](https://pyd.io/), a web application to view, edit and download files.

## Requirements

- `docker 1.10.0+`
- `docker-compose 1.6.0+`

## Install

- Clone the github repository

```bash
$ git clone -b 2.x https://github.com/Toilal/stealthbox
$ cd stealthbox
```

- Build the docker images. It may take a long time with the deluge container, please be patient :)

```bash
$ docker-compose build
```

- Configure `stealthbox.json` file.

- Launch services

```bash
$ docker-compose up
```

*You can edit `stealthbox.json` configuration at any time, but it requires to restart services again with 
`docker-compose restart` for changes to be effective.*

## URLs

- Deluge: [http://localhost:50080/deluge](http://localhost:50080/deluge)
- SickRage: [http://localhost:50080/sickrage](http://localhost:50080/sickrage)
- CouchPotato: [http://localhost:50080/couchpota](http://localhost:50080/couchpotato)
- HeadPhones: [http://localhost:50080/couchpota](http://localhost:50080/headphones)
- Pydio: [http://localhost:50080](http://localhost:50080)

*Note: Windows user must use the docker-machine ip instead of localhost.*
