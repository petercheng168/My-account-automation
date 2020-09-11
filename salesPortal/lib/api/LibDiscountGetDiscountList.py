#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibDiscountGetDiscountList(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def get_discount_list_post(self, discount_plan_main_id=None,
                               discount_plan_option_id=None, name=None,
                               code=None, offset=None, limit=None,
                               token=None, hash_id=None):
        """ Get info about telecom discount coupons
        Args:
        Return:
            resp: Return json object

        Examples:
            | Get Discount List Post | PAYLOAD |
        """
        self.init.auth(token, hash_id)
        data = {
            "DiscountPlanMainId": discount_plan_main_id,
            "DiscountPlanOptionsId": discount_plan_option_id,
            "Name": name,
            "Code": code,
            "PaginationCriteria": {
                "Offset": offset,
                "Limit": limit
            }
        }
        resp = self.init.request('post', '/discount/get-discount-list', json=data)
        return resp
