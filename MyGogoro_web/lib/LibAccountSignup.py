#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibAccountSignup(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def account_signup_post(self, gender, last_name, first_name, display_name, email, mobile, password,
                            birthday, contact_city, contact_district, contact_zipcode, contact_address,
                            phone, occupation, invoice_city, invoice_district, invoice_zipcode, invoice_address,
                            country=None, gogoro_sess=None, csrf_token=None):
        """ Sign-up mygogoro account """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "gender": gender,
            "lastName": last_name,
            "firstName": first_name,
            "displayName": display_name,
            "username": {
                "email": email
            },
            "mobile": mobile,
            "password": password,
            "passwordConfirm": password,
            "birthday": birthday,
            "country": country,
            "contactAddress": {
                "city": contact_city,
                "district": contact_district,
                "zipCode": contact_zipcode,
                "address": contact_address
            },
            "phone": phone,
            "occupation": occupation,
            "invoiceAddress": {
                "city": invoice_city,
                "district": invoice_district,
                "zipCode": invoice_zipcode,
                "address": invoice_address
            }
        }
        resp = self.init.request('post', "/account/sign-up", json=data)
        return resp
