import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibUsers(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def users_get(self, user_id, request_data_type, account=None):
        """ Get user information """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "user_id": user_id,
                "request_data_type": request_data_type
            }
        }
        resp = self.init.request('post', "/users", json=data)
        return resp

    def users_get_email(self, user_email, request_data_type, account=None):
        """ Get user information via email """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "user_email": user_email,
                "request_data_type": request_data_type
            }
        }
        resp = self.init.request('post', "/users", json=data)
        return resp

    def users_post(self, company_code=None, first_name=None, gender=None,
                   email=None, status=None, enable_e_carrier=None,
                   last_name=None, nick_name=None, birthday=None,
                   contact_address=None, contact_district=None,
                   contact_city=None, contact_zip=None, invoice_address=None,
                   invoice_district=None, invoice_city=None, invoice_zip=None,
                   country_code=None, mobile_phone1=None, mobile_phone2=None,
                   home_phone1=None, home_phone2=None, profile_id=None,
                   password=None, login_phone=None, gogoro_guid=None,
                   photo_url=None, occupation=None, eula_status=None,
                   unit=None, account=None):
        """ Create user """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "company_code": company_code,
                    "first_name": first_name,
                    "last_name": last_name,
                    "nick_name": nick_name,
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
                    # "login_phone": login_phone,
                    "status": status,
                    "gogoro_guid": gogoro_guid,
                    "enable_e_carrier": enable_e_carrier,
                    "photo_url": photo_url,
                    "occupation": occupation,
                    "eula_status": eula_status,
                    "unit": unit
                }
            ]
        }
        resp = self.init.request('post', "/users", json=data)
        return resp

    def users_update_password(self, user_id, email, password, account=None):
        """ Update user password """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "user_id": user_id,
                    "email": email,
                    "password": password
                }
            ]
        }
        resp = self.init.request('post', "/users", json=data)
        return resp

    def users_update_email_verified(self, user_id, email_verified, account=None):
        """ Update user email_verified """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "user_id": user_id,
                    "email_verified": email_verified
                }
            ]
        }
        resp = self.init.request('post', "/users", json=data)
        return resp

    def users_update_login_phone_verified(self, user_id, login_phone_verified,
                                          account=None):
        """ Update user login_phone_verified

        Examples:
        | ${resp} = | Users Update Login Phone Verified | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "user_id": user_id,
                    "login_phone_verified": login_phone_verified
                }
            ]
        }
        resp = self.init.request('post', "/users", json=data)
        return resp
