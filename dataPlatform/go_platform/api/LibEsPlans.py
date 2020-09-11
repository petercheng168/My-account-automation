import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsPlans(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_plans_get(self, plan_id=None, status=None, published=None,
                     valid_time_from=None, valid_time_to=None,
                     carrier_type_list=None, scooter_model_id_list=None,
                     account=None):
        """Get all es plans.

        carrier_type_list (list): default is 2 in SP

        Examples:
        | ${resp} = | Es Plans Get | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "get",
            "get_data": {
                "plan_id": plan_id,
                "status": status,
                "published": published,
                "valid_time_from": valid_time_from,
                "valid_time_to": valid_time_to,
                "carrier_type_list": carrier_type_list,
                "scooter_model_id_list": scooter_model_id_list
            }
        }
        resp = self.init.request('post', "/es-plans", json=data)
        return resp

    def es_plans_get_via_plan_name(self, plan_name, account=None):
        """ Get specific es plan via es plan name
        Examples:
        | ${resp} = | Es Plans Get Via Plan Name | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "plan_name": plan_name,
                "published": 1
            }
        }
        resp = self.init.request('post', "/es-plans", json=data)
        return resp

    def es_plans_post(self, plan_name, description=None, country_code=None,
                      currency_code=None, payment_freq=None, plan_price=None,
                      plan_terms=None, plan_target=None, unit_base=None,
                      unit_threshold=None, over_unit_price=None,
                      unit_threshold_1=None, over_unit_price_1=None,
                      valid_time_from=None, valid_time_to=None,
                      early_termination_penalty=None, status=None,
                      published=None, plan_price_reward=None,
                      plan_price_usage=None,
                      include_free_regular_maintenance=None,
                      carrier_type=None, scooter_model_id_list=None,
                      account=None):
        """ Create es plan

        carrier_type (int, str): default = 2 (for solution backward compatible)

        Examples:
        | ${resp} = | Es Plans Post | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "plan_name": plan_name,
                    "description": description,
                    "country_code": country_code,
                    "currency_code": currency_code,
                    "payment_freq": payment_freq,
                    "plan_price": plan_price,
                    "plan_terms": plan_terms,
                    "plan_target": plan_target,
                    "unit_base": unit_base,
                    "unit_threshold": unit_threshold,
                    "over_unit_price": over_unit_price,
                    "unit_threshold_1": unit_threshold_1,
                    "over_unit_price_1": over_unit_price_1,
                    "valid_time_from": valid_time_from,
                    "valid_time_to": valid_time_to,
                    "early_termination_penalty": early_termination_penalty,
                    "status": status,
                    "published": published,
                    "plan_price_reward": plan_price_reward,
                    "plan_price_usage": plan_price_usage,
                    "include_free_regular_maintenance": include_free_regular_maintenance,
                    "carrier_type": carrier_type,
                    "scooter_model_id_list": scooter_model_id_list
                }
            ]
        }
        resp = self.init.request('post', "/es-plans", json=data)
        return resp

    def es_plans_update(self, plan_id, plan_name=None, description=None,
                        country_code=None, currency_code=None,
                        legacy_plan_code=None, payment_freq=None,
                        plan_price=None, plan_terms=None, plan_target=None,
                        unit_base=None, unit_threshold=None,
                        over_unit_price=None, unit_threshold_1=None,
                        over_unit_price_1=None, valid_time_from=None,
                        valid_time_to=None, early_termination_penalty=None,
                        status=None, published=None, plan_price_reward=None,
                        plan_price_usage=None,
                        include_free_regular_maintenance=None,
                        carrier_type=None, scooter_model_id_list=None,
                        account=None):
        """ Update es plan

        carrier_type (int, str): default = 2 (for solution backward compatible)

        Examples:
        | ${resp} = | Es Plans Update | data |
        """
        self.init.auth_header(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "plan_id": plan_id,
                    "plan_name": plan_name,
                    "description": description,
                    "country_code": country_code,
                    "currency_code": currency_code,
                    "legacy_plan_code": legacy_plan_code,
                    "payment_freq": payment_freq,
                    "plan_price": plan_price,
                    "plan_terms": plan_terms,
                    "plan_target": plan_target,
                    "unit_base": unit_base,
                    "unit_threshold": unit_threshold,
                    "over_unit_price": over_unit_price,
                    "unit_threshold_1": unit_threshold_1,
                    "over_unit_price_1": over_unit_price_1,
                    "valid_time_from": valid_time_from,
                    "valid_time_to": valid_time_to,
                    "early_termination_penalty": early_termination_penalty,
                    "status": status,
                    "published": published,
                    "plan_price_reward": plan_price_reward,
                    "plan_price_usage": plan_price_usage,
                    "include_free_regular_maintenance": include_free_regular_maintenance,
                    "carrier_type": carrier_type,
                    "scooter_model_id_list": scooter_model_id_list
                }
            ]
        }
        resp = self.init.request('post', "/es-plans", json=data)
        return resp
