#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
import re
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from LibBase import LibBase
from lib.LibVar import LibVar


class LibAccountSignin(object):

    def __init__(self):
        self.init = LibBase()
        self.env = LibVar().get_var('ENV')

# ---------------------------------------------------------------------------
    def account_signin_post(self, email, password, auth=None, gogoro_sess=None, csrf_token=None):
        """
        Sign-in mygogoro account.
        If need to return new gogoro-sess token, please use auth variable
        """
        self.init.authHeader(gogoro_sess, csrf_token)

        data = {
            "username": {
                "email": email
            },
            "password": password,
            "emailLogin": True
        }

        resp = self.init.request('post', "/account/sign-in", json=data)
        if auth == None:
            return resp
        else:
            gogoro_sess = re.findall(
                "{}_gogoro-sess=[\w\S]+".format(self.env), resp.headers['Set-Cookie'])[0]
            csrf_token = resp.json()['csrfToken']
            return gogoro_sess, csrf_token
