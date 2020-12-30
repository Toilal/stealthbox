#!/usr/bin/env sh

# generate host keys if not present
ssh-keygen -A

_password="${SSH_PASSWORD-$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;)}"

if [ -z "$SSH_PASSWORD" ]; then
    echo "SSH_PASSWORD: $_password"
fi

echo "{{ stealthbox.ssh.login }}:$_password" | chpasswd

unset SSH_PASSWORD

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e