import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibCompanies(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def companies_get(self,
                      company_id=None,
                      company_code=None,
                      company_name=None,
                      country_code=None,
                      status=None,
                      pagination_criteria_offset=None,
                      pagination_criteria_limit=None,
                      account=None):
        """ Get companies info

        Examples:
        | ${resp} = | Companies Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "company_id": company_id,
                "company_code": company_code,
                "company_name": company_name,
                "country_code": country_code,
                "status": status,
                "pagination_criteria": {
                    "offset": pagination_criteria_offset,
                    "limit": pagination_criteria_limit
                }
            }
        }
        resp = self.init.request('post', "/companies", json=data)
        return resp

    def companies_post(self,
                       company_code=None,
                       company_name=None,
                       brand_name=None,
                       address=None,
                       address_city=None,
                       address_state=None,
                       zip_code=None,
                       country_code=None,
                       contact_person_firstname=None,
                       contact_person_lastname=None,
                       contact_email=None,
                       contact_phone1=None,
                       contact_phone2=None,
                       company_type=None,
                       company_sub_type=None,
                       company_group_id=None,
                       status=None,
                       account=None):
        """ Create Company

        Examples:
        | ${resp} = | Companies Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "company_code": company_code,
                    "company_name": company_name,
                    "brand_name": brand_name,
                    "address": address,
                    "address_city": address_city,
                    "address_state": address_state,
                    "zip": zip_code,
                    "country_code": country_code,
                    "contact_person_firstname": contact_person_firstname,
                    "contact_person_lastname": contact_person_lastname,
                    "contact_email": contact_email,
                    "contact_phone1": contact_phone1,
                    "contact_phone2": contact_phone2,
                    "company_type": company_type,
                    "company_sub_type": company_sub_type,
                    "company_group_id": company_group_id,
                    "status": status
                }
            ]
        }
        resp = self.init.request('post', "/companies", json=data)
        return resp

    def companies_update(self,
                         company_id=None,
                         to_update_by_company_code=None,
                         company_name=None,
                         brand_name=None,
                         address=None,
                         zip_code=None,
                         country_code=None,
                         status=None,
                         contact_person_firstname=None,
                         contact_person_lastname=None,
                         contact_email=None,
                         contact_phone1=None,
                         contact_phone2=None,
                         company_type=None,
                         company_sub_type=None,
                         account=None):
        """Update specific Company's data

        Examples:
        | ${resp} = | Companies Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "company_id": company_id,
                    "to_update_by_company_code": to_update_by_company_code,
                    "company_name": company_name,
                    "brand_name": brand_name,
                    "address": address,
                    "zip": zip_code,
                    "country_code": country_code,
                    "status": status,
                    "contact_person_firstname": contact_person_firstname,
                    "contact_person_lastname": contact_person_lastname,
                    "contact_email": contact_email,
                    "contact_phone1": contact_phone1,
                    "contact_phone2": contact_phone2,
                    "company_type": company_type,
                    "company_sub_type": company_sub_type
                }
            ]
        }
        resp = self.init.request('post', "/companies", json=data)
        return resp
