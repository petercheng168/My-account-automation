# -*- coding: utf-8 -*-
import os
import re
import requests
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from lib.LibVar import LibVar
from salesPortal.lib.api.LibAccountLogin import LibAccountLogin


class LibToken(object):

    def __init__(self):
        self.variable = LibVar()
        self.ACCOUNT = self.variable.get_var('SALES_ACCOUNT')
        self.PASSWORD = self.variable.get_var('SALES_PASSWORD')
        if self.variable.get_var('ENV') == 'dev':
            self.token = '.DevSalesAuth'
        elif self.variable.get_var('ENV') == 'swqa':
            self.token = '.DevSalesAuth'
        else:
            self.token = '.PaSalesAuth'

        self.SESSION = requests.Session()
        self.SESSION.headers.update({
            'content-type': 'application/json'
        })

# ---------------------------------------------------------------------------
    def get_sp_token(self, account=None, password=None):
        """Get SP token"""
        if account is None and password is None:
            account = self.ACCOUNT
            password = self.PASSWORD

        resp = LibAccountLogin().account_login_post(account, password)
        token = re.findall("{}=[\w\S]+".format(self.token), resp.headers['Set-Cookie'])[0]

        return token
