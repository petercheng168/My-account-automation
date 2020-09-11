#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionDraft(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_draft_post(self, gogoro_sess=None, csrf_token=None):
        """ Subscription draft """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('post', "/api/my/subscription/draft")
        return resp

    def api_my_subscription_draft_delete(self, gogoro_sess=None, csrf_token=None):
        """ Delete Subscription draft """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('delete', "/api/my/subscription/draft")
        return resp
