#!/usr/bin/python

import subprocess
import hashlib
import random

def getPydioHash(passwd):
    return subprocess.check_output(['php', '-f', 'passwd.pydio.php', 'password=%s' % passwd])

def getDelugeHashSalt(passwd):
    salt = hashlib.sha1(str(random.getrandbits(40))).hexdigest()
    s = hashlib.sha1(salt)
    s.update(passwd)
    return (s.hexdigest(), salt)

if __name__ == "__main__":
    print("-----------------------")
    print("[Pydio]")
    pydio_hash = getPydioHash("box12345")
    print("hash: %s" % pydio_hash);
    print("-----------------------")
    print("");

    print("-----------------------")
    print("[Deluge]")
    deluge_sha1, deluge_salt = getDelugeHashSalt("box12345")
    print("sha1: %s" % deluge_sha1);
    print("salt: %s" % deluge_salt);
    print("-----------------------")
    print("");