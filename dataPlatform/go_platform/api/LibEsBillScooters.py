import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsBillScooters(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_bill_scooters_post(self, es_bill_id, es_contract_id, scooter_id,
                              date_from, date_to, suspend_days=0,
                              resource_type=None, resource_id=None,
                              other_data=None, amount=None, account=None):
        """ Add the bill

        Examples:
        | ${resp} = | Es Bill Scooters Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "es_bill_id": es_bill_id,
                    "es_contract_id": es_contract_id,
                    "scooter_id": scooter_id,
                    "date_from": date_from,
                    "date_to": date_to,
                    "suspend_days": suspend_days,
                    "details": [
                        {
                            "resource_type": resource_type,
                            "resource_id": resource_id,
                            "other_data": other_data,
                            "amount": amount
                        }
                    ]
                }
            ]
        }
        resp = self.init.request('post', "/es-bill-scooters", json=data)
        return resp
