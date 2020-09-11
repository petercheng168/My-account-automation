#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.libraries.BuiltIn import BuiltIn
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase
from lib.LibVar import LibVar

class LibAccountLogin(object):

    def __init__(self):
        self.init = LibBase()
        self.variable = LibVar()
        self._env = self.variable.get_var('ENV')

        if self._env != 'prod':
            self.init.sales_portal_cipher_get()

# ---------------------------------------------------------------------------
    def account_login_post(self, user_id, password, session_id=None, recaptcha_response=None,
                     two_factor_source=0, otp_code=None, remember_device=True, browser_info=None, token=None):
        """login sales portal
        Args:
            user_id (str): sales account
            password (str): sales password
            two_factor_source (int): flag to check use 2FA login or not, default as 0
            otp_code (str): code for 2FA login
            remember_device (bool): flag to check next time login should use 2FA confirmation or not
            browser_info (str): record browser type

        Return:
            resp: Return json object

        Examples:
            | Account Login Post | PAYLOAD |
        """
        data = {
            "UserID": user_id,
            "Password": password,
            "SessionId": session_id,
            "RecaptchaResponse": recaptcha_response,
            "TwoFactorSource": two_factor_source,
            "OtpCode": otp_code,
            "RememberDevice": remember_device,
            "BrowserInfo": browser_info
        }
        resp = self.init.request('post', '/account/login', json=data)
        return resp

