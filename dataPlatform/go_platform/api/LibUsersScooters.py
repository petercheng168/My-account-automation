import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibUsersScooters(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def users_scooters_get(self, user_id, account=None, brand_company_code=None):
        """ Get all scooters which is owner by the user id """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "user_id": user_id,
                "brand_company_code": brand_company_code
            }
        }
        resp = self.init.request('post', "/users/scooters", json=data)
        return resp
