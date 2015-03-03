# StealthBox

Share your favorite content remotely without spoiling your home network.

StealthBox is a [Docker](https://www.docker.com/) image, so you can install it
on any linux server without polluting it.

It embeds several applications that are configured together to automate file 
sharing in the cloud and download content to your home.

## Install

```bash
docker run -d \
  -p 8443:443 -p 8022:22 -p 6881:6881 \
  --name stealthbox \
  toilal/stealthbox
```

## Components

- Change password for each component as soon as possible.
- Replace `<stealthbox>` with IP address of your server and `<8443>`/`<8022>`
with ports used on `docker run`.

### [Pydio](https://pyd.io/)

[Pydio](https://pyd.io/) (formerly AjaXplorer) is a mature open source
software solution for file sharing and synchronization. With intuitive user
interfaces (web / mobile / desktop), Pydio provides enterprise-grade features
to gain back control and privacy of your data: user directory connectors,
legacy filesystems drivers, comprehensive admin interface, and much more.

```
web: https://<stealthbox>:<8443>
username: box
password: box12345
```

### [Deluge](http://deluge-torrent.org/)

[Deluge](http://deluge-torrent.org/) is a lightweight, Free Software,
cross-platform BitTorrent client.

- Full Encryption
- WebUI
- Plugin System
- Much more ...

```
web: https://<stealthbox>:<8443>/deluge
password: box12345
configuration: ~/.config/deluge
service: deluge
```

### SSH/SCP/SFTP

Access StealthBox through SSH/SCP/SFTP to bring content back to home and manage
the environment.

```
ssh: ssh -p <8022> <stealthbox>
username: box
password: box12345
service: sshd
```

### [FlexGet](http://flexget.com/)

[FlexGet](http://flexget.com/) is a multipurpose automation tool for
content like torrents, nzbs, podcasts, comics, series, movies, etc. It can use
different kinds of sources like RSS-feeds, html pages, csv files, search
engines and there are even plugins for sites that do not provide any kind of
useful feeds.

```
configuration: ~/flexget
service: flexget
```

### Others

#### [nginx](http://nginx.org/en/)

[nginx](http://nginx.org/en/) \[engine x\] is an HTTP and reverse proxy
server.

```
configuration: /etc/nginx
service: nginx
```

## Configuration

### Flexget

Flexget is installed in [Daemon](http://flexget.com/wiki/Daemon) mode.

Configuration file is `/home/box/flexget/config.yml`, and will be
automatically reloaded in Daemon when changed.

### Use your own SSL certificate

Self-signed SSL certificate is generated when running the container for the
first time. But self-signed certificates generates warning in browser when
trying to connect.

To avoid this warning, you can use a certificate from trusted authority, and load them in StealthBox. [StartSSL](https://www.startssl.com) can provide free trusted certificate.

- Replacing certificate in container

Your can use your own SSL certificate by replacing `stealthbox.key` and
`stealthbox.crt` in `/home/box/ssl/`, using Pydio or SSH. This will reload
web server automatically.

- Using certificate from host

Instead of replacing certificate files in container, you can also load volumes
pointing to certificate on the host.

```bash
docker run -d \
  -v /home/docker/ssl/stealthbox.key:/home/box/ssl/stealthbox.key:ro \
  -v /home/docker/ssl/stealthbox.crt:/home/box/ssl/stealthbox.crt:ro \
  -p 8443:443 -p 8022:22 -p 6881:6881 \
  --name stealthbox \
  toilal/stealthbox
```

Make sure correct access rights are defined.

```bash
chown 1000:1000 \
  /home/docker/ssl/stealthbox.key \ 
  /home/docker/ssl/stealthbox.crt

chmod 400 /home/docker/ssl/stealthbox.crt
```

### Disable SSL

You may have good reasons to do this, but nginx also listen on `tcp/80` for raw
connections. So you can map this port instead of `tcp/443`.

```bash
docker run -d \
  -p 8080:80 -p 8022:22 -p 6881:6881 \
  --name stealthbox \
  toilal/stealthbox
```

Web server will then be available at `http://<stealthbox>:8080`.

### tcp/6881

`tcp/6881` is the port use by Torrent protocol in deluge. Your have to map
this port on the same host port.

If you really need to change this port, you will have to edit deluge configuration for port to match, in web UI, or in `/home/box/.config/deluge/core.conf` (`listen_ports` parameter). You may also map a port range.