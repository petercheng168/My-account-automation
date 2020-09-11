#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase

class LibGetOrderData(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def order_data_get(self, order_no, token=None):
        """ Get order detail
        Args:
            OrderNo (str): dms_order_no

        Return:
            resp: Return json object

        Examples:
            | Order Data Get | PAYLOAD |
        """
        self.init.auth(token)

        resp = self.init.request('get', '/order-form/get-order-data/{}'.format(order_no))
        return resp
