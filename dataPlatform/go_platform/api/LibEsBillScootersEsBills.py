import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsBillScootersEsBills(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_bill_scooters_es_bills_get(self,
                                      scooter_id=None, es_contract_id=None,
                                      payment_status=None, bill_period=None,
                                      issue_date_from=None, issue_date_to=None,
                                      due_date_from=None, due_date_to=None,
                                      bill_status_list=None, order=None,
                                      offset=None, limit=None, account=None):
        """ Get the scooter's es bill
        Args:
            bill_status_list (list)

        Examples:
        | ${resp} = | Es Bill Scooters Es Bills Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "scooter_id": scooter_id,
                "es_contract_id": es_contract_id,
                "payment_status": payment_status,
                "bill_period": bill_period,
                "issue_date_from": issue_date_from,
                "issue_date_to": issue_date_to,
                "due_date_from": due_date_from,
                "due_date_to": due_date_to,
                "bill_status_list": bill_status_list,
                "order": order,
                "offset": offset,
                "limit": limit
            }
        }
        resp = self.init.request(
            'post', "/es-bill-scooters/es-bills", json=data)
        return resp
