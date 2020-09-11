#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMyProfilePassword(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_profile_password_put(self, password, new_password, gogoro_sess=None, csrf_token=None):
        """ Update user password """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "password": password,
            "newPassword": new_password,
            "newPasswordConfirm": new_password
        }
        resp = self.init.request('put', "/api/my/profile/password", json=data)
        return resp
