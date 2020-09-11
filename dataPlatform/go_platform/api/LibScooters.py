import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibScooters(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def scooters_get(self, scooter_ids, fields_type, account=None):
        """ Get scooter info

        Examples:
        | ${resp} = | Scooters Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "scooter_ids": [
                    scooter_ids
                ],
                "fields_type": fields_type
            }
        }
        resp = self.init.request('post', "/scooters", json=data)
        return resp

    def scooters_post(self, company_code, country_code, scooter_vin, scooter_guid,
                      matnr, atmel_key, state, es_state, ecu_status, status,
                      deletion_flag=None, motor_num=None, atmel_sn=None,
                      battery_count=None, manufacture_date=None, color_code=None,
                      ecu_mac=None, ecu_sn=None, keyfobs_id=None, mac=None,
                      sn=None, account=None):
        """ Create scooter

        Examples:
        | ${resp} = | Scooters Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "deletion_flag": deletion_flag,
                    "company_code": company_code,
                    "country_code": country_code,
                    "scooter_vin": scooter_vin,
                    "scooter_guid": scooter_guid,
                    "matnr": matnr,
                    "motor_num": motor_num,
                    "atmel_key": atmel_key,
                    "atmel_sn": atmel_sn,
                    "battery_count": battery_count,
                    "manufacture_date": manufacture_date,
                    "color_code": color_code,
                    "state": state,
                    "es_state": es_state,
                    "ecu_mac": ecu_mac,
                    "ecu_sn": ecu_sn,
                    "ecu_status": ecu_status,
                    "keyfobs": [
                        {
                            "id": keyfobs_id,
                            "mac": mac,
                            "sn": sn,
                            "status": status
                        }
                    ]
                }
            ]
        }
        resp = self.init.request('post', "/scooters", json=data)
        return resp

    def scooters_update(self, scooter_id, state=None, plate=None, payment_state=None, account=None):
        """Update specific scooter's data

        Examples:
        | ${resp} = | Scooters Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "scooter_id": scooter_id,
                    "state": state,
                    "plate": plate,
                    "payment_state": payment_state
                }
            ]
        }
        resp = self.init.request('post', "/scooters", json=data)
        return resp