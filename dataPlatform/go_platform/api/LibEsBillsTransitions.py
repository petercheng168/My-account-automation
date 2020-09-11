import os
import sys
from robot.libraries.BuiltIn import BuiltIn
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsBillsTransitions(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_bills_transitions_update(self, bill_status, es_bill_ids=[], bill_period=None, date_from=None,
                                    date_to=None, issue_date=None, over_due_paid_receive_date=None, latest_bill_calc_end_date=None, account=None):
        """ Update the bills transitions """
        self.init.authHeader(account)
        print(bill_status, es_bill_ids, bill_period, date_from, date_to, issue_date, over_due_paid_receive_date)
        es_bill_ids = es_bill_ids.split(',') if es_bill_ids else es_bill_ids
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "es_bill_id_list": es_bill_ids,
                    "bill_period": bill_period,
                    "date_from": date_from,
                    "date_to": date_to,
                    "bill_status": bill_status,
                    "issue_date": issue_date,
                    "over_due_paid_receive_date": over_due_paid_receive_date,
                    "latest_bill_calc_end_date": latest_bill_calc_end_date
                }
            ]
        }
        resp = self.init.request('post', "/es-bills/transitions", json=data)
        return resp
