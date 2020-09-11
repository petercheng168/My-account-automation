import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _auth_init_ import _init_


class LibUsers(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def users_global_get(self, user_email=None, login_phone=None, user_id=None,
                         account=None):
        """ Get users
        Examples:
        | ${resp} = | Users Global Get | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "get",
            "get_data": {
                "user_id": user_id,
                "user_email": user_email,
                "login_phone": login_phone
            }
        }
        resp = self.init.request('post', "/users", json=data)
        return resp
