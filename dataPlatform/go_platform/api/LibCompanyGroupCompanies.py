import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibCompanyGroupCompanies(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def company_group_companies_get(self, company_group_id=None, account=None):
        """ Get Companies By Company Group info

        Examples:
        | ${resp} = | Company Group Companies Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "company_group_id": company_group_id
            }
        }
        resp = self.init.request('post', "/company-group/companies", json=data)
        return resp
