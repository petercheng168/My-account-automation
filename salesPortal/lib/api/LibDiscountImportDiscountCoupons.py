#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibDiscountImportDiscountCoupons(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def import_discount_coupons_post(self, discount_plan_option_id=None, 
                               token=None, hash_id=None, coupon_code=None):
        """ Import discount coupons code by admin
        Args:
        Return:
            resp: Return json object

        Examples:
            | Import Discount Coupons Post | PAYLOAD |
        """
        self.init.auth(token, hash_id)
        data = {
                "DiscountPlanOptionsId": discount_plan_option_id,
                "CouponCode": 
                [
                    coupon_code
                ]
        }
        resp = self.init.request('post', '/discount/import-discount-coupons', json=data)
        return resp
