#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.libraries.BuiltIn import BuiltIn
from LibBase import LibBase


class LibApiMyScooterScooterIdMileage(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_scooter_scooterId_mileage_get(self, scooter_Id, gogoro_sess=None, csrf_token=None):
        """ Get scooter mileage """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/scooter/{}/mileage".format(scooter_Id))
        return resp