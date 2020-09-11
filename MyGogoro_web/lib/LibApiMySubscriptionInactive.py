#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionInactive(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_inactive_post(self, gogoro_sess=None, csrf_token=None):
        """ Activate the inactive subscription """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('post', "/api/my/subscription/inactive")
        return resp

    def api_my_subscription_inactive_delete(self, gogoro_sess=None, csrf_token=None):
        """ Delete the inactive subscription """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('delete', "/api/my/subscription/inactive")
        return resp
