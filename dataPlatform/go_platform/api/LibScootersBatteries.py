import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibScootersBatteries(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def scooters_batteries_get(self, scooter_ids, account=None):
        """ Get scooter batteries info

        Examples:
        | ${resp} = | Scooters Batteries Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "scooter_ids": [scooter_ids],
                "snap_time_from": 0,
                "snap_time_to": 0,
                "current": 1,
                "pagination_criteria": {
                    "offset": 0,
                    "limit": 2
                }
            }
        }
        resp = self.init.request('post', "/scooters/batteries", json=data)
        return resp
