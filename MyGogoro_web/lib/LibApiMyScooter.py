#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMyScooter(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_scooter_get(self, gogoro_sess=None, csrf_token=None):
        """ Get cookie user's scooter """
        self.init.authHeader(gogoro_sess, csrf_token)
        resp = self.init.request('get', "/api/my/scooter")
        return resp
