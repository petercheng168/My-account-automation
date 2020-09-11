#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import re
import requests
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from lib.LibVar import LibVar


class LibAuth(object):

    def __init__(self):
        self.LibVar = LibVar()
        self.HOST = self.LibVar.get_var('BILLING_WEB_HOST')
        self.HOST = 'http://{}'.format(self.HOST)
        self.SESSION = requests.Session()
        self.SESSION.headers.update({
            'content-type': 'application/json'
        })

    def __request(self, method, append='', **kwargs):
        print("Method: {}, uri: {}{}".format(method, self.HOST, append))
        return self.SESSION.request(method, self.HOST + append, **kwargs)

# ---------------------------------------------------------------------------
    def api_auth_login(self, user_name, user_password):
        """ Get billing-mgmt cookie """
        data = {
            "username": user_name,
            "password": user_password
        }
        resp = self.__request('post', "/api/auth/login", json=data)
        billing_cookie = re.findall("billingMgmt=[\w\S]+", resp.headers['Set-Cookie'])[0]
        return billing_cookie
