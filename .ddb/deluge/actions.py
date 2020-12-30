import hashlib
from random import getrandbits
from typing import Union, Iterable, Callable

from ddb.action import Action
from ddb.action.action import EventBinding
from ddb.config import config
from ddb.event import events


class Password(Action):
    @property
    def event_bindings(self) -> Union[Iterable[Union[Callable, str, EventBinding]], Union[Callable, str, EventBinding]]:
        return events.main.start

    @property
    def name(self) -> str:
        return "deluge:password"

    def execute(self, command: str):
        password = config.data.get('stealthbox.deluge.password')

        sha1 = config.data.get('stealthbox.deluge.sha1')
        salt = config.data.get('stealthbox.deluge.salt')

        if password and (not sha1 or not salt):
            salt = hashlib.sha1(str(getrandbits(40)).encode("utf-8")).hexdigest()
            config.data['stealthbox.deluge.salt'] = salt

            s = hashlib.sha1(salt.encode("utf-8"))
            s.update(password.encode("utf-8"))
            sha1 = s.hexdigest()
            config.data['stealthbox.deluge.sha1'] = sha1
