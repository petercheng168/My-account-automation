import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibScootersInfos(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def scooters_infos_update(self, order_number, scooter_vin, user_id,
                              owner_id, user_guid, state, birthday=None,
                              email=None, delivery_date=None, plate=None,
                              plate_date=None, turn_light=None,
                              brake_light=None, phone_unlock=None,
                              handle_lock=None, tpms=None, normal_charger=None,
                              quick_charger=None, battery_sprint=None,
                              auto_dfu=None, sport_mode=None,
                              warranty_start=None, warranty_end=None,
                              account=None):
        """ Update scooters infos
        Examples:
        | ${resp} = | Scooters Infos Update | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "order_no": order_number,
                    "vin": scooter_vin,
                    "country_code": "TW",
                    "driver_id": user_id,
                    "owner_id": owner_id,
                    "user_guid": user_guid,
                    "birthday": birthday,
                    "email": email,
                    "state": state,
                    "delivery_date": delivery_date,
                    "plate": plate,
                    "plate_date": plate_date,
                    "turn_light": turn_light,
                    "brake_light": brake_light,
                    "phone_unlock": phone_unlock,
                    "handle_lock": handle_lock,
                    "tpms": tpms,
                    "normal_charger": normal_charger,
                    "quick_charger": quick_charger,
                    "battery_sprint": battery_sprint,
                    "auto_dfu": auto_dfu,
                    "sport_mode": sport_mode,
                    "cancel_reason": "TEST",
                    "warranty_start": warranty_start,
                    "warranty_end": warranty_end
                }
            ]
        }
        resp = self.init.request('post', "/scooters/infos", json=data)
        return resp
