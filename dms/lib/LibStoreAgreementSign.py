#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from dms.lib.LibBase import LibBase


class LibStoreAgreementSign(object):

    def __init__(self):
        self.init = LibBase()

    # ---------------------------------------------------------------------------
    def storeagreementsign_post(self, company_department_code, order_no, vin, key, account=None):
        """
        Add store agreement sign on DMS with vin and order_no to assign scooter to scooter contract
        Arguments:
        :param order_no: string type, dms_order_no
        :param vin: string type, scooter_vin
        :param key: string type, encrypted information, default use key in setting.py
        Examples:
        | Storeagreementsign Post | PAYLOAD |
        """
        self.init.authHeader(account)
        data = {
            "key": key,
            "u01": "GSS",
            "u02": company_department_code,
            "u03": "",
            "e03": order_no,
            "e04": "6",
            "e16": vin
        }
        resp = self.init.request('post', "/storeagreementsign", json=data)
        return resp