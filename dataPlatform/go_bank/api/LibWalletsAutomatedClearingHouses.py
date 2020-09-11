import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibWalletsAutomatedClearingHouses(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def wallets_automated_clearing_houses_add(self, user_id=None,
                                              account_name=None,
                                              account_num=None, bank_code=None,
                                              account_owner_profile_id=None,
                                              application_date=None,
                                              effective_date=None,
                                              status=None, account=None):
        """Create Wallet's ach.
        Examples:
        | ${resp} = | Wallets Automated Clearing Houses Add | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "user_id": user_id,
                    "account_name": account_name,
                    "account_num": account_num,
                    "bank_code": bank_code,
                    "account_owner_profile_id": account_owner_profile_id,
                    "application_date": application_date,
                    "effective_date": effective_date,
                    "status": status
                }
            ]
        }
        resp = self.init.request(
            'post', "/wallets/automated-clearing-houses", json=data)
        return resp

    def wallets_automated_clearing_houses_update(self, user_id=None,
                                                 wallet_ach_id=None,
                                                 account_name=None,
                                                 account_num=None,
                                                 bank_code=None,
                                                 account_owner_profile_id=None,
                                                 application_date=None,
                                                 effective_date=None,
                                                 status=None, account=None):
        """Update Wallet's ach.
        Examples:
        | ${resp} = | Wallets Automated Clearing Houses Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "user_id": user_id,
                    "wallet_ach_id": wallet_ach_id,
                    "account_name": account_name,
                    "account_num": account_num,
                    "bank_code": bank_code,
                    "account_owner_profile_id": account_owner_profile_id,
                    "application_date": application_date,
                    "effective_date": effective_date,
                    "status": status
                }
            ]
        }
        resp = self.init.request(
            'post', "/wallets/automated-clearing-houses", json=data)
        return resp
