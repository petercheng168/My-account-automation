import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_

class LibScootersOwners(object):
    def __init__(self):
        self.init = _init_()

    def scooters_owners_get(self, request_data_type=None, owner_ids= None, scooter_ids=None, scooter_plates=None, 
                            scooter_vins=None, scooter_guids=None, scooter_vin_for_transfer=None, 
                            scooter_plate_for_transfer=None, profile_id_for_transfer=None, account=None, offset=None, limit=None):
        """ get scooter's owner

        Examples:
        | ${resp} = | Scooters Owners Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data":  {
                    "request_data_type": request_data_type,
                    "owner_ids": owner_ids,
                    "scooter_ids": scooter_ids,
                    "scooter_plates": scooter_plates,
                    "scooter_vins": scooter_vins,
                    "scooter_guids": scooter_guids,
                    "scooter_vin_for_transfer": scooter_vin_for_transfer,
                    "scooter_plate_for_transfer": scooter_plate_for_transfer,
                    "profile_id_for_transfer": profile_id_for_transfer,
                    "pagination_criteria": {
                        "offset": offset,
                        "limit": limit
                }
            }
        }

        resp = self.init.request('post', "/scooters/owners", json=data)
        return resp