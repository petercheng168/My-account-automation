#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibUtilityGetDpUserData(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def utility_get_dp_user_data_post(self, email, phone, password=None, token=None):
        """ Add scooter into shopping cart
        Args:
            email (str): buyer email
            phone (str): buyer phone last 4 number

        Return:
            resp: Return json object

        Examples:
            | Utility Get Dp User Data Post | PAYLOAD |
        """
        self.init.auth(token)
        data = {
            "Email": email,
            "Password": password,
            "Phone": phone
        }
        resp = self.init.request('post', '/utility/get-dp-user-data', json=data)
        return resp
