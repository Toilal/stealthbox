# StealthBox

Share your favorite content remotely without spoiling your home network.

StealthBox is a set of [Docker](https://www.docker.com/) images, so you can install it on any linux server without 
polluting it.

It embeds several applications that are configured together to automate file sharing in the cloud and download content
to your home:

- [Deluge](http://deluge-torrent.org/), a BitTorrent client.
- [SickRage](http://sickrage.tv), an automatic shows downloader.
- [CouchPotato](http://sickrage.tv), an automatic movies downloader.
- [HeadPhones](https://github.com/rembo10/headphones), an automated music downloader.
- [FlexGet](http://flexget.com/), a multipurpose automation tool
- [Pydio](https://pyd.io/), a web application to view, edit and download files.

## Requirements

- `docker 1.10.0+`
- `docker-compose 1.6.0+`
