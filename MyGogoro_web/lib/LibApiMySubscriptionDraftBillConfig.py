#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionDraftBillConfig(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_draft_bill_config_put(self, isConsolidated, bill_format, includeRidingDetails, gogoro_sess=None, csrf_token=None):
        """ Subscription draft with bill config """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "isConsolidated": isConsolidated,
            "format": bill_format,
            "includeRidingDetails": includeRidingDetails
        }
        resp = self.init.request('put', "/api/my/subscription/draft/bill-config", json=data)
        return resp
