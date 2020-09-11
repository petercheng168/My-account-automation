import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsContracts(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_contracts_get(self, es_contract_id, account=None):
        """Get es contract information.
        Examples:
        | ${resp} = | Es Contracts Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "es_contract_id": es_contract_id
            }
        }
        resp = self.init.request('post', "/es-contracts", json=data)
        return resp

    def es_contracts_add(self, es_contract_code=None,
                         scooter_contract_code=None, scooter_contract_id=None,
                         user_id=None, account_type=None, bill_to_user_id=None,
                         bill_to_user_type=None, contract_owner_id=None,
                         plan_id=None, rental_type=None, plan_start=None,
                         plan_end=None, plan_effective_date=None,
                         contract_type=None, payment_responsibility=None,
                         default_plan_id=None, contract_date=None,
                         contract_end=None, advanced_settlement_date=None,
                         advanced_settlement_emp_id=None, payment_type=None,
                         cycle_end_day=None, bill_delivery_method=None,
                         invoice_type=None, print_odometer_on_bill=None,
                         invoice_title=None, vat_number=None,
                         print_vat_on_invoice=None, status=None,
                         bank_virtual_account=None, scooters_ids=None,
                         scooters_vins=None, invoice_donate_to=None,
                         print_invoice=None, e_carrier_aggregation=None,
                         flow_status=None, addons=None, promotions=None):
        """Create es contracts.
        addon = {
                "addon_code": "string",
                "addon_id": "string",
                "start_date": 0,
                "end_date": 0,
                "effective_date": 0,
                "addon_type": 1,
                "payment_responsibility": 0
        }
        promotion = {
                "promotion_code": "string",
                "promotion_id": "string",
                "start_date": 0,
                "end_date": 0,
                "effective_date": 0
        }
        Examples:
        | ${resp} = | Es Contracts Add | data |
        """
        data = {
            "es_contract_code": es_contract_code,
            "scooter_contract_code": scooter_contract_code,
            "scooter_contract_id": scooter_contract_id,
            "user_id": user_id,
            "account_type": account_type,
            "bill_to_user_id": bill_to_user_id,
            "bill_to_user_type": bill_to_user_type,
            "contract_owner_id": contract_owner_id,
            "plan_id": plan_id,
            "rental_type": rental_type,
            "plan_start": plan_start,
            "plan_end": plan_end,
            "plan_effective_date": plan_effective_date,
            "contract_type": contract_type,
            "payment_responsibility": payment_responsibility,
            "default_plan_id": default_plan_id,
            "contract_date": contract_date,
            "contract_end": contract_end,
            "advanced_settlement_date": advanced_settlement_date,
            "advanced_settlement_emp_id": advanced_settlement_emp_id,
            "payment_type": payment_type,
            "cycle_end_day": cycle_end_day,
            "bill_delivery_method": bill_delivery_method,
            "invoice_type": invoice_type,
            "print_odometer_on_bill": print_odometer_on_bill,
            "invoice_title": invoice_title,
            "vat_number": vat_number,
            "print_vat_on_invoice": print_vat_on_invoice,
            "status": status,
            "bank_virtual_account": bank_virtual_account,
            "scooters_ids": [
                scooters_ids
            ],
            "scooters_vins": [
                scooters_vins
            ],
            "invoice_donate_to": invoice_donate_to,
            "print_invoice": print_invoice,
            "e_carrier_aggregation": e_carrier_aggregation,
            "flow_status": flow_status,
            "addons": [
                addons
            ],
            "promotions": [
                promotions
            ]
        }
        resp = self.init.request('post', "/es-contracts", json=data)
        return resp

    def es_contracts_post(self, order_id, user_id, account_type,
                          bill_to_user_id, bill_to_user_type, owner_id,
                          plan_id, plan_effective_date, contract_type,
                          payment_responsibility, status, cycle_end_day=31,
                          account=None):
        """Create es contracts.
        Examples:
        | ${resp} = | Es Contracts Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "scooter_contract_id": order_id,
                    "user_id": user_id,
                    "account_type": account_type,
                    "bill_to_user_id": bill_to_user_id,
                    "bill_to_user_type": bill_to_user_type,
                    "contract_owner_id": owner_id,
                    "plan_id": plan_id,
                    "rental_type": 1,
                    "plan_start": 1451606400,
                    "plan_end": 1546300800,
                    "plan_effective_date": plan_effective_date,
                    "contract_type": contract_type,
                    "payment_responsibility": payment_responsibility,
                    "default_plan_id": plan_id,
                    "contract_date": 1451606400,
                    "contract_end": 1546300800,
                    "advanced_settlement_date": 1451606400,
                    "advanced_settlement_emp_id": "18RAWmG6",
                    "payment_type": 1,
                    "cycle_end_day": cycle_end_day,
                    "bill_delivery_method": 1,
                    "invoice_type": 2,
                    "print_odometer_on_bill": 0,
                    "invoice_title": "string",
                    "vat_number": "string",
                    "print_vat_on_invoice": 0,
                    "status": status
                }
            ]
        }
        resp = self.init.request('post', "/es-contracts", json=data)
        return resp

    def es_contracts_update_addons(self, es_contract_id, plan_id, status,
                                   op_type, addon_id, start_date, end_date,
                                   effective_date, addon_type,
                                   payment_responsibility, addon_code=None,
                                   account=None):
        """Update es contracts addons
        Examples:
        | ${resp} = | Es Contracts Update Addons | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": {
                "es_contract_id": es_contract_id,
                "plan_id": plan_id,
                "plan_end": 0,    # 0 means that will not be update.
                "status": status,
                "addons": [
                    {
                        "op_type": op_type,
                        "addon_id": addon_id,
                        "start_date": start_date,
                        "end_date": end_date,
                        "effective_date": effective_date,
                        "addon_type": addon_type,
                        "payment_responsibility": payment_responsibility
                    }
                ]
            }
        }
        if addon_code:
            del data['update_data']['addons'][0]['addon_id']
            data['update_data']['addons'][0]['addon_code'] = addon_code
        resp = self.init.request('post', "/es-contracts", json=data)
        return resp

    def es_contracts_update_promotions(self, es_contract_id, plan_id, status,
                                       op_type, promotion_id, start_date,
                                       end_date, effective_date, account=None):
        """Update es contracts promotions.
        Examples:
        | ${resp} = | Es Contracts Update Promotions | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": {
                "es_contract_id": es_contract_id,
                "plan_id": plan_id,
                "plan_end": 0,    # 0 means that will not be update.
                "status": status,
                "promotions": [
                    {
                        "op_type": op_type,
                        "promotion_id": promotion_id,
                        "start_date": start_date,
                        "end_date": end_date,
                        "effective_date": effective_date
                    }
                ]
            }
        }
        resp = self.init.request('post', "/es-contracts", json=data)
        return resp

    def es_contracts_update_scooters(self, es_contract_id, plan_id, status,
                                     op_type, scooter_id, account=None):
        """Binding scooter to es_contract.

        Examples:
        | ${resp} = | Es Contracts Update Scooters | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": {
                "es_contract_id": es_contract_id,
                "plan_id": plan_id,
                "status": status,
                "scooters": [
                    {
                        "op_type": op_type,
                        "scooter_id": scooter_id
                    }
                ]
            }
        }
        resp = self.init.request('post', "/es-contracts", json=data)
        return resp

    def es_contracts_update_plan(self, es_contract_id, plan_id, plan_end,
                                 plan_effective_date, status, account=None):
        """Update es contract plan.

        Examples:
        | ${resp} = | Es Contracts Update Plan | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": {
                "es_contract_id": es_contract_id,
                "plan_id": plan_id,
                "plan_end": plan_end,
                "plan_effective_date": plan_effective_date,
                "status": status
            }
        }
        resp = self.init.request('post', "/es-contracts", json=data)
        return resp

    def es_contracts_search(self, user_id, account_type=1, status=None,
                            var_number=None, status_list=[], payment_freq=None,
                            cycle_end_day=None, contract_time_from=None,
                            contract_time_to=None, plan_end=None,
                            scooter_plate=None, scooter_vin=None,
                            payer_account_email=None,
                            payer_account_type_email=None,
                            plan_end_from=None, plan_end_to=None,
                            latest_bill_calc_end_date_from=None,
                            latest_bill_calc_end_date_to=None,
                            bill_delivery_method=None, offset=None, limit=None,
                            account=None):
        """Search es contracts.
        Examples:
        | ${resp} = | Es Contracts Search | data |
        """
        self.init.authHeader(account)
        status_list = status_list.split(',') if status_list else status_list
        data = {
            "op_code": "search",
            "search_data": {
                "user_id": user_id,
                "account_type": account_type,
                "var_number": var_number,
                "status": status,
                "status_list": status_list,
                "payment_freq": payment_freq,
                "cycle_end_day": cycle_end_day,
                "contract_time_from": contract_time_from,
                "contract_time_to": contract_time_to,
                "plan_end": plan_end,
                "extra_search_criteria": {
                    "scooter_plate": scooter_plate,
                    "scooter_vin": scooter_vin,
                    "payer_account_email": payer_account_email,
                    "payer_account_type_email": payer_account_type_email
                },
                "plan_end_from": plan_end_from,
                "plan_end_to": plan_end_to,
                "latest_bill_calc_end_date_from": latest_bill_calc_end_date_from,
                "latest_bill_calc_end_date_to": latest_bill_calc_end_date_to,
                "bill_delivery_method": bill_delivery_method,
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request('post', "/es-contracts", json=data)
        return resp
