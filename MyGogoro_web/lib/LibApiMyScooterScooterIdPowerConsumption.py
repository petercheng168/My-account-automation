#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.libraries.BuiltIn import BuiltIn
from LibBase import LibBase


class LibApiMyScooterScooterIdPowerConsumption(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_scooter_scooterId_powerconsumption_get(self, scooter_Id, gogoro_sess=None, csrf_token=None):
        """ Get scooter power consumption """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/scooter/{}/power-consumption".format(scooter_Id))
        return resp