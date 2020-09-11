#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionDraftPlan(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_draft_plan_put(self, plan_id, sku, lockedLength, chargeType,
                                           chargeBase, chargeUnit, goRewards, chargeLevels_threshold=None,
                                           chargeLevels_base=None, gogoro_sess=None, csrf_token=None):
        """ Subscription draft with plan """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "id": plan_id,
            "sku": sku,
            "lockedLength": lockedLength,
            "chargeType": chargeType,
            "chargeBase": chargeBase,
            "chargeUnit": chargeUnit,
            "goRewards": goRewards
        }
        if chargeLevels_threshold and chargeLevels_base is not None:
            data.update(
                {
                    "chargeLevels": [
                        {
                            "threshold": chargeLevels_threshold,
                            "base": chargeLevels_base
                        }
                    ]
                }
            )
        resp = self.init.request(
            'put', "/api/my/subscription/draft/plan", json=data)
        return resp
