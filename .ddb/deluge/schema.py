from ddb.feature.schema import FeatureSchema
from marshmallow import fields


class DelugeSchema(FeatureSchema):
    password = fields.String(required=False, allow_none=True, load_default=None, dump_default=None)
    sha1 = fields.String(required=False, allow_none=True, load_default=None, dump_default=None)
    salt = fields.String(required=False, allow_none=True, load_default=None, dump_default=None)
