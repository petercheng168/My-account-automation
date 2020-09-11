import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibPartsPrices(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def parts_prices_post(self, part_code=None, price_type=None, amount=None, currency=None, account=None):
        """ Create Parts Prices

        Examples:
        | ${resp} = | Parts Prices Create | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "part_code": part_code,
                    "price_type": price_type,
                    "amount": amount,
                    "currency": currency
                }
            ]
        }
        resp = self.init.request('post', "/parts/prices", json=data)
        return resp

    def parts_prices_update(self, part_code=None, price_type=None, amount=None, currency=None, account=None):
        """ Update Parts Prices

        Examples:
        | ${resp} = | Parts Prices Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "part_code": part_code,
                    "price_type": price_type,
                    "amount": amount,
                    "currency": currency
                }
            ]
        }
        resp = self.init.request('post', "/parts/prices", json=data)
        return resp
