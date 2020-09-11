import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsContractsBalancesTransactions(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_contracts_balances_transactions_get(self, es_contract_id, transaction_type=None, source_id=None, scooter_id=None, by_emp_id=None,
                                                create_time_from=None, create_time_to=None, order=None, offset=None, limit=None, account=None):
        """ Get contracts balances which is under es contracts ids
        Examples:
        | ${resp} = | Es Contracts Balances Transactions Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "es_contract_id": es_contract_id,
                "transaction_type": transaction_type,
                "source_id": source_id,
                "scooter_id": scooter_id,
                "by_emp_id": by_emp_id,
                "create_time_from": create_time_from,
                "create_time_to": create_time_to,
                "order": order,
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request('post', "/es-contracts/balances/transactions", json=data)
        return resp
