#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import requests
import sys
from robot.libraries.BuiltIn import BuiltIn
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from lib.LibAppCipher import LibAppCipher
from lib.LibVar import LibVar


class LibBase(object):

    def __init__(self, host='DMS_HOST', basepath='DMS_BASEPATH', client_header='GO_CLIENT_HEADER'):
        ''' usage:
                __dirname = os.path.dirname(os.path.abspath(__file__))
                sys.path.append(os.path.join(__dirname, '../../lib'))
                from _init_ import _init_
                self.init = _init_()

            Note:
                - default host is `DMS_HOST` and basepath is `/bin/api/index.prg`
        '''
        print(basepath)
        self.BuiltIn = BuiltIn()
        self.LibAppCipher = LibAppCipher()
        self.LibVar = LibVar()
        self.HOST = self.LibVar.get_var(host)
        self.BASEPATH = self.LibVar.get_var(basepath)
        self.GO_CLIENT_HEADER = self.LibVar.get_var(client_header)
        self.SESSION = requests.Session()
        self.TOKEN = None
        self.SESSION.headers.update({
            'content-type': 'application/json',
            'Go-client': '{}'.format(self.GO_CLIENT_HEADER)
        })
        self.HOST = 'https://{}{}'.format(self.HOST, self.BASEPATH)

    def authHeader(self, account):
        self.TOKEN = self.LibAppCipher.app_cipher_get(account)
        authorization = '{}'.format(self.TOKEN)
        self.SESSION.headers.update({'Authorization': authorization})

    def request(self, method, append='', **kwargs):
        ''' method:
                e.g.: post
            append:
                e.g.: /scooteroutbound
                      /storeagreementsign
            **kwargs:
                e.g.:
                { "key": "YwDItkkp2VxZteAIa6wPRiLaYEEMavwpWMBhWjsIzWkDuwX7O6CP", "data": [{"qa"}]}
                { "key": "fgBGL3fNOl0Ki2lz+C9caen+Hm/xSuE/Llpo3Tkt+atoHymsM3kqP0SlzuQdVGoKLQ==", "qa"}
        '''
        url = self.HOST + append
        resp = self.SESSION.request(method, url, **kwargs)
        if resp.json()['result'] != 1:
            raise AssertionError(
                '''
                FYI: If the API request is failed, please refer to the following information
                Response message: {}
                CURL: \ncurl -i --request {} --url {}{} --header 'Authorization: {}' --header 'content-type: {}' --header 'go-client: {}' --data '{}'
                '''.format(resp.text, resp.request.method, self.HOST, append, resp.request.headers['Authorization'],
                           resp.request.headers['Content-Type'], resp.request.headers['Go-client'], resp.request.body)
            )
        else:
            if append == '/storeagreementsign':
                    request_message = (
                        '''
                        Response message: {}
                        CURL: \ncurl -i --request {} --url {}{} --header 'Authorization: {}' --header 'content-type: {}' --header 'go-client: {}' --data '{}'
                        '''.format(resp.text, resp.request.method, self.HOST, append, resp.request.headers['Authorization'],
                                resp.request.headers['Content-Type'], resp.request.headers['Go-client'], resp.request.body)
                    )
            else:
                if resp.json()['data'][0]['ErrMsg'] != '':
                                raise AssertionError(
                    '''
                    FYI: If the API request is failed, please refer to the following information
                    Response message: {}
                    CURL: \ncurl -i --request {} --url {}{} --header 'Authorization: {}' --header 'content-type: {}' --header 'go-client: {}' --data '{}'
                    '''.format(resp.text, resp.request.method, self.HOST, append, resp.request.headers['Authorization'],
                            resp.request.headers['Content-Type'], resp.request.headers['Go-client'], resp.request.body)
                    )
                else:
                    request_message = (
                        '''
                        Response message: {}
                        CURL: \ncurl -i --request {} --url {}{} --header 'Authorization: {}' --header 'content-type: {}' --header 'go-client: {}' --data '{}'
                        '''.format(resp.text, resp.request.method, self.HOST, append, resp.request.headers['Authorization'],
                                resp.request.headers['Content-Type'], resp.request.headers['Go-client'], resp.request.body)
                    )
        print(request_message)
        return resp
