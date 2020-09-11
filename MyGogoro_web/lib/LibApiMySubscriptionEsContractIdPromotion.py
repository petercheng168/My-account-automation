#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionEsContractIdPromotion(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_es_contractId_promotion_get(self, es_contractId, gogoro_sess=None, csrf_token=None):
        """ Get the es-contract promotion """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/subscription/{}/promotion".format(es_contractId))
        return resp
