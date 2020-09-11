#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.api import logger
import requests
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../'))
from lib.LibVar import LibVar


class LibAppCipher(object):

    def __init__(self):
        self.LibVar = LibVar()
        self.CIPHER_HOST = self.LibVar.get_var('CIPHER_HOST')
        self.PORT = self.LibVar.get_var('CIPHER_PORT')
        self.CIPHER_DEV = self.LibVar.get_var('CIPHER_DEV')
        self.CIPHER_APP = self.LibVar.get_var('CIPHER_APP')
        self.CIPHER_RESOURCE = self.LibVar.get_var('CIPHER_RESOURCE')
        self.CIPHER_PASSWORD = self.LibVar.get_var('CIPHER_PASSWORD')
        self.CIPHER_ACCOUNT = self.LibVar.get_var('CIPHER_GEN_ACCOUNT')
        self.SESSION = requests.Session()
        self.SESSION.headers.update({
            'content-type': 'application/json'
        })

# ---------------------------------------------------------------------------

    def app_cipher_get(self, account, **kwargs):
        """ Get cipher token

        Args:
            account(str): dev.gen_admin@gogoro.com (default)
            cipher_app(str): dev (default)
            cipher_resource(str): dev (default)
            ciphe_pwd(str): 123 (default)
        """

        host = self.CIPHER_HOST
        port = self.PORT
        env = self.CIPHER_DEV

        cipher_app = kwargs.get('cipher_app', self.CIPHER_APP)
        cipher_resource = kwargs.get('cipher_resource', self.CIPHER_RESOURCE)
        password = kwargs.get('cipher_pwd', self.CIPHER_PASSWORD)

        if account is None:
            account = self.CIPHER_ACCOUNT

        cipher_request = (f"http://{host}:{port}/app/cipher?"
                          f"env={env}&"
                          f"app={cipher_app}&"
                          f"resource={cipher_resource}&"
                          f"username={account}&"
                          f"password={password}")

        resp = self.SESSION.request('get', cipher_request)

        if resp.status_code == 200:
            logger.write(cipher_request)
            token = resp.text

            return token
        else:
            raise AssertionError("Get cipher error: \n"
                                 "status code: {}\n"
                                 "api request: {}\n".format(resp.status_code,
                                                            cipher_request))

    def encode_password_get(self, password):
        """ encode password """
        resp = self.SESSION.request(
            'get', "http://{}:3031/encrypt/level1?plaintext={}".format(self.CIPHER_HOST, password))
        return resp
