#!/usr/bin/env python
# -*- coding: utf-8 -*-
import datetime
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibUtilityTestOrderUpdateInvoiceOpened(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def utility_test_order_update_invoice_opened_post(self, order_store_id, invoice_name, order_no, total_amt,
                                                        tc_order_no, invoice_no, token=None):
        """ Make invoice status from 待開立 to 已開立
        Args:
            OrderNo (str): dms_order_no

        Return:
            resp: Return json object

        Examples:
            | Utility Test Order Update Invoice Opened Post | PAYLOAD |
        """
        self.init.auth(token)
        today = datetime.datetime.today()
        today_str = today.strftime("%Y/%m/%d")
        time_str = today.strftime("%H:%M:%S")

        data = {
            "result": {
                "details": [
                    {
                        "data": {
                            "dealer_id": "1500",
                            "order_store_id": order_store_id,
                            "plan_order_store_id": "",
                            "order_type": "01",
                            "order_name": invoice_name,
                            "order_no": order_no,
                            "order_line": "002",
                            "order_date": today_str,
                            "order_time": "00:00",
                            "total_amt": total_amt,
                            "trans_type": "W1",
                            "receipt_type": "P1",
                            "sell_invoice": invoice_no,
                            "sell_invoice_tax_amt": 5951,
                            "inv_day": today_str,
                            "inv_time": time_str,
                            "comp_id": "00000064",
                            "eui_vehicle_no": "",
                            "eui_random_code": "4560",
                            "eui_print": "1",
                            "eui_print_trans": "0",
                            "eui_donate_no": "",
                            "eui_donate_status": "0",
                            "eui_vehicle_type_no": "",
                            "tc_order_no": tc_order_no, #SP20200302D00000025
                            "order_products": [
                                {
                                    "product_id": "GSACK-000-VG",
                                    "product_name": "GA7CK",
                                    "tax_flag": "1",
                                    "qty": 1,
                                    "ori_price": 131980,
                                    "ori_amt": 131980,
                                    "price": 131980,
                                    "amt": 131980,
                                    "tax_amt": 6285
                                },
                                {
                                    "product_id": "TES000001",
                                    "product_name": "GA7CK-餘額",
                                    "tax_flag": "1",
                                    "qty": 1,
                                    "ori_price": -7000,
                                    "ori_amt": -7000,
                                    "price": -7000,
                                    "amt": -7000,
                                    "tax_amt": -333
                                }
                            ],
                            "tender_detail": [
                                {
                                    "tender_no": "10",
                                    "tender_price": total_amt,
                                    "extra_price": 0,
                                    "sec_no": "",
                                    "credit_card_detail": {
                                        "tx_amount": total_amt,
                                        "card_no": "",
                                        "periods": 0,
                                        "bonus_use_point": 0,
                                        "bonus_point": 0,
                                        "bonus_dis_amt": 0
                                    }
                                }
                            ]
                        }
                    }
                ]
            }
        }

        resp = self.init.request('post', '/utility/test-order-update-invoice-opened', json=data)
        return resp
