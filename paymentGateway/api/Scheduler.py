# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from paymentGateway.api.Base import Base


class Scheduler(Base):

    def __init__(self):
        super().__init__()

    def ach_apply(self, user_ids: list, auth, bank_code=None):
        """
        Send ACH application request to SFTP
        :param user_ids: string type in a list, ex: ["6mnMrr5N", "bNyjlrmv"]
        :param auth: get from cipher
        :param bank_code: string type, ex: 812 (optional)
        """
        payload = {
            'userIds': user_ids
        }

        if bank_code is not None:
            payload.update({'bankCode': bank_code})

        response = super().scheduler_request('post', '/api/v1/job/payment/ach-apply', data=payload, auth=auth)

        return response

    def get_ach_apply_result(self, auth):
        """
        Get ACH apply result from SFTP
        :param auth: get from cipher
        """
        response = super().scheduler_request('post', '/api/v1/job/payment/get-ach-apply-result', auth=auth)

        return response

    def apply_ach_write_off(self, auth):
        """
        Send ACH request to FTP
        :param auth: get from cipher
        """
        response = super().scheduler_request('post', '/api/v1/job/payment/apply-ach-write-off', auth=auth)

        return response

    def get_ach_write_off_result(self, auth):
        """
        Get ACH result from FTP
        :param auth: get from cipher
        """
        response = super().scheduler_request('post', '/api/v1/job/payment/get-ach-write-off-result', auth=auth)

        return response

    def convenient_store_write_off(self, auth):
        """
        Get payments of convenient store from FTP
        :param auth: get from cipher
        """
        response = super().scheduler_request('post', '/api/v1/job/payment/convenient-store-write-off', auth=auth)

        return response

    def auto_pay_credit_card(self, auth):
        """
        Auto payment with credit card
        :param auth: get from cipher
        """
        response = super().scheduler_request('post', '/api/v1/job/payment/auto-pay-credit-card', auth=auth)

        return response
