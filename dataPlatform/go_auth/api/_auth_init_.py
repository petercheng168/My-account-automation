import json
import os
import requests
import sys
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from lib.LibAppCipher import LibAppCipher
from lib.LibVar import LibVar


class _init_(object):

    def __init__(self, protocol='PROTOCOL', host='DATAPLATFORM_HOST',
                 port='DATAPLATFORM_PORT', basepath='GO_AUTH_BASEPATH',
                 client_header='GO_CLIENT_HEADER',
                 timeout='PLATFORM_API_TIMEOUT'):
        ''' usage:
                __dirname = os.path.dirname(os.path.abspath(__file__))
                sys.path.append(os.path.join(__dirname, '../../lib'))
                from _init_ import _init_
                self.init = _init_()

            Note:
                - default host is `DATAPLATFORM_HOST` and basepath is `/go-platform/v1`
                - if need to use other host, please follow below example:
                    `self.init = _init_('Other_URL', '/api/v1')`
        '''
        self.LibAppCipher = LibAppCipher()
        self.LibVar = LibVar()
        self.PROTOCOL = self.LibVar.get_var(protocol)
        self.PORT = self.LibVar.get_var(port)
        self._BASEPATH = self.LibVar.get_var(basepath)
        self.GO_CLIENT_HEADER = self.LibVar.get_var(client_header)
        self.TIMEOUT = self.LibVar.get_var(timeout)
        self.HOST = self.LibVar.get_var(host)
        self.HOST = '{}://{}:{}{}'.format(self.PROTOCOL,
                                          self.HOST, self.PORT, self._BASEPATH)
        self.SESSION = requests.Session()
        self.TOKEN = None
        self.SESSION.headers.update({
            'content-type': 'application/json',
            'Go-client': '{}'.format(self.GO_CLIENT_HEADER)
        })

    def auth_header(self, account):
        self.TOKEN = self.LibAppCipher.app_cipher_get(account)
        authorization = '{}'.format(self.TOKEN)
        self.SESSION.headers.update(
            {'Authorization': 'Bearer {}'.format(authorization)})

    def request(self, method, append='', **kwargs):
        ''' method:
                e.g.: get post patch delete
            append:
                e.g.: /scooter
            **kwargs:
                e.g.: data={"scooter":"qa"}
        '''
        url = self.HOST + append
        resp = self.SESSION.request(
            method, url, **kwargs, timeout=self.TIMEOUT)

        try:
            tags = BuiltIn().get_variable_value("${TEST_TAGS}")
        except:
            tags = []
            pass

        body = json.loads(resp.request.body.decode())
        body = json.dumps(body, indent=4)

        resp_msg = json.loads(resp.text)
        resp_msg = json.dumps(resp_msg, indent=4)

        request_msg = (
            "Response message: {resp_status_code}\n"
            "Body: {resp_msg}\n"
            "CURL:\n"
            "   curl -i --request {method} --url {url} \\\n"
            "   --header 'Authorization: {token}' \\\n"
            "   --header 'content-type: {content_type}' --header 'go-client: {go_client}' \\\n"
            "   --data '{body}'"
        ).format(
            resp_status_code=resp.status_code,
            resp_msg=resp_msg,
            method=resp.request.method,
            url=(self.HOST + append),
            token=resp.request.headers['Authorization'],
            content_type=resp.request.headers['Content-Type'],
            go_client=resp.request.headers['Go-client'],
            body=body
        )

        if ('code' not in resp.json().keys() or resp.json()['code'] != 0) and 'FET' not in tags:
            raise AssertionError(
                "FYI: If the API request is failed, please refer to the following information \n{}".format(
                    request_msg)
            )
        else:
            logger.write(request_msg)
        return resp
