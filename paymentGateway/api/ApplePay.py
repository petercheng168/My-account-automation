# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from paymentGateway.api.Base import Base
from lib.LibLogger import set_logger

logger = set_logger(__name__)


class ApplePay(Base):

    def __init__(self):
        super().__init__()
    
    def apple_pay(self, order_no, version, data, signature, ephemeral_public_key, public_key_hash, transaction_id,
                  auth, **kwargs):
        """
        Function to apply apple pay information.
        :param order_no: string type, dms order number
        :param version: string type, value is RSA_v1 or EC_v1
        :param data: string type
        :param signature: string type
        :param ephemeral_public_key: string type, EC_v1 only
        :param public_key_hash: string type
        :param transaction_id: string type
        :param auth: get from cipher
        :param kwargs: (bankCode) string type ex:taishin=812, (payTarget) string type, (amt) number type, all optional
        Examples:
        | Apple Pay | PAYLOAD |
        """
        payload = {
            'orderNo': order_no,
            'version': version,
            'data': data,
            'signature': signature,
            'ephemeralPublicKey': ephemeral_public_key,
            'publicKeyHash': public_key_hash,
            'transactionId': transaction_id
        }

        for key, value in kwargs.items():
            if key == 'bankCode' or key == 'payTarget' or key == 'amt':
                payload.update({key: value})
            else:
                raise Exception('The {} is not in the API parameter'.format(key))

        response = super().pg_post('/api/payment/apple_pay', payload, auth=auth)

        return response

    def apple_pay_refund(self, order_no, auth, **kwargs):
        """
        Function to apply apple pay refund information.
        :param order_no: string type, dms order number
        :param auth: get from cipher
        :param kwargs: (bankCode) string type ex:taishin=812, optional
        Examples:
        | Apple Pay Refund | PAYLOAD |
        """
        payload = {
            'orderNo': order_no
        }

        for key, value in kwargs.items():
            if key == 'bankCode':
                payload.update({key: value})
            else:
                raise Exception('The {} is not in the API parameter'.format(key))

        response = super().pg_post('/api/payment/apple_pay_refund', payload, auth=auth)

        return response
