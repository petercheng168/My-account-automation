import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsContractsHistories(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_contracts_histories_get(self, es_contract_id, contract_owner_id, es_contract_code=None, order=None, offset=None, limit=None, account=None):
        """Get es contract information.
        Examples:
        | ${resp} = | Es Contracts Histories Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "es_contract_id": es_contract_id,
                "es_contract_code": es_contract_code,
                "contract_owner_id": contract_owner_id,
                "order": order,
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request('post', "/es-contracts/histories", json=data)
        return resp
