import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibScooterTransfers(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def scooter_transfers_update(self, vin, orig_driver_id, orig_owner_id, orig_plate, new_plate,
                                new_driver_id, new_owner_id, sing_date, new_plate_date=None, account=None):
        """This endpoint is used for scooter transfer.

        Examples:
        | ${resp} = | Scooter Transfers Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "scooter_vin": vin,
                    "original_driver_id": orig_driver_id,
                    "original_owner_id": orig_owner_id,
                    "original_plate": orig_plate,
                    "new_driver_id": new_driver_id,
                    "new_owner_id": new_owner_id,
                    "new_plate": new_plate,
                    "new_plate_date": new_plate_date,
                    "sing_date": sing_date,
                    "auto_dfu": 1,
                    "sport_mode": 1
                }
            ]
        }

        resp = self.init.request('post', "/scooter-transfers", json=data)
        return resp
