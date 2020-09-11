#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import re
import requests
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from lib.LibVar import LibVar


class LibCSRF(object):

    def __init__(self):
        self.LibVar = LibVar()
        self.env = self.LibVar.get_var('ENV')
        self.HOST = self.LibVar.get_var('MYGOGORO_GN_HOST')
        self.HOST = 'https://{}'.format(self.HOST)
        self.SESSION = requests.Session()
        self.SESSION.headers.update({
            'content-type': 'application/json'
        })

    def __request(self, method, append='', **kwargs):
        print("Method: {}, uri: {}{}".format(method, self.HOST, append))
        return self.SESSION.request(method, self.HOST + append, **kwargs)

# ---------------------------------------------------------------------------
    def CSRF_login_get(self):
        """ Get google-sess cookie and xsrf token info """
        resp = self.__request('get', "/login")
        gogoro_sess = re.findall("{}_gogoro-sess=[\w\S]+".format(self.env), resp.headers['Set-Cookie'])[0]
        csrf_token = re.findall("csrf-token=[\w\S]+", resp.headers['Set-Cookie'])[0]
        csrf_token = csrf_token.split('=')[1].replace(';', '')
        return gogoro_sess, csrf_token
        