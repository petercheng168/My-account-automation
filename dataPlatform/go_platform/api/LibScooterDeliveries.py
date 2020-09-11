import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibScooterDeliveries(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def scooter_deliveries_update(self, scooter_contract_id, vin, plate,
                                  birthday, es_contract_id=None,
                                  new_plate=None, new_plate_date=None,
                                  account=None):
        """This endpoint is used for scooter delivery.

        Examples:
        | ${resp} = | Scooter Deliveries Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": {
                "scooter_contract_id": scooter_contract_id,
                "current_vin": vin,
                "current_plate": plate,
                "new_plate": new_plate,
                "new_plate_date": new_plate_date,
                "new_sing_date": birthday
            }
        }
        if es_contract_id:
            del data['update_data']['scooter_contract_id']
            data['update_data']['es_contract_id'] = es_contract_id

        resp = self.init.request('post', "/scooter-deliveries", json=data)
        return resp
