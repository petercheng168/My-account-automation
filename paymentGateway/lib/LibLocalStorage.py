import yaml
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from lib.LibVar import LibVar


class LibLocalStorage:

    def __init__(self):
        self.variable = LibVar()
        self.info_yaml = self.variable.get_var('PAYMENT_GATEWAY_LOCAL_STORAGE')

    def open_yaml(self):
        with open(self.info_yaml) as file:
            contents = yaml.safe_load(file)

        return contents

    @staticmethod
    def get_user_info(account_type, key):
        """ Get the value from key in the user_info.yml """
        contents = LibLocalStorage().open_yaml()

        account_type = account_type.lower()
        value = contents[account_type][key]

        return value

    def update_user_info(self, account_type, response_json, status_code):
        """ Update the value from key in the user_info.yml """
        contents = LibLocalStorage().open_yaml()

        account_type = account_type.lower()

        url = response_json['resultData']['prepayId']

        if status_code == 200 and 'O2OgwApi' in url:
            contents[account_type]['card_auth_url'] = url
        elif status_code == 200 and 'tspgapi' in url:
            contents[account_type]['3d_verification_url'] = url

        with open(self.info_yaml, 'w') as file:
            yaml.dump(contents, file, default_flow_style=False)

    def update_es_bill_info(self, **kwargs):
        """ Update the ES bill info in the user_info.yml """
        contents = LibLocalStorage().open_yaml()

        for input_key, input_value in kwargs.items():
            for yaml_key in contents['pg_es_bill_info']:
                if input_key == yaml_key:
                    contents['pg_es_bill_info'][yaml_key] = input_value

        with open(self.info_yaml, 'w') as file:
            yaml.dump(contents, file, default_flow_style=False)

    @staticmethod
    def get_es_bill_info():
        es_bill_dict = {}
        contents = LibLocalStorage().open_yaml()

        for yaml_key in contents['pg_es_bill_info']:
            es_bill_dict[yaml_key] = contents['pg_es_bill_info'][yaml_key]

        return es_bill_dict

    @staticmethod
    def write_multiple_es_bill_info(**kwargs):
        with open('es_bill.log', 'a') as file:
            for input_key, input_value in kwargs.items():
                file.write(str(input_key) + ':' + str(input_value) + '\n')

            file.write('----------------------------------------------\n')
            file.close()
