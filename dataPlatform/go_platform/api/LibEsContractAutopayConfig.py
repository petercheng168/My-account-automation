from robot.libraries.BuiltIn import BuiltIn
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsContractAutopayConfig(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_contract_autopay_config_get(self, es_contract_id, account=None):
        """ Get es contract autopay config information """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "es_contract_id": es_contract_id
            }
        }
        resp = self.init.request('post', "/es-contract-autopay-config", json=data)
        return resp

    def es_contract_autopay_config_post(self, es_contract_id, account_name, account_num,
                                        bank_code, profile_id, status, account=None):
        """ Create es contract autopay config
        This status is 0: Disable 1: Active 2: Processing 3: Received 4. Failed
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "es_contract_id": es_contract_id,
                    "account_name": account_name,
                    "account_num": account_num,
                    "bank_code": bank_code,
                    "bank_user_auth_code": "",
                    "account_owner_profile_id": profile_id,
                    "application_date": None,
                    "effective_date": None,
                    "status": status
                }
            ]
        }
        resp = self.init.request('post', "/es-contract-autopay-config", json=data)
        return resp

    def es_contract_autopay_config_update(self, es_contract_id, account_name, account_num,
                                        bank_code, profile_id, status, account=None):
        """ Update es contract autopay config """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "es_contract_id": es_contract_id,
                    "account_name": account_name,
                    "account_num": account_num,
                    "bank_code": bank_code,
                    "bank_user_auth_code": "",
                    "account_owner_profile_id": profile_id,
                    "application_date": None,
                    "effective_date": None,
                    "status": status
                }
            ]
        }
        resp = self.init.request('post', "/es-contract-autopay-config", json=data)
        return resp