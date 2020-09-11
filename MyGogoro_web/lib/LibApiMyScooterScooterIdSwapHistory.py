#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.libraries.BuiltIn import BuiltIn
import json
import os
import sys
from LibBase import LibBase


class LibApiMyScooterScooterIdSwapHistory(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_scooter_scooterId_swap_history_get(self, scooter_Id, gogoro_sess=None, csrf_token=None):
        """ Get scooter swap history, only used for gopocket currently """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/scooter/{}/swap-history?page=1&perPage=1".format(scooter_Id))
        return resp