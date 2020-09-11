# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from paymentGateway.api.Base import Base
from lib.LibLogger import set_logger

logger = set_logger(__name__)


class ATM(Base):

    def __init__(self):
        super().__init__()

    def va_write_off(self, transaction_no, t_date, amt, trnact_no, s_date, time, txn_code, sign):
        """
        Real time write off by virtual account
        :param transaction_no: string type, VABID(12) + ACCT(14)+ DDATE(8) + SEQ(6) + DS(2), VABID:tax ID number,
               ACCT:bank account, DDATE:working date, SEQ:six numbers, DS:TB(NT dollar) and FN(the other)
        :param t_date: string type, accounting Date YYYYMMDD
        :param amt: integer type
        :param trnact_no: string type
        :param s_date: string type, transaction date YYYYMMDD
        :param time: string type, transaction time HHMMSS
        :param txn_code: string type, ex: OTC, ATM, REM
        :param sign:  string type, ex: + or -
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

        response = super().pg_post('/api/payment/va_write_off', payload)

        return response
