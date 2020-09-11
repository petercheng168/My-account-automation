import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibContractUsers(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def contract_users_get(self, user_id=None, scooter_contract_id=None, user_name=None, last_name=None,
                            user_pid=None, user_email=None, user_mobile=None, user_homephone=None, request_data_type=1, account=None):
        """ Get contract user.

        Examples:
        | ${resp} = | Contract Users Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "user_id": user_id,
                "scooter_contract_id": scooter_contract_id,
                "user_name": user_name,
                "last_name": last_name,
                "user_pid": user_pid,
                "user_email": user_email,
                "user_mobile": user_mobile,
                "user_homephone": user_homephone,
                "request_data_type": request_data_type
            }
        }
        resp = self.init.request('post', "/contract-users", json=data)
        return resp


    def contract_users_post(self, name, last_name, user_type, gender, birthday,
                            email, country_code, mobile_phone1, profile_id, status,
                            contact_address=None, contact_district=None,
                            contact_city=None, contact_zip=None,
                            invoice_address=None, invoice_district=None,
                            invoice_city=None, invoice_zip=None,
                            nick_name=None, mobile_phone2=None, home_phone1=None,
                            home_phone2=None, password=None, account=None):
        """ Create contract user.

        Examples:
        | ${resp} = | Contract Users Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": {
                "name": name,
                "last_name": last_name,
                "nick_name": nick_name,
                "user_type": user_type,
                "gender": gender,
                "birthday": birthday,
                "email": email,
                "contact_address": contact_address,
                "contact_district": contact_district,
                "contact_city": contact_city,
                "contact_zip": contact_zip,
                "invoice_address": invoice_address,
                "invoice_district": invoice_district,
                "invoice_city": invoice_city,
                "invoice_zip": invoice_zip,
                "country_code": country_code,
                "mobile_phone1": mobile_phone1,
                "mobile_phone2": mobile_phone2,
                "home_phone1": home_phone1,
                "home_phone2": home_phone2,
                "profile_id": profile_id,
                "password": password,
                "status": status
            }
        }
        resp = self.init.request('post', "/contract-users", json=data)
        return resp

    def contract_users_update(self, user_id, name=None, user_type=None, gender=None,
                              country_code=None, mobile_phone1=None, last_name=None,
                              profile_id=None, birthday=None,
                              scooter_contract_id=None, contact_address=None,
                              contact_district=None, contact_city=None,
                              contact_zip=None, invoice_address=None,
                              invoice_district=None, invoice_city=None,
                              invoice_zip=None, mobile_phone2=None,
                              home_phone1=None, home_phone2=None,
                              new_profile_id=None, account=None):
        """ Update contract user.
        Examples:
        | ${resp} = | Contract Users Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": {
                "user_id": user_id,
                "scooter_contract_id": scooter_contract_id,
                "name": name,
                "last_name": last_name,
                "user_type": user_type,
                "gender": gender,
                "birthday": birthday,
                "contact_address": contact_address,
                "contact_district": contact_district,
                "contact_city": contact_city,
                "contact_zip": contact_zip,
                "invoice_address": invoice_address,
                "invoice_district": invoice_district,
                "invoice_city": invoice_city,
                "invoice_zip": invoice_zip,
                "country_code": country_code,
                "mobile_phone1": mobile_phone1,
                "mobile_phone2": mobile_phone2,
                "home_phone1": home_phone1,
                "home_phone2": home_phone2,
                "profile_id": profile_id,
                "new_profile_id": new_profile_id
            }
        }
        print(data)
        resp = self.init.request('post', "/contract-users", json=data)
        return resp
