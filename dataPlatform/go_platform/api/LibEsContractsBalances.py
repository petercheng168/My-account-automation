import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsContractsBalances(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_contracts_balances_get(self, es_contract_ids=[], account=None):
        """ Get contracts balances which is under es contracts ids

        Examples:
        | ${resp} = | Es Contracts Balances Get | data |
        """
        self.init.authHeader(account)
        es_contract_ids = es_contract_ids.split(
            ',') if es_contract_ids else es_contract_ids
        data = {
            "op_code": "get",
            "get_data": {
                "es_contract_id_list": es_contract_ids
            }
        }
        resp = self.init.request('post', "/es-contracts/balances", json=data)
        return resp

    def es_contracts_balances_update(self, es_contract_id,
                                     es_contract_code=None,
                                     transaction_type=None, amount=None,
                                     source_id=None, description=None,
                                     scooter_id=None, account=None):
        """ Update contracts with balances which is under es contracts ids

        Examples:
        | ${resp} = | Es Contracts Balances Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "es_contract_id": es_contract_id,
                    "es_contract_code": es_contract_code,
                    "transaction_type": transaction_type,
                    "amount": amount,
                    "source_id": source_id,
                    "description": description,
                    "scooter_id": scooter_id
                }
            ]
        }
        resp = self.init.request('post', "/es-contracts/balances", json=data)
        return resp
