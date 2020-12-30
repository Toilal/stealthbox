from ddb.feature.schema import FeatureSchema
from marshmallow import fields


class DelugeSchema(FeatureSchema):
    password = fields.String(required=False, allow_none=True, default=None)
    sha1 = fields.String(required=False, allow_none=True, default=None)
    salt = fields.String(required=False, allow_none=True, default=None)
