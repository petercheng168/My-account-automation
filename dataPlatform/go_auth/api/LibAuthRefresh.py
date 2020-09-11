import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _auth_init_ import _init_


class LibAuthRefresh(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def auth_refresh_add(self, user_id, auth_client_id, expiration_time, refresh_token_guid=None, account=None):
        """Create Auth Client
        Examples:
        | ${resp} = | Auth Refresh Add | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "add",
            "add_data": {
                "user_id": user_id,
                "auth_client_id": auth_client_id,
                "expiration_time": expiration_time,
                "refresh_token_guid": refresh_token_guid
            }
        }
        resp = self.init.request('post', "/auth-refresh", json=data)
        return resp

    def auth_refresh_get(self, user_id=None, refresh_token_id=None, refresh_token_guid=None, account=None):
        """Get Auth Client
        Examples:
        | ${resp} = | Auth Refresh Get | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "get",
            "get_data": {
                "refresh_token_id": refresh_token_id,
                "refresh_token_guid": refresh_token_guid,
                "user_id": user_id
            }
        }
        resp = self.init.request('post', "/auth-refresh", json=data)
        return resp
