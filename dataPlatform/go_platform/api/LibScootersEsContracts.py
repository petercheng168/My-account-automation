import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibScootersEsContracts(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def scooters_es_contracts_get(self, scooter_ids=[], scooter_plates=[], scooter_vins=[],
                                scooter_guids=[], scooter_plate=None, scooter_vin=None, account=None):
        """ Get scooters infos
        Examples:
        | ${resp} = | Scooters Es Contracts Get | data |
        """
        self.init.authHeader(account)
        scooter_ids = scooter_ids.split(',') if scooter_ids else scooter_ids
        scooter_plates = scooter_plates.split(',') if scooter_plates else scooter_plates
        scooter_vins = scooter_vins.split(',') if scooter_vins else scooter_vins
        scooter_guids = scooter_guids.split(',') if scooter_guids else scooter_guids
        data = {
            "op_code": "get",
            "get_data": {
                "scooter_ids":
                    scooter_ids,
                "scooter_plates":
                    scooter_plates,
                "scooter_vins":
                    scooter_vins,
                "scooter_guids":
                    scooter_guids,
                "scooter_plate": scooter_plate,
                "scooter_vin": scooter_vin
            }
        }
        print(data)
        resp = self.init.request('post', "/scooters/es-contracts", json=data)
        return resp
