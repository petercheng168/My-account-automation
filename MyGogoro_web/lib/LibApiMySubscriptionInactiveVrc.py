#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionInactiveVrc(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_inactive_vrc_put(self, plate, vin, filename, owner_name, battery_sn, gogoro_sess=None, csrf_token=None):
        """ Save scooter information for inactive subscription """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "plate": plate,
            "vin": vin,
            "filename": filename,
            "ownerName": owner_name,
            "batterySn": battery_sn
        }
        resp = self.init.request('put', "/api/my/subscription/inactive/vrc", json=data)
        return resp
