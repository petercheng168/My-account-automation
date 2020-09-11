import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _auth_init_ import _init_


class LibSiteMaps(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def site_maps_get(self, country_code=None, service_types=None, account=None):
        """ Get site maps redirect url
        Examples:
        | ${resp} = | Site Maps Get | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "get",
            "get_data": {
                "country_code": country_code,
                "service_types": service_types
            }
        }
        resp = self.init.request('post', "/site-maps", json=data)
        return resp