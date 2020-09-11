#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibAttachUpdateScooterPairingFlag(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def update_scooter_pairing_flag_post(self, order_no, scooter_allocation_flag, token=None):
        """ Add scooter into shopping cart
        Args:
            order_no (str): dms_order_no
            scooter_allocation_flag (int): 1 as 自動配車, 2 as 暫不配車
        
        Return:
            resp: Return json object

        Examples:
            | Update Scooter Pairing Flag Post | PAYLOAD |
        """
        self.init.auth(token)
        data = {
            "OrderNo": order_no,
            "ScooterAllocationFlag": scooter_allocation_flag,
        }
        resp = self.init.request('post', '/attach/update-scooter-pairing-flag', json=data)
        return resp
