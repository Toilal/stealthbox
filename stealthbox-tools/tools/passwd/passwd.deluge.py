#!/usr/bin/python

import hashlib
import random

import sys


def getDelugeHashSalt(passwd):
    salt = hashlib.sha1(str(random.getrandbits(40))).hexdigest()
    s = hashlib.sha1(salt)
    s.update(passwd)
    return (s.hexdigest(), salt)

if __name__ == "__main__":
    if len(sys.argv) <= 1:
        print("No password provided")
        sys.exit(1)
    r = getDelugeHashSalt(sys.argv[1])
    print(r[0] + ':' + r[1]) # pwd_sha1:pwd_salt