import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibScootersStateHistories(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def scooters_state_histories_get(self, scooter_ids, state_type, time_from=None, time_to=None, sort_order=None, account=None):
        """ Get scooter's state history

        Examples:
        | ${resp} = | Scooters Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "scooter_id_list": [
                    scooter_ids
                ],
                "type": state_type,
                "time_from": time_from,
                "time_to": time_to,
                "sort_order": sort_order
            }
        }
        resp = self.init.request('post', "/scooters/state-histories", json=data)
        return resp
