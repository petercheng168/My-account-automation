import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibSmartWheel:

    def __init__(self):
        self.init = _init_()

    def swa_add(self, swa_guid, atmel_key, atmel_sn, ble_name, mainboard_sn, state, status, company_code=None,
                account=None):
        """ Add Smart wheel data """
        self.init.authHeader(account)
        data = {
            'op_code': 'add',
            'add_data': {
                'swa_guid': swa_guid,
                'atmel_key': atmel_key,
                'atmel_sn': atmel_sn,
                'ble_name': ble_name,
                'mainboard_sn': mainboard_sn,
                'state': state,
                'status': status,
                'company_code': company_code
            }
        }

        resp = self.init.request('post', "/swa", json=data)

        return resp

    def swa_get(self, ble_name, account=None):
        """ Get Smart wheel data """
        self.init.authHeader(account)
        data = {
            'op_code': 'get',
            'get_data': {
                'ble_name': ble_name
            }
        }

        resp = self.init.request('post', "/swa", json=data)

        return resp
