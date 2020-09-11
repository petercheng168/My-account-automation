import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibCoscContractUsersHistories(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def cosc_contract_users_histories_get(self, request_data_type, user_ids=[],
                                          update_time_from=None,
                                          update_time_to=None, offset=None,
                                          limit=None, account=None):
        """Get cosc contract users histories
        Examples:
        | ${resp} = | Cosc Contract Users Histories Get | data |
        """
        self.init.authHeader(account)
        user_ids = user_ids.split(',') if user_ids else user_ids
        data = {
            "op_code": "get",
            "get_data": {
                "user_id_list": user_ids,
                "request_data_type": request_data_type,
                "update_time_from": update_time_from,
                "update_time_to": update_time_to,
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request(
            'post', "/cosc/contract-users/histories", json=data)
        return resp
