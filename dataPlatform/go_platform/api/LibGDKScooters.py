import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibGDKScooters(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def gdk_scooters_update(self, scooter_id=None, scooter_vin=None,
                            scooter_guid=None, ecu_code=None, vin=None,
                            material_num=None, motor_num=None,
                            update_plate=None, update_plate_date=None,
                            color_code=None, manufacture_time=None, tpms=None,
                            assist_light=None, onboard_charger=None,
                            model_code=None, assembled_date=None, account=None):
        """Update the gdk scooter's infromation.

        Examples:
        | ${resp} = | GDK Scooters Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "scooter_id": scooter_id,
                    "scooter_vin": scooter_vin,
                    "scooter_guid": scooter_guid,
                    "ecu_code": ecu_code,
                    "vin": vin,
                    "material_num": material_num,
                    "motor_num": motor_num,
                    "update_plate": update_plate,
                    "update_plate_date": update_plate_date,
                    "color_code": color_code,
                    "manufacture_time": manufacture_time,
                    "tpms": tpms,
                    "assist_light": assist_light,
                    "onboard_charger": onboard_charger,
                    "model_code": model_code,
                    "assembled_date": assembled_date
                }
            ]
        }
        resp = self.init.request('post', "/gdk/scooters", json=data)
        return resp

    def gdk_scooters_update_plate(self, scooter_vin=None, update_plate=None,
                                  update_plate_date=None, account=None):
        """Update the gdk scooter's plate.

        Examples:
        | ${resp} = | GDK Scooters Update Plate | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "scooter_vin": scooter_vin,
                    "update_plate": update_plate,
                    "update_plate_date": update_plate_date
                }
            ]
        }
        resp = self.init.request('post', "/gdk/scooters", json=data)
        return resp
