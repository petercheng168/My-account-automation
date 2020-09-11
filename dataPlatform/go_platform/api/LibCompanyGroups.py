import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibCompanyGroups(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def company_groups_get(self, company_group_id=None, company_group_name=None, account=None):
        """ Get Company Groups info

        Examples:
        | ${resp} = | Company Groups Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "company_group_id": company_group_id,
                "company_group_name": company_group_name
            }
        }
        resp = self.init.request('post', "/company-groups", json=data)
        return resp

    def company_groups_add(self, company_group_name=None, company_group_code=None, data_company_code=None, company_list=[], account=None):
        """ Create Company Groups

        Examples:
        | ${resp} = | Company Groups Add | data |
        """
        self.init.authHeader(account)
        company_list = company_list.split(',') if company_list else company_list
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "company_group_name": company_group_name,
                    "company_group_code": company_group_code,
                    "data_company_code": data_company_code,
                    "company_list": company_list
                }
            ]
        }
        resp = self.init.request('post', "/company-groups", json=data)
        return resp

    def company_groups_update(self, company_group_id=None, company_group_name=None, company_list_add=[], company_list_remove=[], account=None):
        """Update Company Groups

        Examples:
        | ${resp} = | Company Groups Update | data |
        """
        self.init.authHeader(account)
        company_list_add = company_list_add.split(',') if company_list_add else company_list_add
        company_list_remove = company_list_remove.split(',') if company_list_remove else company_list_remove
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "company_group_id": company_group_id,
                    "company_group_name": company_group_name,
                    "company_list_add": company_list_add,
                    "company_list_remove": company_list_remove
                }
            ]
        }
        resp = self.init.request('post', "/company-groups", json=data)
        return resp
