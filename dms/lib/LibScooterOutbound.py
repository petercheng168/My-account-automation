#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
from robot.libraries.String import String
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from dms.lib.LibBase import LibBase


class LibScooterOutbound(object):

    def __init__(self):
        self.init = LibBase()

    # ---------------------------------------------------------------------------
    def scooteroutbound_post(self, date, vin, order_no, department_code, key,
                             scooter_model='GSBH2-000-CF', account=None):
        """
        Add scooter into outbound on DMS with vin
        Arguments:
        :param date: string type, format with YYYY/mm/dd,
        :param order_no: string type, dms_order_no
        :param vin: string type, scooter_vin
        :param key: string type, encrypted information, default use key in setting.py
        Examples:
        | Scooteroutbound Post | PAYLOAD |
        """
        rf_string = String()
        purchase_order = rf_string.generate_random_string(10, '[NUMBERS]')
        delivery_note = rf_string.generate_random_string(8, '[NUMBERS]')

        self.init.authHeader(account)
        data = {
            "key": key,
            "data": [
            {
                "g01": purchase_order,
                "g02": delivery_note,
                "g03": date,
                "g04": scooter_model,
                "g05": vin,
                "g06": order_no,
                "g07": department_code,
                "g08": date
            }
            ]
        }
        resp = self.init.request('post', "/scooteroutbound", json=data)
        return resp