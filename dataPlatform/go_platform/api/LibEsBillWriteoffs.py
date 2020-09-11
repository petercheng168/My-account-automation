from robot.libraries.BuiltIn import BuiltIn
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsBillWriteoffs(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_bill_writeoffs_update(self, es_bill_id, es_bill_writeoff_id, invoice_no, invoice_time,
                      invoice_type=4, writeoff_status=1, invoice_random_code=None, invoice_title=None,
                      vat_number=None, prize_status=0, credit_note_amount=0, invoice_donate_to=None, account=None):
        """
        Add the bill write off details information with dms source
        Arguments:
        :param invoice_type: int type,
        - 1: 二聯式發票, 2: 三聯式發票, 3: 電子計算機發票,
        - 4: 電子發票 – For invoices issued by POS, the caller should use this type. 5: Receipt (收據)
        Examples:
        | Es Bill Writeoffs Update | DATA |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "es_bill_id": es_bill_id,
                    "es_bill_writeoff_id": es_bill_writeoff_id,
                    "invoice_no": invoice_no,
                    "invoice_random_code": invoice_random_code,
                    "invoice_title": invoice_title,
                    "vat_number": vat_number,
                    "invoice_type": invoice_type,
                    "invoice_time": invoice_time,
                    "prize_status": prize_status,
                    "credit_note_amount": credit_note_amount,
                    "invoice_donate_to": invoice_donate_to,
                    "writeoff_status": writeoff_status
                }
            ]
        }
        resp = self.init.request('post', "/es-bill-writeoffs", json=data)
        return resp

    def es_bill_writeoffs_get(self, es_bill_writeoff_id=None, es_bill_id=None, status=None, invoice_type=None, offset=None, limit=None, account=None):
        """
        Retrieve the bill write off details information with dms source
        Arguments:
        :param status: int type,
        - 1: Normal writeoff 0: Writeoff is cancelled – The invoice (or receipt) is no longer valid 2: Credit Note 折讓 – If the writeoff_amount is equal to the credit_note amount, this writeoff (invoice) is considered
        : param invoice_type: int type,
        - 0: No information yet, 1: 二聯式發票, 2: 三聯式發票, 3: 電子計算機發票, 4: 電子發票 --For invoices issued by POS, the caller should use this type. 5 收據
        Examples:
        | Es Bill Writeoffs Get | DATA |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "es_bill_writeoff_id": es_bill_writeoff_id,
                "es_bill_id": es_bill_id,
                "status": status,
                "invoice_type": invoice_type,
                "offset": offset,
                "limit": limit
            }

        }
        resp = self.init.request('post', "/es-bill-writeoffs", json=data)
        return resp