from robot.libraries.BuiltIn import BuiltIn
import os
import sys
import time
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsBillWriteoffDetails(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_bill_writeoff_details_post(self, transaction_id, transaction_time,
                                      es_bill_id, amount, collection_time=None,
                                      es_bill_writeoff_id=None,
                                      credit_card_no=None,
                                      transaction_source=9,
                                      credit_card_type=1, description=None,
                                      account=None):
        """
        Add the bill write off details
        Arguments:
        :param credit_card_type: int type, 0: Not specified, 1: Visa, 2: Master Card, 3: American Express, 4: Discover Card, 5: JCB
        :param credit_crad_no: string type, E.g. 0123-45xx-xxxx-6789
        Examples:
        | Es Bill Writeoff Details Post | DATA |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": {
                "transaction_id": transaction_id,
                "transaction_time": transaction_time,
                "collection_time": collection_time,
                "transaction_source": transaction_source,
                "writeoff_details": [
                    {
                        "es_bill_id": es_bill_id,
                        "es_bill_writeoff_id": es_bill_writeoff_id,
                        "amount": amount,
                        "credit_card_type": credit_card_type,
                        "credit_card_no": credit_card_no,
                        "description": description
                    }
                ]
            }
        }
        resp = self.init.request(
            'post', "/es-bill-writeoff-details", json=data)
        return resp

    def es_bill_writeoff_details_with_balance(self, es_bill_id, es_contract_id,
                                              paid_amount,
                                              transaction_type,
                                              balance_amount,
                                              transaction_source=99,
                                              collection_time=None,
                                              es_bill_writeoff_id=None,
                                              credit_card_no=None,
                                              credit_card_type=1,
                                              description=None,
                                              scooter_id=None, account=None):
        """
        Add the bill write off details
        Arguments:
        :param credit_card_type: int type, 0: Not specified, 1: Visa, 2: Master Card, 3: American Express, 4: Discover Card, 5: JCB
        :param credit_crad_no: string type, E.g. 0123-45xx-xxxx-6789
        Examples:
        | Es Bill Writeoff Details With Balance | Data |
        """
        self.init.authHeader(account)
        time_now = int(time.time())
        data = {
            "op_code": "add",
            "add_data": {
                "transaction_id": int(time.time() * 1000),
                "transaction_time": time_now,
                "collection_time": collection_time,
                "transaction_source": transaction_source,
                "writeoff_details": [
                    {
                        "es_bill_id": es_bill_id,
                        "es_bill_writeoff_id": es_bill_writeoff_id,
                        "amount": paid_amount,
                        "credit_card_type": credit_card_type,
                        "credit_card_no": credit_card_no,
                        "description": description,
                        "contract_balance_transaction": {
                            "es_contract_id": es_contract_id,
                            "transaction_type": transaction_type,
                            "amount": balance_amount,
                            "description": description,
                            "scooter_id": scooter_id
                        }
                    }
                ]
            }
        }
        resp = self.init.request('post', "/es-bill-writeoff-details", json=data)
        return resp

    def es_bill_writeoff_details_get(self, es_bill_writeoff_id=None,
                                        es_bill_id=None, transaction_id=None,
                                        transaction_id_list=[],
                                        transaction_source=None,
                                        transaction_source_list=[],
                                        transaction_time_from=None,
                                        transaction_time_to=None,
                                        offset=None, limit=None, account=None):
        """
        Get the es-bill-writeoff-details
        Arguments:
        :param transaction_source: int type, 1. atm, 2. 臨櫃, 3. 超商, 4. ACH, 5. 信用卡約定扣繳, 6. credit card, 7. go bank, 8. gogoro store cash, 9. gogoro store credit card, 10. 電匯, 11. 內部轉帳, 12, NEAR 抵銷帳款, 13. DISC 折讓, 14. apple pay, 99. 其他
        Examples:
        | Es Bill Writeoff Details Get | DATA |
        """
        self.init.authHeader(account)
        transaction_id_list = transaction_id_list.split(
            ',') if transaction_id_list else transaction_id_list
        transaction_source_list = transaction_source_list.split(
            ',') if transaction_source_list else transaction_source_list
        data = {
            "op_code": "get",
            "get_data": {
                "es_bill_writeoff_id": es_bill_writeoff_id,
                "es_bill_id": es_bill_id,
                "transaction_id": transaction_id,
                "transaction_id_list": transaction_id_list,
                "transaction_source": transaction_source,
                "transaction_source_list": transaction_source_list,
                "transaction_time_from": transaction_time_from,
                "transaction_time_to": transaction_time_to,
                "offset": offset,
                "limit": limit
            }
        }
        resp = self.init.request(
            'post', "/es-bill-writeoff-details", json=data)
        return resp

    def dms_es_bill_writeoff_details_post(self, transaction_id,
                                          transaction_time, es_bill_id,
                                          amount, collection_time=None,
                                          es_bill_writeoff_id=None,
                                          credit_card_no=None,
                                          transaction_source=9,
                                          credit_card_type=1, description=None,
                                          account=None):
        """
        Add the bill write off details
        Arguments:
        :param credit_card_type: int type, 0: Not specified, 1: Visa, 2: Master Card, 3: American Express, 4: Discover Card, 5: JCB
        :param credit_crad_no: string type, E.g. 0123-45xx-xxxx-6789
        Examples:
        | Dms Es Bill Writeoff Details Post | DATA |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": {
                "transaction_id": transaction_id,
                "transaction_time": transaction_time,
                "collection_time": collection_time,
                "transaction_source": transaction_source,
                "writeoff_details": [
                    {
                        "es_bill_id": es_bill_id,
                        "es_bill_writeoff_id": es_bill_writeoff_id,
                        "amount": amount,
                        "credit_card_type": credit_card_type,
                        "credit_card_no": credit_card_no,
                        "description": description
                    }
                ]
            }
        }
        resp = self.init.request(
            'post', "/dms/es-bill-writeoff-details", json=data)
        return resp
