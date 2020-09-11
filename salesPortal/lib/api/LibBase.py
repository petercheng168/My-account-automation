# -*- coding: utf-8 -*-
from robot.api import logger
import json
import requests
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from lib.LibVar import LibVar


class LibBase(object):
    def __init__(self, protocol='https', host='SALES_PORTAL_API_URL', basepath='/api', timeout='API_TIMEOUT'):
        self.variable = LibVar()
        self.HOST = self.variable.get_var(host)
        self.HOST = '{}://{}{}'.format(protocol, self.HOST, basepath)
        self.GO_CLIENT_HEADER = 'sales_portal'
        self.timeout = self.variable.get_var(timeout)
        self.SESSION = requests.Session()
        self.CIPHER_HOST = self.variable.get_var('CIPHER_HOST')
        self.PORT = self.variable.get_var('CIPHER_PORT')
        self.CIPHER_DEV = self.variable.get_var('CIPHER_DEV')
        self.CIPHER_APP = 'sales_portal'
        self.CIPHER_RESOURCE = 'sales_portal'
        self.CIPHER_ACCOUNT = self.variable.get_var('SALES_ACCOUNT')
        self.CIPHER_PASSWORD = self.variable.get_var('SALES_PASSWORD')

        self.SESSION.headers.update({
            'content-type': 'application/json; charset=utf-8',
            'Go-client': '{}'.format(self.GO_CLIENT_HEADER)
        })
        self.token = None

# ---------------------------------------------------------------------------
    def auth(self, token, hash_id=None):
        if 'Authorization' not in self.SESSION.headers:
            cipher = self.sales_portal_cipher_get()
            self.SESSION.headers.update({'Authorization': 'Bearer {}'.format(cipher)})
        if hash_id:
            token += hash_id
        self.SESSION.headers.update({'cookie': token})


    def dict_to_json_string(self, data):
        """ Transfer payload from dict to json """
        return str(data).replace("\'","\"").replace("None","\"\"")

    def sales_portal_cipher_get(self):
        """ Get cipher token """
        host = self.CIPHER_HOST
        port = self.PORT
        env = self.CIPHER_DEV
        cipher_app = self.CIPHER_APP
        cipher_resource = self.CIPHER_RESOURCE
        account = self.CIPHER_ACCOUNT
        password = self.CIPHER_PASSWORD

        cipher_request = (f"http://{host}:{port}/app/cipher?"
                          f"env={env}&"
                          f"app={cipher_app}&"
                          f"resource={cipher_resource}&"
                          f"username={account}&"
                          f"password={password}")

        if self.token is None:
            resp = self.SESSION.request('get', cipher_request)
            self.token = resp
            if resp.status_code == 200:
                logger.write(cipher_request)
                token = resp.text

                return token
            else:
                raise AssertionError("Get cipher error: \n"
                                    "status code: {}\n"
                                    "api request: {}\n".format(resp.status_code,
                                                                cipher_request))
            return resp.text
        else:
            return self.token

    def request(self, method, append='', **kwargs):
        ''' method:
                e.g.: get post put
            append:
                e.g.: /account/login
            **kwargs:
                e.g.: data={"Result":1,"Message":"","MessageCode":"","Data": ...}
        '''
        url = self.HOST + append
        resp = self.SESSION.request(method, url, **kwargs, timeout=(30, 30))
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
