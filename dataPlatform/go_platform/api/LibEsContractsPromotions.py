from robot.libraries.BuiltIn import BuiltIn
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsContractsPromotions(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_contracts_promotions_get(self, es_contract_id, time_from=None,
                                    time_to=None, account=None):
        """ Get promostions which is under the contracts id
        Examples:
        | ${resp} = | Es Contracts Promotions Get | data |
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
        resp = self.init.request('post', "/es-contracts/promotions", json=data)
        return resp

    def es_contracts_promotions_update(self, es_contract_id, promotion_id,
                                       start_date, end_date=None, account=None):
        """Update es-contracts promotions end_date, the key is ()

        Args:
            es_contract_id (str): hashed es-contract id (key)
            promotion_id (str): hashed promotion id (key)
            start_date (int): timestamp (key)
            end_date (int): timestamp (modify field)

        Examples:
        | ${resp} = | Es Contracts Promotions Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [{
                "es_contract_id": es_contract_id,
                "promotion_id": promotion_id,
                "start_date": start_date,
                "end_date": end_date
            }]
        }
        resp = self.init.request('post', "/es-contracts/promotions", json=data)
        return resp
