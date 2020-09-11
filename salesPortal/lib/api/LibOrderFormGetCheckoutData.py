#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibOrderFormGetCheckoutData(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def order_form_get_checkout_data(self, bag, email, token=None, hash_id=None):
        """ Add scooter into shopping cart
        Args:
            email (str): buyer email

        Return:
            resp: Return json object

        Examples:
            | Order Form Get Checkout Data | PAYLOAD |
        """
        self.init.auth(token, hash_id)
        data = {
            "Email": email,
        }
        resp = self.init.request('get', '/order-form/get-checkout-data/{bag}'.format(bag=bag), json=data)
        return resp
