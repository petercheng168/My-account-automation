import os
import sys
from robot.api import logger
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibPartsCategories(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def parts_categories_add(self, category_type=None, sub_type=None,
                             names=None, account=None):
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "type": category_type,
                    "sub_type": sub_type,
                    "name_list": names
                }
            ]
        }
        resp = self.init.request("post", "/parts/categories", json=data)
        return resp

    def parts_categories_update(self, part_category_id=None,
                                category_type=None, sub_type=None, names=None,
                                account=None):
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "part_category_id": part_category_id,
                    "type": category_type,
                    "sub_type": sub_type,
                    "name_list": names
                }
            ]
        }

        resp = self.init.request("post", "/parts/categories", json=data)
        return resp

    def parts_categories_get(self, part_category_id_list=None,
                             category_type=None, sub_type=None,
                             language_code=None, names=None, account=None):
        self.init.authHeader(account)
        part_category_id_list = part_category_id_list.split(
            ',') if part_category_id_list else part_category_id_list
        data = {
            "op_code": "get",
            "get_data": {
                "part_category_id_list": part_category_id_list,
                "type": category_type,
                "sub_type": sub_type,
                "language_code": language_code,
                "names": names
            }
        }

        resp = self.init.request("post", "/parts/categories", json=data)
        return resp
