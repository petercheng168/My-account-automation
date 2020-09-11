import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibScootersModels(object):
    def __init__(self):
        self.init = _init_()


    def scooters_models_add(self, serial_no=None, scooter_model_id=None, scooter_model_guid=None, battery_count=None,
                            retailer_flag=None, marketing_name=None, brand_company_id=None, brand_company_code=None, status=None, account=None,
                            category=None, key=None, value=None):

        """ Create scooter model

        Examples:
        | ${resp} = | Scooters Models Add | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "serial_no": serial_no,
                    "scooter_model_id": scooter_model_id,
                    "scooter_model_guid": scooter_model_guid,
                    "battery_count": battery_count,
                    "brand_company_id": brand_company_id,
                    "retailer_flag": retailer_flag,
                    "marketing_name": marketing_name,
                    "brand_company_id": brand_company_id,
                    "brand_company_code": brand_company_code,
                    "account": account,
                    "status": status,
                    "params": [
                        {
                            "category": category,
                            "key": key,
                            "value": value
                        }
                    ]
                }
            ]
        }

        resp = self.init.request('post', "/scooter-models", json=data)
        return resp

    def scooters_models_add_with_params(self, serial_no=None, scooter_model_id=None, scooter_model_guid=None, battery_count=None,
                            retailer_flag=None, marketing_name=None, brand_company_id=None, brand_company_code=None, status=None, account=None,
                            params=None):

        """ Create scooter model

        Examples:
        | ${resp} = | Scooters Models Add With Params | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "serial_no": serial_no,
                    "scooter_model_id": scooter_model_id,
                    "scooter_model_guid": scooter_model_guid,
                    "battery_count": battery_count,
                    "brand_company_id": brand_company_id,
                    "retailer_flag": retailer_flag,
                    "marketing_name": marketing_name,
                    "brand_company_id": brand_company_id,
                    "brand_company_code": brand_company_code,
                    "account": account,
                    "status": status,
                    "params": params
                }
            ]
        }

        resp = self.init.request('post', "/scooter-models", json=data)
        return resp

    def scooters_models_get(self, scooter_model_id=None, scooter_model_guid=None, type_code=None,
                            model_code=None, status=None, model_code_list=None, account=None, offset=None, limit=None):
        """ Get scooter model

        Examples:
        | ${resp} = | Scooters Models Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data":  {
                    "scooter_model_id": scooter_model_id,
                    "scooter_model_guid": scooter_model_guid,
                    "type_code": type_code,
                    "model_code": model_code,
                    "status": status,
                    "model_code_list" : model_code_list,
                    "pagination_criteria": {
                        "offset": offset,
                        "limit": limit
                }
            }
        }

        resp = self.init.request('post', "/scooter-models", json=data)
        return resp


    def scooters_models_update(self, serial_no=None, scooter_model_id=None, scooter_model_guid=None,
                            retailer_flag=None, marketing_name=None, brand_company_id=None, brand_company_code=None, account=None,
                            category=None, key=None, value=None):

        """ Update scooter model

        Examples:
        | ${resp} = | Scooters Models Update | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "serial_no": serial_no,
                    "scooter_model_id": scooter_model_id,
                    "scooter_model_guid": scooter_model_guid,
                    "brand_company_id": brand_company_id,
                    "retailer_flag": retailer_flag,
                    "marketing_name": marketing_name,
                    "brand_company_id": brand_company_id,
                    "brand_company_code": brand_company_code,
                    "account": account,
                    "params": [
                        {
                            "category": category,
                            "key": key,
                            "value": value
                        }
                    ]
                }
            ]
        }

        resp = self.init.request('post', "/scooter-models", json=data)
        return resp

    def scooters_models_update_with_params(self, serial_no=None, scooter_model_id=None, scooter_model_guid=None,
                            retailer_flag=None, marketing_name=None, brand_company_id=None, brand_company_code=None, account=None,
                            params=None):

        """ Update scooter model

        Examples:
        | ${resp} = | Scooters Models Update | data |
        """

        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "serial_no": serial_no,
                    "scooter_model_id": scooter_model_id,
                    "scooter_model_guid": scooter_model_guid,
                    "brand_company_id": brand_company_id,
                    "retailer_flag": retailer_flag,
                    "marketing_name": marketing_name,
                    "brand_company_id": brand_company_id,
                    "brand_company_code": brand_company_code,
                    "account": account,
                    "params": params
                }
            ]
        }

        resp = self.init.request('post', "/scooter-models", json=data)
        return resp