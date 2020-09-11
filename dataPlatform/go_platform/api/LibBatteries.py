import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibBatteries(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def batteries_get(self, sn=None, guid=None, guid_list=None, offset=None,
                      limit=None, account=None):
        """ Get batteries info by sn"""
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "search_criteria": {
                    "sn": sn,
                    "guid": guid,
                    "guid_list": guid_list
                },
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request('post', "/batteries", json=data)
        return resp

    def batteries_post(self, battery_guid, battery_sn, charge_cycles, state,
                       manufacture_date, pn, account=None):
        """ Create batteries

        Examples:
        | ${resp} = | Batteries Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "battery_guid": battery_guid,
                    "battery_sn": battery_sn,
                    "company_code": "1300",
                    "charge_cycles": charge_cycles,
                    "asset_type": "string",
                    "asset_owner": "string",
                    "state": state,
                    "version": "string",
                    "supplier": "string",
                    "country_code": "TW",
                    "manufacture_date": manufacture_date,
                    "stock_in_date": "string",
                    "stock_out_date": "string",
                    "pn": pn,
                    "model_no": "string",
                    "manufacture_sn": "string",
                    "mainboard_pn": "string",
                    "mainboard_sn": "string",
                    "bb1_pn": "string",
                    "bb1_sn": "string",
                    "bb2_pn": "string",
                    "bb2_sn": "string",
                    "bb3_pn": "string",
                    "bb3_sn": "string",
                    "fpc_pn": "string",
                    "fpc_sn": "string",
                    "weight": "string"
                }
            ]
        }
        resp = self.init.request('post', "/batteries", json=data)
        return resp
