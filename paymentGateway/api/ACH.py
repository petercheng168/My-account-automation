# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from paymentGateway.api.Base import Base
from lib.LibLogger import set_logger

logger = set_logger(__name__)


class ACH(Base):

    def __init__(self):
        super().__init__()
    
    def ach_apply(self, apply_date, es_contract_id, auth, action=None):
        """
        Function to do ach apply ftp file to bank
        :param apply_date: string type, format is YYYY/MM/DD
        :param es_contract_id: string type, hash id of es-contract
        :param auth: get from cipher
        :param action: string type, A:create, D:cancel, O:update, default is A, only support action A now (optional)
        Examples:
        | Ach Apply | PAYLOAD |
        """
        payload = {
            'data': [
                {
                    'es_contract_id': es_contract_id
                }
            ],
            'apply_date': apply_date
        }

        if action is not None:
            payload['data'][0].update({'action': action})

        response = super().pg_post('/api/payment/ach_apply', payload, auth=auth)

        return response

    def ach_auth_result(self, auth, date=None):
        """
        Function to do ach apply ftp file to bank
        :param auth: get from cipher
        :param date: format is YYYY/MM/DD, default value automatically set 10 working days ago (optional)
        Examples:
        | Ach Auth Result | PAYLOAD |
        """
        payload = {}

        if date is not None:
            payload.update({'date': date})

        response = super().pg_post('/api/payment/ach_auth_result', payload, auth=auth)

        return response

    def ach_writeoff(self, writeoff_date, auth):
        """
        Function to do ach apply ftp file to bank
        :param writeoff_date: string type, format is YYYYMMDD
        :param auth: get from cipher
        Examples:
        | Ach Writeoff Get | PAYLOAD |
        """
        payload = {
            'writeoffDate': writeoff_date
        }

        response = super().pg_post('/api/payment/ach_writeoff', payload, auth=auth)

        return response

    def ach_writeoff_apply(self, apply_date, bill_due_date, auth):
        """
        Function to do ach apply ftp file to bank
        :param apply_date: string type, epoch_time
        :param bill_due_date: string type, epoch_time
        :param auth: get from cipher
        Examples:
        | Ach Writeoff Apply Post | PAYLOAD |
        """
        payload = {
            'applyDate': apply_date,
            'billDuedate': bill_due_date
        }

        response = super().pg_post('/api/payment/ach_writeoff_apply', payload, auth=auth)

        return response
