import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibParts(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def parts_get(self, part_id=None, parts_category_id=None, part_code=None, language_code=None, name=None, category_type=None, category_subtype=None, sale_status=None, offset=None, limit=None, account=None):
        """ Get Part info

        Examples:
        | ${resp} = | Parts Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "part_id": part_id,
                "parts_category_id": parts_category_id,
                "part_code": part_code,
                "language_code": language_code,
                "name": name,
                "category_type": category_type,
                "category_subtype": category_subtype,
                "sale_status": sale_status,
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request('post', "/parts", json=data)
        return resp

    def parts_post(self, sequence_id=None, part_code=None, part_category_type=None, part_category_sub_type=None, parts_category_id=None, brand_company_code=None, names=None,
                    production_start_time=None, production_end_time=None, sale_status=None, sale_suspend_time=None,
                    warranty_period=None, warranty_distance=None, endurance_period=None, endurance_distance=None, prices=None, account=None):
        """ Create Part

        Examples:
        | ${resp} = | Parts Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "sequence_id": sequence_id,
            "add_data": [
                {
                    "part_code": part_code,
                    "type": part_category_type,
                    "subtype": part_category_sub_type,
                    "parts_category_id" : parts_category_id,
                    "brand_company_code" : brand_company_code,
                    "name": names,
                    "production_start_time": production_start_time,
                    "production_end_time": production_end_time,
                    "sale_status": sale_status,
                    "sale_suspend_time": sale_suspend_time,
                    "warranty_period": warranty_period,
                    "warranty_distance": warranty_distance,
                    "endurance_period": endurance_period,
                    "endurance_distance": endurance_distance,
                    "prices": prices
                }
            ]
        }
        resp = self.init.request('post', "/parts", json=data)
        return resp

    def parts_update(self, sequence_id=None, part_code=None, part_category_type=None, part_category_sub_type=None, parts_category_id=None, brand_company_code=None, names=None,
                    production_start_time=None, production_end_time=None, sale_status=None, sale_suspend_time=None,
                    warranty_period=None, warranty_distance=None, endurance_period=None, endurance_distance=None, prices=None, account=None):
        """ Update Part

        Examples:
        | ${resp} = | Parts Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "sequence_id": sequence_id,
            "update_data": [
                {
                    "part_code": part_code,
                    "type": part_category_type,
                    "subtype": part_category_sub_type,
                    "parts_category_id": parts_category_id,
                    "brand_company_code": brand_company_code,
                    "name": names,
                    "production_start_time": production_start_time,
                    "production_end_time": production_end_time,
                    "sale_status": sale_status,
                    "sale_suspend_time": sale_suspend_time,
                    "warranty_period": warranty_period,
                    "warranty_distance": warranty_distance,
                    "endurance_period": endurance_period,
                    "endurance_distance": endurance_distance,
                    "prices": prices
                }
            ]
        }
        resp = self.init.request('post', "/parts", json=data)
        return resp

