import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibEsAddons(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def es_addons_get(self, addon_id=None, addon_name=None, status=None,
                      published=None, valid_time_from=None, valid_time_to=None,
                      account=None):
        """ Get all es addons

        Examples:
        | ${resp} = | Es Addons Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "addon_id": addon_id,
                "addon_name": addon_name,
                "status": status,
                "published": published,
                "valid_time_from": valid_time_from,
                "valid_time_to": valid_time_to
            }
        }
        resp = self.init.request('post', "/es-addons", json=data)
        return resp

    def es_addons_add(self, addon_code=None, addon_name=None, price=None, payment_frequency=None,
                      other_price_type=None, other_price=None, country_code=None, status=None, published=None,
                      valid_time_from=None, valid_time_to=None, free_terms_type=None, free_terms=None, addon_type=None,
                      account=None):
        """Add es addons

        Examples:
        | ${resp} = | Es Addons Add | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "addon_code": addon_code,
                    "addon_name": addon_name,
                    "price": price,
                    "payment_frequency": payment_frequency,
                    "other_price_type": other_price_type,
                    "other_price": other_price,
                    "country_code": country_code,
                    "status": status,
                    "published": published,
                    "valid_time_from": valid_time_from,
                    "valid_time_to": valid_time_to,
                    "free_terms_type": free_terms_type,
                    "free_terms": free_terms,
                    "addon_type": addon_type
                }
            ]
        }
        resp = self.init.request('post', "/es-addons", json=data)
        return resp

    def es_addons_update(self, addon_id=None, addon_code=None, addon_name=None, price=None, payment_frequency=None,
                         other_price_type=None, other_price=None, country_code=None, status=None, published=None,
                         valid_time_from=None, valid_time_to=None, free_terms_type=None, free_terms=None, addon_type=None,
                         account=None):
        """Update es addons

        Examples:
        | ${resp} = | Es Addons Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "addon_id": addon_id,
                    "addon_code": addon_code,
                    "addon_name": addon_name,
                    "price": price,
                    "payment_frequency": payment_frequency,
                    "other_price_type": other_price_type,
                    "other_price": other_price,
                    "country_code": country_code,
                    "status": status,
                    "published": published,
                    "valid_time_from": valid_time_from,
                    "valid_time_to": valid_time_to,
                    "free_terms_type": free_terms_type,
                    "free_terms": free_terms,
                    "addon_type": addon_type
                }
            ]
        }
        resp = self.init.request('post', "/es-addons", json=data)
        return resp
