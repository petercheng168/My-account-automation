#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMyProfile(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_profile_get(self, gogoro_sess=None, csrf_token=None):
        """ List all user profile """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/profile")
        return resp

    def api_my_profile_patch(self, email, first_name, last_name, display_name, id_number,
                             gender, birthday, occupation, mobile, contact_city, contact_district,
                             contact_zipcode, contact_address, invoice_city, invoice_district,
                             invoice_zipcode, invoice_address, invoice_format, invoice_title,
                             vat_number, e_carriers_serial, e_carriers_issuer, gogoro_sess=None, csrf_token=None):
        """ Update user profile """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "username": {
                "email": email
            },
            "emails": [
                {
                    "target": email,
                    "isVerified": True,
                    "isPrimary": True
                }
            ],
            "firstName": first_name,
            "lastName": last_name,
            "displayName": display_name,
            "idNumber": id_number,
            "gender": gender,
            "birthday": birthday,
            "occupation": occupation,
            "mobile": mobile,
            "mobiles": [
                {
                    "target": mobile,
                    "isPrimary": True
                }
            ],
            "country": "TW",
            "contactAddress": {
                "city": contact_city,
                "district": contact_district,
                "zipCode": contact_zipcode,
                "address": contact_address
            },
            "invoiceAddress": {
                "city": invoice_city,
                "district": invoice_district,
                "zipCode": invoice_zipcode,
                "address": invoice_address
            },
            "invoiceConfig": {
                "format": invoice_format,
                "title": invoice_title,
                "vatNumber": vat_number,
                "includeVat": False,
                "eCarriers": [
                    {
                        "serial": e_carriers_serial,
                        "issuer": e_carriers_issuer,
                        "isSubsumed": False
                    }
                ]
            },
            "billConfig": {
                "isConsolidated": 0
            }
        }
        resp = self.init.request('patch', "/api/my/profile", json=data)
        return resp
