#!/usr/bin/env python3

import hashlib
import os
import re
from argparse import ArgumentParser, Namespace
from pathlib import Path
from random import getrandbits


def main(args: Namespace):
    if args.password:
        set_password(args.filepath, args.password)
    elif args.sha1 and args.salt:
        set_sha1_and_salt(args.filepath, args.sha1, args.salt)
    else:
        raise ValueError("Either password or sha1/salt should be defined to set the password.")


def set_password(filepath: str, password: str):
    salt = hashlib.sha1(str(getrandbits(40)).encode("utf-8")).hexdigest()

    s = hashlib.sha1(salt.encode("utf-8"))
    s.update(password.encode("utf-8"))
    sha1 = s.hexdigest()

    return set_sha1_and_salt(filepath, sha1, salt)


def set_sha1_and_salt(filepath: str, sha1: str, salt: str):
    if not os.path.exists(filepath):
        raise IOError("Not exists")

    content = Path(filepath).read_text()

    salt_regex = r'("pwd_salt": *")(.+?)(")'
    sha1_regex = r'("pwd_sha1": *")(.+?)(")'

    content = re.sub(sha1_regex, r'\g<1>' + sha1 + r'\g<3>', content)
    content = re.sub(salt_regex, r'\g<1>' + salt + r'\g<3>', content)

    Path(filepath).write_text(content)


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('filepath', default='/config/web.conf')
    parser.add_argument('--password')
    parser.add_argument('--sha1')
    parser.add_argument('--salt')

    args = parser.parse_args()

    main(args)
