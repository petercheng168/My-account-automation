#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibUtilityTestOrderOpeningInvoice(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def utility_test_order_opening_invoice_get(self, order_no, token=None):
        """ Add scooter into shopping cart
        Args:
            OrderNo (str): dms_order_no

        Return:
            resp: Return json object

        Examples:
            | Utility Test Order Opening Invoice Get | PAYLOAD |
        """
        self.init.auth(token)

        resp = self.init.request('get', '/utility/test-order-opening-invoice?OrderNo={}'.format(order_no))
        return resp
