from robot.libraries.BuiltIn import BuiltIn
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsContractsAddons(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_contracts_addons_get(self, es_contract_id, time_from=None,
                                time_to=None, account=None):
        """ Get addons which is under the contracts id

        Examples:
        | ${resp} = | Es Contracts Addons Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "es_contract_id": es_contract_id,
                "time_from": time_from,
                "time_to": time_to
            }
        }
        resp = self.init.request('post', "/es-contracts/addons", json=data)
        return resp
