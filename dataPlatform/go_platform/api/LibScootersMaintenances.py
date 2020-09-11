import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_
from robot.api import logger


class LibScootersMaintenances(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def scooters_maintenances_get_via_assembled_date(self,
                                                     assembled_date_from=None,
                                                     assembled_date_to=None,
                                                     account=None,
                                                     **kwargs):
        """ Get scooter info

        Examples:
        | ${resp} = | Scooters Maintenances Get Via Assembled Date | data |
        """
        self.init.authHeader(account, **kwargs)
        data = {
            "op_code": "get",
            "get_data": {
                "assembled_date_from": assembled_date_from,
                "assembled_date_to": assembled_date_to
            }
        }
        resp = self.init.request('post', "/scooters/maintenances", json=data)
        return resp
