#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMyScooterScooterIdSubscription(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_scooter_scooterId_subscription_get(self, scooter_Id, gogoro_sess=None, csrf_token=None):
        """ Get cookie user's scooter subscription """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/scooter/{}/subscription".format(scooter_Id))
        return resp