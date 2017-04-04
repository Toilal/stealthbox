#!/usr/bin/python

from deluge.config import Config

import hashlib
import random

import sys

def getDelugeHashSalt(passwd):
    salt = hashlib.sha1(str(random.getrandbits(40))).hexdigest()
    s = hashlib.sha1(salt)
    s.update(passwd)
    return (s.hexdigest(), salt)


def updateWebPassword(password):
    c = Config("web.conf", None, "data/config")
    c["pwd_sha1"], c["pwd_salt"] = getDelugeHashSalt(password)
    c.save()

if __name__ == "__main__":
    if len(sys.argv) <= 1:
        print("No password provided")
        sys.exit(1)
    r = updateWebPassword(sys.argv[1])