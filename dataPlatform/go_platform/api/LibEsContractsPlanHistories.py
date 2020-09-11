import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsContractsPlanHistories(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_contracts_plan_histories_get(self, es_contract_id, time_from=None, time_to=None,
                                    sort_order=None, offset=0, limit=100, account=None):
        """Get es contracts plan history

        Examples:
        | ${resp} = | Es Contracts Plan Histories Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "es_contract_id": es_contract_id,
                "time_from": time_from,
                "time_to": time_to,
                "sort_order": sort_order,
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request('post', "/es-contracts/plan-histories", json=data)
        return resp
