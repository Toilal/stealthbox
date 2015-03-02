# StealthBox

Install StealthBox remotely and share your favorite content without
degrading your home network.

StealthBox is a [Docker](https://www.docker.com/) image, so you can install it
on any linux server without polluting it.

It embeds multiple applications that are configured together to automate file 
sharing in the cloud and download content to your home.

## Install

TODO: Publish in docker registry.

## Components

### Security note

You should change password for each component as soon as possible.

#### [Deluge](http://deluge-torrent.org/)

[Deluge](http://deluge-torrent.org/) is a lightweight, Free Software,
cross-platform BitTorrent client.

- Full Encryption
- WebUI
- Plugin System
- Much more ...


> HTTP/8112<br>
> Password: admin123

### [Pydio](https://pyd.io/)

[Pydio](https://pyd.io/) (formerly AjaXplorer) is a mature open source
software solution for file sharing and synchronization. With intuitive user
interfaces (web / mobile / desktop), Pydio provides enterprise-grade features
to gain back control and privacy of your data: user directory connectors,
legacy filesystems drivers, comprehensive admin interface, and much more.

> HTTP/8080<br>
> Username: admin<br>
> Password: admin123

### [FlexGet](http://http://flexget.com/)

[FlexGet](http://http://flexget.com/) is a multipurpose automation tool for
content like torrents, nzbs, podcasts, comics, series, movies, etc. It can use
different kinds of sources like RSS-feeds, html pages, csv files, search
engines and there are even plugins for sites that do not provide any kind of
useful feeds.

### SSH/SCP/SFTP

Access StealthBox through SSH/SCP/SFTP to bring content back to home and manage
the environment.

> SSH/22<br>
> Username: box<br>
> Password: box123