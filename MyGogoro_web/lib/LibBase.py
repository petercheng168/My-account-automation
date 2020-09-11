#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import requests
import sys
from robot.libraries.BuiltIn import BuiltIn
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from lib.LibVar import LibVar
from MyGogoro_web.lib.LibCSRF import LibCSRF


class LibBase(object):

    def __init__(self, host='MYGOGORO_GN_HOST'):
        ''' usage:
                __dirname = os.path.dirname(os.path.abspath(__file__))
                sys.path.append(os.path.join(__dirname, '../../lib'))
                from _init_ import _init_
                self.init = _init_()

            Note:
                - default host is `MYGOGORO_GN_HOST`
        '''
        self.BuiltIn = BuiltIn()
        self.LibCSRF = LibCSRF()
        self.LibVar = LibVar()
        self.HOST = self.LibVar.get_var(host)
        self.SESSION = requests.Session()
        self.TOKEN = None
        self.SESSION.headers.update({
            'content-type': 'application/json'
        })
        self.HOST = 'https://{}'.format(self.HOST)

    def authHeader(self, gogoro_sess, csrf_token):
        if gogoro_sess == None and csrf_token == None:
            self.SESS, self.TOKEN = self.LibCSRF.CSRF_login_get()
            self.SESSION.headers.update({'cookie': self.SESS})
            self.SESSION.headers.update({'x-xsrf-token': self.TOKEN})
        else:
            self.SESSION.headers.update({'cookie': gogoro_sess})
            self.SESSION.headers.update({'x-xsrf-token': csrf_token})

    def request(self, method, append='', **kwargs):
        ''' method:
                e.g.: get post patch delete
            append:
                e.g.: /scooter
            **kwargs:
                e.g.: data={"scooter":"qa"}
        '''
        print (self.HOST)
        url = self.HOST + append
        resp = self.SESSION.request(method, url, **kwargs, timeout=(14, 14))
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
