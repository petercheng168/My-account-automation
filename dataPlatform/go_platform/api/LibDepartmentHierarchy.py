import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibDepartmentHierarchy(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def department_hierarchy_update(self, department_id=None, origin_parent_department_id=None, target_parent_department_id=None, account=None):
        """ Add departments hierarchy
        Examples:
        | ${resp} = | Department Hierarchy Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                  "department_id": department_id,
                  "origin_parent_department_id": origin_parent_department_id,
                  "target_parent_department_id": target_parent_department_id
                }
            ]
        }
        resp = self.init.request('post', "/department-hierarchy", json=data)
        return resp

    def department_hierarchy_get(self, target_company_id=None,
                                 underneath_department_id=None,
                                 department_type=None, account=None):
        """ Get departments hierarchy
        Examples:
        | ${resp} = | Department Hierarchy Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "target_company_id": target_company_id,
                "underneath_department_id": underneath_department_id,
                "department_type": department_type
            }
        }
        resp = self.init.request('post', "/department-hierarchy", json=data)
        return resp
