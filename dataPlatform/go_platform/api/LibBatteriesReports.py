import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibBatteriesReports(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def batteries_reports_get(self, users=[], battery_sn_list=[],
                              create_time_from=None, create_time_to=None,
                              offset=None, limit=None, account=None):
        """Get Batteries Report information.
        Examples:
        | ${resp} = | Batteries Reports Get | data |
        """
        self.init.authHeader(account)
        users = users.split(',') if users else users
        battery_sn_list = battery_sn_list.split(
            ',') if battery_sn_list else battery_sn_list
        data = {
            "op_code": "get",
            "get_data": {
                "users": users,
                "battery_sn_list": battery_sn_list,
                "create_time_from": create_time_from,
                "create_time_to": create_time_to,
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request('post', "/batteries/reports", json=data)
        return resp

    def batteries_reports_post(self, time, login_user, battery_sn, cmd_id,
                               cmd_val, log_path, description=None,
                               account=None):
        """Create Batteries Reports.
        Examples:
        | ${resp} = | Batteries Reports Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "time": time,
                    "login_user": login_user,
                    "battery_sn": battery_sn,
                    "status_cmds": [
                        {
                            "cmd_id": cmd_id,
                            "cmd_val": cmd_val
                        }
                    ],
                    "description": description,
                    # "/log_2020_03_09_07_33_56_086_afc639a3-98e1-454c-b255-504a8ad6c09e.zip"
                    "log_path": log_path
                }
            ]
        }
        resp = self.init.request('post', "/batteries/reports", json=data)
        return resp
