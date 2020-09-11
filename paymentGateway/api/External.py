# -*- coding: utf-8 -*-
import json
import os
import sys
import time
import urllib.parse
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from paymentGateway.api.Base import Base
from lib.LibLogger import set_logger
from lib.LibCrypto import LibCrypto

logger = set_logger(__name__)


class External(Base):

    def __init__(self):
        super().__init__()
        self.member_id = self.variable.get_var('PAYMENT_GATEWAY_MEMBER_ID')
        self.api_key = self.variable.get_var('PAYMENT_GATEWAY_API_KEY')

    def taishin_bank_auth(self, card_no1, card_no2, card_no3, card_no4, card_number, expired_month, expired_year,
                          expired_date, trans_id, cvv2, card_name):
        """ Taishin Bank auth API """
        card_name = urllib.parse.quote(card_name)

        self.headers.update({
            'Content-Type': 'application/x-www-form-urlencoded',
            'Referer': 'https://apposweb-t.taishinbank.com.tw/O2OgwApi/card/Index/{}'.format(trans_id)
        })

        payload = 'CardNo1={}&CardNo2={}&CardNo3={}&CardNo4={}&CardNumber={}&TransId={}&TradeAmount=0&' \
                  'ExpMonth={}&ExpYear={}&ExpDate={}&Cvv2={}&CardName={}'. \
            format(card_no1, card_no2, card_no3, card_no4, card_number, trans_id, expired_month,
                   expired_year, expired_date, cvv2, card_name)

        response = super().external_request('post', '/O2OgwApi/Card/PostCard', data=payload)

        return response

    def taishin_3d_verification_auth(self, request_url):
        self.tspg_url = request_url
        response = super().external_request('get', request_url)

        return response

    def taishin_delete_credit_card(self, appos_id, trans_no, card_token, member_id, random):
        time_stamp = str(int(time.time()))

        payload = {
            'ApiVer': '1.0.0',
            'ApposId': appos_id,
            'TransNo': trans_no,
            'RequestParams': {
                'CardToken': card_token,
                'MemberId': member_id
            },
            'TimeStamp': time_stamp,
            'Random': random
        }

        sort_json = json.dumps(payload, sort_keys=True)
        format_text = 'request={}&apikey={}'.format(sort_json, self.api_key).replace(' ', '')

        encrypt = LibCrypto()
        check_sum = encrypt.encode_text_with_base64(format_text, 'sha256').upper()

        payload.update({'CheckSum': check_sum})

        response = super().external_request('post', '/O2OgwApi/api/ws/DeleteCreditCardAuth', data=payload)

        return response

    def credit_card_transaction_charges_received(self, ver, mid, tid, pay_type, tx_type, ret_code, ret_msg, order_no,
                                                 auth_id_resp, rrn, order_status, purchase_date, tx_amt,
                                                 first_6_digit_of_pan, last_4_digit_of_pan):
        """
        Receive the transaction result by bank and transaction type
        :param ver: string type, version, value is 1.0.0
        :param mid: string type, 999812666555029
        :param tid: string type, T0000000
        :param pay_type: integer type, 1:credit card
        :param tx_type: integer type, 1: authorization, 3: payment request, 4: cancel payment request, 5: refund,
               6: cancel refund, 7: query, 8: cancel authorization
        :param ret_code: string type, 00: success, other is failed
        :param ret_msg: string type
        :param order_no: string type, <categoryType>_<hash(es_bill_id)>_<3 digit random string>, example: 2103_pmaDJQNy_e9j
        :param auth_id_resp: string type
        :param rrn: string type
        :param order_status: string type, 02: Authorized, 03: money requested, 04: money request settled, 06: refunded,
               08: refund settled, 12: order canceled, ZP: order processing, ZF: authorization failed
        :param purchase_date: string type, yyyy-MM-dd HH:mm:ss
        :param tx_amt: string type, 10000 represents 100 NT dollars
        :param first_6_digit_of_pan: string type, first 6 digit of credit card number
        :param last_4_digit_of_pan: string type, last 4 digit of credit card number
        """
        payload = {
            'ver': ver,
            'mid': mid,
            'tid': tid,
            'pay_type': pay_type,
            'tx_type': tx_type,
            'params': {
                'ret_code': ret_code,
                'ret_msg': ret_msg,
                'order_no': order_no,
                'auth_id_resp': auth_id_resp,
                'rrn': rrn,
                'order_status': order_status,
                'purchase_date': purchase_date,
                'tx_amt': tx_amt,
                'first_6_digit_of_pan': first_6_digit_of_pan,
                'last_4_digit_of_pan': last_4_digit_of_pan
            }
        }

        response = super().pg_request('post', '/api/payment/v1/transaction/charges/taishin/online-credit-card/received',
                                      payload)

        return response

    def atm_transaction_charges_received(self, transaction_no, t_date, amt, trnact_no, s_date, time, txn_code, sign):
        """
        Receive the transaction result by bank and transaction type
        :param transaction_no: string type, ID(8) + ACCT(14)+ TDATE(8) + SEQ(6) + DS(2), ID:tax ID number,
               ACCT:bank account, TDATE:accounting Date, SEQ:six numbers, DS:TB(NT dollar) and FN(the other)
        :param t_date: string type, YYYYMMDD
        :param amt: string type
        :param trnact_no: string type, virtual account, 14 number or 16 number
        :param s_date: string type, YYYYMMDD
        :param time: string type, HHMMSS
        :param txn_code: string type, payment code, OTC, ATM, REM
        :param sign: string type, Positive or negative, ex:+ or -
        """
        payload = {
            'row': {
                'TransactionNo': transaction_no,
                'TDATE': t_date,
                'AMT': amt,
                'TRNACTNO': trnact_no,
                'SDATE': s_date,
                'TIME': time,
                'TXNCODE': txn_code,
                'SIGN': sign
            }
        }

        response = super().pg_request('post', '/api/payment/v1/transaction/charges/taishin/atm/received', payload)

        return response
