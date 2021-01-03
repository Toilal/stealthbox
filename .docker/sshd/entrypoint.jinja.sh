#!/usr/bin/env sh

# generate host keys if not present
ssh-keygen -A

_password="${SSH_PASSWORD-$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;)}"

if [ -z "$SSH_PASSWORD" ]; then
    echo "SSH_PASSWORD: $_password"
fi

echo "{{ stealthbox.ssh.login }}:$_password" | chpasswd

unset SSH_PASSWORD

if [ -n "$HOST_UID" ]; then
    usermod -u "$HOST_UID" {{ stealthbox.ssh.login }}
fi
if [ -n "$HOST_GID" ]; then
    groupmod -g "$HOST_GID" {{ stealthbox.ssh.login }}
fi

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e