#!/usr/bin/python

import ConfigParser
import StringIO

import sys

if __name__ == "__main__":
    config = ConfigParser.RawConfigParser()

    conf = ""
    while True:
        try:
            line = sys.stdin.readline()
        except KeyboardInterrupt:
            break

        conf += line

        if not line:
            break

    conf_file = StringIO.StringIO(conf)
    config.readfp(conf_file)
    config.write(sys.stdout)
