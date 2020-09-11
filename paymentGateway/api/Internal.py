# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from paymentGateway.api.Base import Base


class Internal(Base):

    def __init__(self):
        super().__init__()

    def credit_card_async_transaction_binds(self, transaction_id, transaction_type, pay_source_account_id,
                                            pay_target_account_id, pay_source_type, pay_target_type, success_url,
                                            fail_url, auth, plugin_id=None):
        payload = {
            'transactionId': transaction_id,
            'transactionType': transaction_type,
            'paySourceAccountId': pay_source_account_id,
            'payTargetAccountId': pay_target_account_id,
            'paySourceType': pay_source_type,
            'payTargetType': pay_target_type,
            'transactionData': {
                'successUrl': success_url,
                'failUrl': fail_url
            }
        }

        if plugin_id is not None:
            payload.update({'pluginId': plugin_id})

        response = super().pg_request('post', '/api/payment/v1/async/transaction/binds', payload, auth=auth)

        return response

    def ach_async_transaction_binds(self, transaction_id, transaction_type, pay_source_account_ids,
                                    pay_target_account_id, pay_source_type, pay_target_type, auth, plugin_id=None):
        payload = {
            'transactionId': transaction_id,
            'transactionType': transaction_type,
            'paySourceAccountIds': [pay_source_account_ids],
            'payTargetAccountId': pay_target_account_id,
            'paySourceType': pay_source_type,
            'payTargetType': pay_target_type,
            'transactionData': {}
        }

        if plugin_id is not None:
            payload.update({'pluginId': plugin_id})

        response = super().pg_request('post', '/api/payment/v1/async/transaction/binds', payload, auth=auth)

        return response

    def sync_transaction_binds(self, transaction_id, transaction_type, pay_source_account_id, pay_target_account_id,
                               pay_source_type, pay_target_type, credit_card_id, wallet_id, auth, plugin_id=None):
        payload = {
            'transactionId': transaction_id,
            'transactionType': transaction_type,
            'paySourceAccountId': pay_source_account_id,
            'payTargetAccountId': pay_target_account_id,
            'paySourceType': pay_source_type,
            'payTargetType': pay_target_type,
            'transactionData': {
                'creditCardId': credit_card_id,
                'walletId': wallet_id
            }
        }

        if plugin_id is not None:
            payload.update({'pluginId': plugin_id})

        response = super().pg_request('delete', '/api/payment/v1/sync/transaction/binds', payload, auth=auth)

        return response

    def sync_transaction_charges(self, transaction_id, transaction_type, pay_source_account_id, pay_target_account_id,
                                 pay_source_type, pay_target_type, amount, auth, **kwargs):

        payload = {
            'transactionId': transaction_id,
            'transactionType': transaction_type,
            'paySourceAccountId': pay_source_account_id,
            'payTargetAccountId': pay_target_account_id,
            'paySourceType': pay_source_type,
            'payTargetType': pay_target_type,
            'transactionData': {
                'amount': amount,
                'orderItems': [],
                'customParams': {}
            }
        }

        for key, value in kwargs.items():
            if key == 'categoryType' or key == 'pluginId':
                payload.update({key: value})
            elif key == 'currency' or key == 'token' or key == 'tokenType' or key == 'description':
                payload['transactionData'].update({key: value})
            elif key == 'name' or key == 'price' or key == 'quantity':
                payload['transactionData']['orderItems'][0].update({key: value})
            elif key == 'encryptedMethod' or key == 'encrytedData' or key == 'signature' or \
                    key == 'ephemeralPublicKey' or key == 'publicKeyHash' or key == 'deviceId':
                payload['transactionData']['customParams'].update({key: value})
            else:
                raise Exception('The {} is not in the API parameter'.format(key))

        response = super().pg_request('post', '/api/payment/v1/sync/transaction/charges', payload, auth=auth)

        return response

    def async_transaction_charges(self, transaction_id, transaction_type, pay_source_account_id, pay_target_account_id,
                                  pay_source_type, pay_target_type, amount, success_url, fail_url, card_number,
                                  expired_date, cvv2, auth, **kwargs):

        payload = {
            'transactionId': transaction_id,
            'transactionType': transaction_type,
            'paySourceAccountId': pay_source_account_id,
            'payTargetAccountId': pay_target_account_id,
            'paySourceType': pay_source_type,
            'payTargetType': pay_target_type,
            'transactionData': {
                'amount': amount,
                'successUrl': success_url,
                'failUrl': fail_url,
                'cardNumber': card_number,
                'expiredDate': expired_date,
                'cvv2': cvv2
            }
        }

        for key, value in kwargs.items():
            if key == 'categoryType' or key == 'pluginId':
                payload.update({key: value})
            elif key == 'currency' or key == 'description' or key == 'layout':
                payload['transactionData'].update({key: value})

        response = super().pg_request('post', '/api/payment/v1/async/transaction/charges', payload, auth=auth)

        return response
