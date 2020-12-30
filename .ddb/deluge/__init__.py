from typing import Iterable, ClassVar

from ddb.action import Action
from ddb.feature import Feature

from .actions import Password
from .schema import DelugeSchema


class DelugedFeature(Feature):
    @property
    def name(self) -> str:
        return "deluge"

    @property
    def dependencies(self) -> Iterable[str]:
        return ["core"]

    @property
    def schema(self) -> ClassVar[DelugeSchema]:
        return DelugeSchema

    @property
    def actions(self) -> Iterable[Action]:
        return (Password(),)
