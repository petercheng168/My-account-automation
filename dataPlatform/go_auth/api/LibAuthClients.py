import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _auth_init_ import _init_


class LibAuthClients(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def auth_clients_add(self, client_guid, trusted, support_grant_type, client_app_id=None, secret=None, redirect_uri=None, description=None, account=None):
        """Create Auth Client
        Examples:
        | ${resp} = | Auth Clients Add | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "client_guid": client_guid,
                    "client_app_id": client_app_id,
                    "secret": secret,
                    "trusted": trusted,
                    "redirect_uri": redirect_uri,
                    "support_grant_type": support_grant_type,
                    "description": description
                }
            ]
        }
        resp = self.init.request('post', "/auth-clients", json=data)
        return resp

    def auth_clients_get(self, auth_client_ids=None, client_guids=None, client_app_ids=None, account=None):
        """Get Auth Client
        Examples:
        | ${resp} = | Auth Clients Get | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "get",
            "get_data": {
                "auth_client_ids": auth_client_ids,
                "client_guids": client_guids,
                "client_app_ids": client_app_ids
            }
        }
        resp = self.init.request('post', "/auth-clients", json=data)
        return resp

    def auth_clients_update(self, client_id=None, client_guid=None, client_app_id=None, secret=None, trusted=None, redirect_uri=None, support_grant_type=None, description=None, account=None):
        """Update Auth Client
        Examples:
        | ${resp} = | Auth Clients Update | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "client_id": client_id,
                    "client_guid": client_guid,
                    "client_app_id": client_app_id,
                    "secret": secret,
                    "trusted": trusted,
                    "redirect_uri": redirect_uri,
                    "support_grant_type": support_grant_type,
                    "description": description
                }
            ]
        }
        resp = self.init.request('post', "/auth-clients", json=data)
        return resp
