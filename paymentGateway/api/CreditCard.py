# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from paymentGateway.api.Base import Base
from lib.LibLogger import set_logger

logger = set_logger(__name__)


class CreditCard(Base):
    """
    API DOC URL: https://pg-test.gogoro.com/api-docs/#/Taishin%20Bank%20Credit%20Card
    """

    def __init__(self):
        super().__init__()

    def get_3d_verification_page(self, layout, order_no, currency, amount, post_back_url, card_number, expired_date,
                                 auth, **kwargs):
        """
        Get the 3D verification page from bank
        :param layout: string type, 1:normal web page, 2:mobile page
        :param order_no: string type
        :param currency: string type ex:NTD
        :param amount: string type
        :param post_back_url: string type
        :param card_number: string type
        :param expired_date: string type, format:(YYMM)
        :param auth: get from cipher
        :param kwargs: (payTarget) string type, 2103:for pay bill, default: 2103, (orderDesc) string type,
                       (installPeriod) string type, (useRedeem) string type , 1: deduct, all optional,
                       (cvv2) string type
        """
        payload = {
            'layout': layout,
            'orderNo': order_no,
            'cur': currency,
            'amt': amount,
            'postBackUrl': post_back_url,
            'cardNumber': card_number,
            'expiredDate': expired_date
        }

        for key, value in kwargs.items():
            if key == 'payTarget' or key == 'orderDesc' or key == 'installPeriod' or key == 'useRedeem' or key == 'cvv2':
                payload.update({key: value})
            else:
                raise Exception('The {} is not in the API parameter'. format(key))

        response = super().pg_post('/api/payment/get_3D_verification_page', payload, auth=auth)

        return response

    def refund_3d_verification(self, order_no, amount, auth, **kwargs):
        """
        Refund for 3D verification
        :param order_no: string type
        :param amount: string type
        :param auth: get from cipher
        :param kwargs: (payTarget) string type, 2103:for pay bill, default: 2103, optional
        """
        payload = {
            'orderNo': order_no,
            'amt': amount
        }

        for key, value in kwargs.items():
            if key == 'payTarget':
                payload.update({key: value})
            else:
                raise Exception('The {} is not in the API parameter'. format(key))

        response = super().pg_post('/api/payment/3D_verification_refund', payload, auth=auth)

        return response

    def order_status_3d_verification(self, order_no, auth, **kwargs):
        """
        Query order status for 3D verification
        :param order_no: string type
        :param auth: get from cipher
        :param kwargs: (payTarget) string type, 2103:for pay bill, default: 2103, optional
        """
        payload = {
            'orderNo': order_no
        }

        for key, value in kwargs.items():
            if key == 'payTarget':
                payload.update({key: value})
            else:
                raise Exception('The {} is not in the API parameter'.format(key))

        response = super().pg_post('/api/payment/3D_verification_order_status', payload, auth=auth)

        return response

    def write_off_3d_verification(self, ret_code, ret_msg, order_no, order_status, purchase_date, tx_amt,
                                  first_6_digit_of_pan, last_4_digit_of_pan, auth):
        """
        Write off for 3D verification
        :param ret_code: string type, 00:success, other:failed
        :param ret_msg: string type
        :param order_no: string type
        :param order_status: string type
        :param purchase_date: string type, format:(yyyy-MM-dd HH:mm:ss)
        :param tx_amt: string type
        :param first_6_digit_of_pan: string type
        :param last_4_digit_of_pan: string type
        :param auth: get from cipher
        """
        payload = {
            'ret_code': ret_code,
            'ret_msg': ret_msg,
            'orderNo': order_no,
            'order_status': order_status,
            'purchase_date': purchase_date,
            'tx_amt': tx_amt,
            'first_6_digit_of_pan': first_6_digit_of_pan,
            'last_4_digit_of_pan': last_4_digit_of_pan
        }

        response = super().pg_post('/api/payment/3D_verification_write_off', payload, auth=auth)

        return response

    def get_card_page(self, order_no, member_id, payment_type, success_url, fail_url, auth):
        """
        Get a page for binding credit card from bank
        :param order_no: string type
        :param member_id: string type
        :param payment_type: integer type, 1:credit card, 2:bank account
        :param success_url: string type
        :param fail_url: string type
        :param auth: get from cipher
        """
        payload = {
            'OrderNo': order_no,
            'MemberId': member_id,
            'PaymentType': payment_type,
            'SuccessUrl': success_url,
            'FailUrl': fail_url
        }

        response = super().pg_post('/api/payment/get_card_page', payload, auth=auth)

        return response

    def update_result(self, trans_no, payment_type, order_no, member_id, card_token, card_number, card_hash, exp_date,
                      card_name, card_status, card_type, time_stamp, **kwargs):
        """
        Result_url for binding credit card from bank
        :param trans_no: string type
        :param payment_type: string type, credit card(default):04, account link:03
        :param order_no: string type
        :param member_id: string type, user_id hashable
        :param card_token: string type
        :param card_number: string type
        :param card_hash: string type
        :param exp_date: string type
        :param card_name: string type, ex:台新銀行信用卡
        :param card_status: string type, 0:applying, 1:in use, 2:suspend, 3:invalid
        :param card_type: string type, 1:Visa card, 2:Master card, 3:JCB card, 4:American Express, 5:Union Pay,
                                       6:Smart Pay
        :param time_stamp: string type
        :param kwargs: (ResultUrl) string type, (ApiVer) string type, (ApposId) string type, (BankNo) string type,
                       (Random) string type, (CheckSum) string type, all optional
        """
        payload = {
            'TransNo': trans_no,
            'RequestParams': {
                'PaymentType': payment_type,
                'OrderNo': order_no,
                'MemberId': member_id,
                'CardToken': card_token,
                'CardNumber': card_number,
                'CardHash': card_hash,
                'ExpDate': exp_date,
                'CardName': card_name,
                'CardStatus': card_status,
                'CardType': card_type
            },
            'TimeStamp': time_stamp,
        }

        for key, value in kwargs.items():
            if key == 'ResultUrl' or key == 'ApiVer' or key == 'ApposId' or key == 'Random' or key == 'CheckSum':
                payload.update({key: value})
            if key == 'BankNo':
                payload['RequestParams'].update({key: value})
            else:
                raise Exception('The {} is not in the API parameter'.format(key))

        response = super().pg_post('/api/payment/update_result', payload)

        return response

    def auth(self, bank_code, payment_type, trade_no, card_token, amount, mode, auth, **kwargs):
        """
        Get a page for binding credit card from bank
        :param bank_code: string type ex:taishin=812
        :param payment_type: integer type, 1:credit card, 2:bank account link
        :param trade_no: string type
        :param card_token: string type
        :param amount: number type
        :param mode: integer type, 0:normal, 1:installment plan
        :param auth: get from cipher
        :param kwargs: (InstalledPeriods) integer type, (Name) string type, (Price) string type,
                       (Quantity) string type, all optional
        """
        payload = {
            'BankCode': bank_code,
            'PaymentType': payment_type,
            'TradeNo': trade_no,
            'CardToken': card_token,
            'Amount': amount,
            'Mode': mode
        }

        for key, value in kwargs.items():
            if key == 'InstalledPeriods':
                payload.update({key: value})
            elif key == 'Name' or key == 'Price' or key == 'Quantity':
                if 'item' in payload:
                    payload['item'].update({key: value})
                else:
                    payload.update({'item': {key: value}})
            else:
                raise Exception('The {} is not in the API parameter'.format(key))

        response = super().pg_post('/api/payment/auth', payload, auth=auth)

        return response

    def credit_card_list(self, bank_code, member_id, auth):
        """
        Get the status of the credit card
        :param bank_code: string type ex:taishin=812
        :param member_id: string type
        :param auth: get from cipher
        """
        payload = {
            'BankCode': bank_code,
            'MemberId': member_id,
        }

        response = super().pg_post('/api/payment/credit_card_list', payload, auth=auth)

        return response

    def delete_credit_card(self, bank_code, card_token, member_id, credit_card_id, wallet_id, auth):
        """
        Delete credit card from wallet
        :param bank_code: string type, ex:taishin=812
        :param card_token: string type
        :param member_id: string type
        :param credit_card_id: string type
        :param wallet_id: string type
        :param auth: get from cipher
        """
        payload = {
            'BankCode': bank_code,
            'CardToken': card_token,
            'MemberId': member_id,
            'CreditCardId': credit_card_id,
            'WalletId': wallet_id
        }

        response = super().pg_post('/api/payment/delete_credit_card', payload, auth=auth)

        return response
