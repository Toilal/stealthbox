local ddb = import 'ddb.docker.libjsonnet';

local pp = std.extVar("docker.port_prefix");
local domain_ext = std.extVar("core.domain.ext");
local domain_sub = std.extVar("core.domain.sub");
local stealthbox_deluge_salt = std.extVar("stealthbox.deluge.salt");
local stealthbox_deluge_sha1 = std.extVar("stealthbox.deluge.sha1");
local stealthbox_ssh_login = std.extVar("stealthbox.ssh.login");
local stealthbox_ssh_password = std.extVar("stealthbox.ssh.password");
local host_gid = std.extVar("docker.user.gid");
local host_uid = std.extVar("docker.user.uid");

local domain = std.join('.', [domain_sub, domain_ext]);

local compose = ddb.Compose({
    services: {
    	deluge: ddb.Build("deluge") +
                ddb.User() +
                ddb.VirtualHost(8112, "deluge." + domain, "deluge") + {
                    environment+: {
                        [if stealthbox_deluge_salt != null then 'DELUGE_SALT']: stealthbox_deluge_salt,
                        [if stealthbox_deluge_sha1 != null then 'DELUGE_SHA1']: stealthbox_deluge_sha1
                    },
                    volumes: [
                        ddb.path.project + "/deluge/config:/config",
                        ddb.path.project + "/deluge/data:/data"
                    ]
                },
    	jackett: ddb.Build("jackett") +
                 ddb.User() +
                 ddb.VirtualHost(9117, "jackett." + domain, "jackett") + {
                     environment+: {},
                     volumes: [
                         ddb.path.project + "/jackett/config:/config",
                         ddb.path.project + "/jackett/data:/data"
                     ]
                 },
        flaresolverr: ddb.Image("flaresolverr/flaresolverr") + {
            environment+: {
              LOG_LEVEL: "info"
            },
        },
    	sonarr: ddb.Build("sonarr") +
                ddb.User() +
                ddb.VirtualHost(8989, "sonarr." + domain, "sonarr") + {
                    environment+: {},
                    volumes: [
                        ddb.path.project + "/sonarr/config:/config",
                        ddb.path.project + "/sonarr/data:/data"
                    ]
                },
    	radarr: ddb.Build("radarr") +
                ddb.User() +
                ddb.VirtualHost(7878, "radarr." + domain, "radarr") + {
                    environment+: {},
                    volumes: [
                        ddb.path.project + "/radarr/config:/config",
                        ddb.path.project + "/radarr/data:/data",
                    ]
                },
    	lidarr: ddb.Build("lidarr") +
                ddb.User() +
                ddb.VirtualHost(8686, "lidarr." + domain, "lidarr") + {
                    environment+: {},
                    volumes: [
                        ddb.path.project + "/lidarr/config:/lidarr",
                        ddb.path.project + "/lidarr/data:/data",
                    ]
                },
    	sshd: ddb.Build("sshd") +
              {
                  ports: [pp+'22:22'],
                  environment+: {
                    [if stealthbox_ssh_password != null then 'SSH_PASSWORD']: stealthbox_ssh_password,
                    HOST_GID: host_gid,
                    HOST_UID: host_uid
                  },
                  volumes+: [
                    "ssh-config:/etc/ssh"
                  ]
              }
        }
});

compose + {
    services+: {
      sshd+: {
        volumes+: std.filter(function(x) if x != null then true else false, [
             if (std.objectHas(compose.services, "deluge")) then ddb.path.project + "/deluge:/home/" + stealthbox_ssh_login + "/deluge" else null,
             if (std.objectHas(compose.services, "jackett")) then ddb.path.project + "/jackett:/home/" + stealthbox_ssh_login + "/jackett" else null,
             if (std.objectHas(compose.services, "sonarr")) then ddb.path.project + "/sonarr:/home/" + stealthbox_ssh_login + "/sonarr" else null,
             if (std.objectHas(compose.services, "radarr")) then ddb.path.project + "/radarr:/home/" + stealthbox_ssh_login + "/radarr" else null,
             if (std.objectHas(compose.services, "lidarr")) then ddb.path.project + "/lidarr:/home/" + stealthbox_ssh_login + "/lidarr" else null,
           ])
      }
    }
}
