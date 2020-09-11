import os
import sys
import json
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_
from robot.api import logger

class LibDepartments(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def departments_get(self, company_id=None, departments_id=None, department_code=None, department_name=None,
                        department_type=None, country_code=None, status=None, pagination_criteria=None,
                        account=None):
        """ Get departments information
        Examples:
        | ${resp} = | Departments Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "company_id": company_id,
                "department_id": departments_id,
                "department_code": department_code,
                "department_name": department_name,
                "department_type": department_type,
                "country_code": country_code,
                "status": status,
                "pagination_criteria": pagination_criteria
            }
        }
        resp = self.init.request('post', "/departments", json=data)
        return resp

    def departments_add(self, department_code=None, department_name=None, department_type=None,
                        owner_company_id=None, contract_start_date=None, contract_expiration_date=None,
                        contact_address=None, contact_zip=None, contact_person=None, contact_email=None,
                        contact_phone1=None, contact_phone2=None, country_code=None, status=None, account=None):
        """ Add departments information
        Examples:
        | ${resp} = | Department Add | data |
        """
        
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
              {
                "department_code": department_code,
                "department_name": department_name,
                "department_type": json.loads(department_type),
                "owner_company_id": owner_company_id,
                "contract_start_date": contract_start_date,
                "contract_expiration_date": contract_expiration_date,
                "contact_address": contact_address,
                "contact_zip": contact_zip,
                "contact_person": contact_person,
                "contact_email": contact_email,
                "contact_phone1": contact_phone1,
                "contact_phone2": contact_phone2,
                "country_code": country_code,
                "status": status
              }
            ]
        }
        resp = self.init.request('post', "/departments", json=data)
        return resp

    def departments_update(self, department_id=None, department_code=None, department_name=None,
                        department_type=None, contract_start_date=None, contract_expiration_date=None, contact_address=None,
                        contact_zip=None, contact_person=None, contact_email=None, contact_phone1=None, contact_phone2=None,
                        country_code=None, status=None, account=None):
        """ Update departments information
        Examples:
        | ${resp} = | Department Update | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                  "department_id": department_id,
                  "department_code": department_code,
                  "department_name": department_name,
                  "department_type": json.loads(department_type),
                  "contract_start_date": contract_start_date,
                  "contract_expiration_date": contract_expiration_date,
                  "contact_address": contact_address,
                  "contact_zip": contact_zip,
                  "contact_person": contact_person,
                  "contact_email": contact_email,
                  "contact_phone1": contact_phone1,
                  "contact_phone2": contact_phone2,
                  "country_code": country_code,
                  "status": status
                }
            ]
        }
        resp = self.init.request('post', "/departments", json=data)
        return resp