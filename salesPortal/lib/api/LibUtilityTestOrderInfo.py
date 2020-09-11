#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibUtilityTestOrderInfo(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def utility_test_order_info_get(self, order_no, token=None):
        """ Get scooter order invoice detail
        Args:
            OrderNo (str): dms_order_no

        Return:
            resp: Return json object

        Examples:
            | Utility Test Order Info Get | PAYLOAD |
        """
        self.init.auth(token)

        resp = self.init.request('get', '/utility/test-order-info?OrderNo={}'.format(order_no))
        return resp
