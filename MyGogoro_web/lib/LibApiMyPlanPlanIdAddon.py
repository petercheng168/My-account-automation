#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMyPlanPlanIdAddon(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_plan_planId_addon_get(self, plan_Id, gogoro_sess=None, csrf_token=None):
        """ List all plan addon """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/plan/{}/add-on".format(plan_Id))
        return resp
