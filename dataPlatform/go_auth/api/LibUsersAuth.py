import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _auth_init_ import _init_


class LibUsersAuth(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def users_auth_get(self, user_email=None, login_phone=None, password=None,
                       account=None):
        """ Get users auth info
        Examples:
        | ${resp} = | Users Auth Get | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "get",
            "get_data": {
                "user_email": user_email,
                "login_phone": login_phone,
                "password": password
            }
        }
        resp = self.init.request('post', "/users/auth", json=data)
        return resp
