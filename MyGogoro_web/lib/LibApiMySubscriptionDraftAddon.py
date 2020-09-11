#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionDraftAddon(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_draft_addon_put(self, addon_id=None, sku=None, charge=None, gogoro_sess=None, csrf_token=None):
        """ Subscription draft with plan """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = [
            {
                "id": addon_id,
                "sku": sku,
                "charge": charge
            }
        ]
        if addon_id is None:
            data = []
        resp = self.init.request('put', "/api/my/subscription/draft/add-on", json=data)
        return resp
