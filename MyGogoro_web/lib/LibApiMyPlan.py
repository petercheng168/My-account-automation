#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMyPlan(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_plan_get(self, plan_sku=None, gogoro_sess=None, csrf_token=None):
        """ List all public plans """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/plan")
        if plan_sku is not None:
            plan = list(filter(lambda x: x['sku'] == plan_sku, resp.json()['items']))[0]
            return resp, plan
        else:
            return resp