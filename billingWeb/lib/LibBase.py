#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import requests
import sys
from robot.libraries.BuiltIn import BuiltIn
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from billingWeb.lib.LibAuth import LibAuth
from lib.LibVar import LibVar


class LibBase(object):

    def __init__(self, host='BILLING_WEB_HOST', billing_account='BILLING_ADMIN_ACCOUNT', billing_password='CIPHER_PASSWORD'):
        '''
            Note:
                - default host is `BILLING_WEB_HOST`
        '''
        self.BuiltIn = BuiltIn()
        self.LibAuth = LibAuth()
        self.LibVar = LibVar()
        self.HOST = self.LibVar.get_var(host)
        self.BILLING_ACCOUNT = self.LibVar.get_var(billing_account)
        self.BILLING_PASSWORD = self.LibVar.get_var(billing_password)
        self.SESSION = requests.Session()
        self.TOKEN = None
        self.SESSION.headers.update({
            'content-type': 'application/json'
        })
        self.HOST = 'http://{}'.format(self.HOST)

    def authHeader(self, billing_cookie):
        if billing_cookie == None:
            self.SESS = self.LibAuth.api_auth_login(self.BILLING_ACCOUNT, self.BILLING_PASSWORD)
        else:
            self.SESS = billing_cookie
        self.SESSION.headers.update({'cookie': self.SESS})

    def request(self, method, append='', **kwargs):
        ''' 
        method:
            e.g.: get post put delete
        append:
            e.g.: /api/engine/job-status
        '''
        url = self.HOST + append
        resp = self.SESSION.request(method, url, **kwargs, timeout=(3,3))
        if method == 'get':
            request_message = (
                '''
                Response message: {}
                CURL: \ncurl -i --request {} --url {}{} --hearder {}
                '''.format(resp.text, resp.request.method, self.HOST, append, resp.request.headers)
            )
        else:
            request_message = (
                '''
                Response message: {}
                CURL: \ncurl -i --request {} --url {}{} --data '{}' --hearder {}
                '''.format(resp.text, resp.request.method, self.HOST, append, resp.request.body, resp.request.headers)
            )
        print (request_message)
        return resp
