#!/usr/bin/python

from deluge.config import Config

import sys

def updateHostPassword(password):
    c = Config("hostlist.conf.1.2", None, "data/config")
    for host in c["hosts"]:
        if host[0] == "default":
            host[4] = password
    c.save()

if __name__ == "__main__":
    if len(sys.argv) <= 1:
        print("No password provided")
        sys.exit(1)
    r = updateHostPassword(sys.argv[1])