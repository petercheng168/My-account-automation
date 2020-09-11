import os
import sys
import jsonref
import jsonschema
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from lib.LibVar import LibVar


class LibJSONSchema:

    def __init__(self):
        self.variable = LibVar()
        self.schema_location = self.variable.get_var('PAYMENT_GATEWAY_SCHEMA_PATH')

    def load_json_schema(self, filename):
        """ Loads the given schema file """
        absolute_path = '{}/{}'.format(self.schema_location, filename)
        with open(absolute_path) as schema_file:
            schemas_file = schema_file.read()
            return jsonref.loads(schemas_file, jsonschema=True)

    def verify_schema(self, schema_filename, schema_name, sample, status_code=None):
        """Validates the sample JSON against the given schema."""
        schema = self.load_json_schema(schema_filename)
        if status_code is None:
            schema = schema[schema_name]
        else:
            schema = schema[schema_name][status_code]
        try:
            jsonschema.validate(sample, schema)
        except jsonschema.ValidationError as e:
            print(sample)
            raise jsonschema.ValidationError(
                'Validation error for schema {}: {}'.format(schema_name, e.message))
