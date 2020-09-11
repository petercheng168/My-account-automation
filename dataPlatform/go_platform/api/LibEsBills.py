import os
import sys
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsBills(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_bills_get(self, es_bill_ids=[], tran_no=None, user_id=None,
                     bill_period=None, date_from=None, date_to=None,
                     store_barcode2=None, issue_date_from=None,
                     issue_date_to=None, settle_date_from=None,
                     settle_date_to=None, due_date_from=None, due_date_to=None,
                     payment_status=None, payment_type=None,
                     over_due_paid_receive_date_from=None,
                     over_due_paid_receive_date_to=None,
                     bill_status=[], delivery_method=None,
                     request_data_type=None, print_invoice=None,
                     accumulated=None, total_section_num=None,
                     section_num=None, offset=None, limit=None, account=None):
        """ Get the bill

        Examples:
        | ${resp} = | Es Bills Get | data |
        """
        self.init.authHeader(account)
        es_bill_ids = es_bill_ids.split(',') if es_bill_ids else es_bill_ids
        bill_status = bill_status.split(',') if bill_status else bill_status
        data = {
            "op_code": "get",
            "get_data": {
                "es_bill_ids": es_bill_ids,
                "tran_no": tran_no,
                "user_id": user_id,
                "bill_period": bill_period,
                "date_from": date_from,
                "date_to": date_to,
                "store_barcode2": store_barcode2,
                "issue_date_from": issue_date_from,
                "issue_date_to": issue_date_to,
                "settle_date_from": settle_date_from,
                "settle_date_to": settle_date_to,
                "due_date_from": due_date_from,
                "due_date_to": due_date_to,
                "payment_status": payment_status,
                "payment_type": payment_type,
                "over_due_paid_receive_date_from": over_due_paid_receive_date_from,
                "over_due_paid_receive_date_to": over_due_paid_receive_date_to,
                "bill_status_list": bill_status,
                "delivery_method": delivery_method,
                "request_data_type": request_data_type,
                "print_invoice": print_invoice,
                "accumulated": accumulated,
                "total_section_num": total_section_num,
                "section_num": section_num,
                "offset": offset,
                "limit": limit
            }
        }
        resp = self.init.request('post', "/es-bills", json=data)
        return resp

    def es_bills_post(self, user_id=None, bill_period=None, bank_barcode1=None,
                      bank_barcode2=None, store_barcode1=None,
                      store_barcode2=None, store_barcode3=None,
                      bill_to_address=None, bill_to_zipcode=None,
                      bill_to_email=None, due_date=None, date_from=None,
                      date_to=None, amount=None, settle_days=None,
                      tran_no=None, bill_to_name=None, base_price_amount=None,
                      over_unit_price_amount=None, other_charge_amount=None,
                      addon_price_amount=None, promotion_price_amount=None,
                      penalty_amount=None, issue_date=None,
                      delivery_method=None, es_contract_id=None,
                      scooter_id=None, resource_type=None, other_data=None,
                      details_amount=None, latest_bill_calc_end_date=None,
                      tax_amount=None, tax_rate=None, adjustment_amount=None,
                      balance=None, bill_status=None, previous_balance=None,
                      previous_paid_amount=None, bill_type=1, payment_type=1,
                      suspend_days=0, resource_id=None, print_invoice=None,
                      accumulated_es_bill_id=None, discarded_es_bill_id=None, unissued_invoice_amount=0, taxable_amount=0, account=None):
        """ Add the bill

        Examples:
        | ${resp} = | Es Bills Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "accumulated_es_bill_id": accumulated_es_bill_id,
                    "discarded_es_bill_id": discarded_es_bill_id,
                    "unissued_invoice_amount": unissued_invoice_amount,
                    "user_id": user_id,
                    "bill_period": bill_period,
                    "bill_type": bill_type,
                    "bank_barcode1": bank_barcode1,
                    "bank_barcode2": bank_barcode2,
                    "store_barcode1": store_barcode1,
                    "store_barcode2": store_barcode2,
                    "store_barcode3": store_barcode3,
                    "payment_type": payment_type,
                    "bill_to_addr": bill_to_address,
                    "bill_to_zipcode": bill_to_zipcode,
                    "bill_to_email": bill_to_email,
                    "due_date": due_date,
                    "amount": amount,
                    "issue_date": issue_date,
                    "date_from": date_from,
                    "date_to": date_to,
                    "settle_days": settle_days,
                    "tran_no": tran_no,
                    "bill_to_name": bill_to_name,
                    "base_price_amount": base_price_amount,
                    "over_unit_price_amount": over_unit_price_amount,
                    "other_charge_amount": other_charge_amount,
                    "addon_price_amount": addon_price_amount,
                    "promotion_price_amount": promotion_price_amount,
                    "penalty_amount": penalty_amount,
                    "delivery_method": delivery_method,
                    "previous_balance": previous_balance,
                    "previous_paid_amount": previous_paid_amount,
                    "es_bill_scooters": [
                        {
                            "es_contract_id": es_contract_id,
                            "scooter_id": scooter_id,
                            "date_from": date_from,
                            "date_to": date_to,
                            "suspend_days": suspend_days,
                            "details": [
                                {
                                    "resource_type": resource_type,
                                    "resource_id": resource_id,
                                    "other_data": other_data,
                                    "amount": details_amount
                                }
                            ]
                        }
                    ],
                    "latest_bill_calc_end_date": latest_bill_calc_end_date,
                    "tax_amount": tax_amount,
                    "tax_rate": tax_rate,
                    "adjustment_amount": adjustment_amount,
                    "balance": balance,
                    "bill_status": bill_status,
                    "taxable_amount": taxable_amount,
                    "print_invoice": print_invoice
                }
            ]
        }
        resp = self.init.request('post', "/es-bills", json=data)
        return resp
