import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsPlanBundles(object):

    def __init__(self):
        self.init = _init_()

    def es_plan_bundle_add(self, es_plan_id=None, es_plan_bundle=None,
                           apply_bundle_at_selection=None, valid_from=None, valid_to=None, account=None):
        """Add es plan bundles
        Examples:
        | ${resp} = | Es Contracts Bundle Add | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": {
                "es_plan_id": es_plan_id,
                "es_plan_bundle": es_plan_bundle,
                "apply_bundle_at_selection": apply_bundle_at_selection,
                "valid_from": valid_from,
                "valid_to": valid_to
            }
        }

        resp = self.init.request('post', "/es-plan-bundles", json=data)
        return resp

    def es_plan_bundle_update(self, es_plan_id=None, es_plan_bundle=None,
                              apply_bundle_at_selection=None, valid_from=None, valid_to=None, account=None):
        """Update es plan bundles
        Examples:
        | ${resp} = | Es Contracts Bundle Update | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": {
                "es_plan_id": es_plan_id,
                "es_plan_bundle": es_plan_bundle,
                "apply_bundle_at_selection": apply_bundle_at_selection,
                "valid_from": valid_from,
                "valid_to": valid_to
            }
        }

        resp = self.init.request('post', "/es-plan-bundles", json=data)
        return resp

    def es_plan_bundle_get(self, es_plan_id=None, valid_time_from=None, valid_time_to=None, pagination_criteria=None,
                           account=None):
        """Get es plan bundles
        Examples:
        | ${resp} = | Es Contracts Bundle Get | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "es_plan_id": es_plan_id,
                "valid_time_from": valid_time_from,
                "valid_time_to": valid_time_to,
                "pagination_criteria": pagination_criteria
            }
        }

        resp = self.init.request('post', "/es-plan-bundles", json=data)
        return resp
