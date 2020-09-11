import os
import sys
from robot.api import logger
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_

class LibCompaniesCreditLimits(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def companies_creditlimits_post(self, company_code=None, parts_limit=None, scooter_limit=None,
                 customer_care_limit=None, currency=None, account=None):
        """ Create company credit limit
        Examples:
        | ${resp} = | Companies Creditlimit Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "company_code": company_code,
                    "parts_limit": parts_limit,
                    "scooter_limit": scooter_limit,
                    "customer_care_limit": customer_care_limit,
                    "currency": currency
                }
            ]
        }
        resp = self.init.request('post', '/companies/credit-limits', json=data)
        return resp

    def companies_creditlimits_update(self, company_code=None, parts_limit=None, scooter_limit=None,
                 customer_care_limit=None, currency=None, account=None):
        """ Update company credit limit
        Examples:
        | ${resp} = | Companies Creditlimit Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "company_code": company_code,
                    "parts_limit": parts_limit,
                    "scooter_limit": scooter_limit,
                    "customer_care_limit": customer_care_limit,
                    "currency": currency
                }
            ]
        }
        resp = self.init.request('post', '/companies/credit-limits', json=data)
        return resp

    def companies_creditlimits_post_batch(self, add_data_list=None, account=None):
        """ Create company credit limit
        Examples:
        | ${resp} = | Companies Creditlimit Post | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": add_data_list
        }
        resp = self.init.request('post', '/companies/credit-limits', json=data)
        return resp