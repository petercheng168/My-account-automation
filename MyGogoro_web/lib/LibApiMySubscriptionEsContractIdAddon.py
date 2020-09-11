#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionEsContractIdAddon(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_es_contractId_addon_get(self, es_contractId, gogoro_sess=None, csrf_token=None):
        """ Get the es-contract add-on """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/subscription/{}/add-on".format(es_contractId))
        return resp
