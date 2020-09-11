#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.libraries.BuiltIn import BuiltIn
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibPromotions(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def promotions_get(self, status, published, valid_time_from, valid_time_to,
                       account=None):
        """Get all promotions.
        Examples:
        | ${resp} = | Promotions Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "status": status,
                "published": published,
                "valid_time_from": valid_time_from,
                "valid_time_to": valid_time_to
            }
        }
        resp = self.init.request('post', "/promotions", json=data)
        return resp

    def promotions_get_via_promotion_name(self, promotion_name, account=None):
        """Get specific promotion via promotion name
        Examples:
        | ${resp} = | Promotions Get Via Name | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "promotion_name": promotion_name
            }
        }
        resp = self.init.request('post', "/promotions", json=data)
        return resp
