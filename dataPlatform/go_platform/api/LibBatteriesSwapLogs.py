import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibBatteriesSwapLogs(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def batteries_swap_logs_post_gds(self, swap_id, scooter_guid, battery_guid_1, battery_guid_2, account=None):
        """ Add swap-log with gds source

        Examples:
        | ${resp} = | Batteries Swap Logs Post Gds | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "type": 2,
            "add_data": [
                {
                    "source": "gds",
                    "swap_logs": [
                        {
                            "swap_id": swap_id,
                            "scooter_guid": scooter_guid,
                            "other_id": "53435754-3032-3230-0000-000000000000",
                            "swap_out": [
                                {
                                    "battery_guid": battery_guid_1,
                                    "capacity": 15,
                                    "health": 1,
                                    "recycle_count": 400,
                                    "consumption": 30,
                                    "slot_id": 1,
                                    "slot_serial_id": battery_guid_1,
                                    "temp_cell": 31,
                                    "temp_mos": 32,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                },
                                {
                                    "battery_guid": battery_guid_2,
                                    "capacity": 16,
                                    "health": 1,
                                    "recycle_count": 400,
                                    "consumption": 32,
                                    "slot_id": 1,
                                    "slot_serial_id": battery_guid_2,
                                    "temp_cell": 33,
                                    "temp_mos": 34,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                }
                            ],
                            "exchange_time": "2019-05-22T14:01:42.960000Z",
                            "extra_exchange": 0,
                            "rating": 9000,
                            "rating_rule_id": "5EDBF33A-B7F7-64AB-8FB8-489D66395B7F",
                            "action": 1,
                            "rating_rule_type": 1,
                            "eject_new_candidate": False,
                            "base_price": 2.0,
                            "pps_price": 124.0,
                            "eula_state": 1,
                            "real_time_scooter_info": 1,
                            "eject_fail": 0
                        }
                    ]
                }
            ]
        }
        resp = self.init.request('post', "/batteries/swap-logs", json=data)
        return resp

    def batteries_swap_logs_post_gds_one(self, swap_id, scooter_guid, battery_guid_1, account=None):
        """ Add swap-log with gds source

        Examples:
        | ${resp} = | Batteries Swap Logs Post Gds One| data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "type": 2,
            "add_data": [
                {
                    "source": "gds",
                    "swap_logs": [
                        {
                            "swap_id": swap_id,
                            "scooter_guid": scooter_guid,
                            "other_id": "53435754-3032-3230-0000-000000000000",
                            "swap_out": [
                                {
                                    "battery_guid": battery_guid_1,
                                    "capacity": 15,
                                    "health": 1,
                                    "recycle_count": 400,
                                    "consumption": 30,
                                    "slot_id": 1,
                                    "slot_serial_id": battery_guid_1,
                                    "temp_cell": 31,
                                    "temp_mos": 32,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                }
                            ],
                            "exchange_time": "2019-05-22T14:01:42.960000Z",
                            "extra_exchange": 0,
                            "rating": 9000,
                            "rating_rule_id": "5EDBF33A-B7F7-64AB-8FB8-489D66395B7F",
                            "action": 1,
                            "rating_rule_type": 1,
                            "eject_new_candidate": False,
                            "base_price": 2.0,
                            "pps_price": 124.0,
                            "eula_state": 1,
                            "real_time_scooter_info": 1,
                            "eject_fail": 0
                        }
                    ]
                }
            ]
        }
        resp = self.init.request('post', "/batteries/swap-logs", json=data)
        return resp    

    def batteries_swap_logs_post_vm(self, vm_id, swap_id, scooter_guid,
                                    battery_guid_1, battery_guid_2,
                                    battery_guid_3, battery_guid_4,
                                    riding_distance, total_distance,
                                    exchange_time, consumption=30,
                                    total_consumption=60, outlier_flag=0,
                                    account=None):
        """ Add swap-log with vm source

        Examples:
        | ${resp} = | Batteries Swap Logs Post Vm | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "type": 2,
            "add_data": [
                {
                    "source": "vm",
                    "vm_guid": vm_id,
                    "swap_logs": [
                        {
                            "swap_id": swap_id,
                            "scooter_guid": scooter_guid,
                            "swap_in": [
                                {
                                    "battery_guid": battery_guid_1,
                                    "capacity": 10,
                                    "health": 1,
                                    "recycle_count": 400,
                                    "consumption": consumption,
                                    "slot_id": 1,
                                    "slot_serial_id": battery_guid_1,
                                    "temp_cell": 31,
                                    "temp_mos": 32,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                },
                                {
                                    "battery_guid": battery_guid_2,
                                    "capacity": 10,
                                    "health": 1,
                                    "recycle_count": 400,
                                    "consumption": consumption,
                                    "slot_id": 1,
                                    "slot_serial_id": battery_guid_2,
                                    "temp_cell": 33,
                                    "temp_mos": 34,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                }
                            ],
                            "swap_out": [
                                {
                                    "battery_guid": battery_guid_3,
                                    "capacity": 99,
                                    "health": 1,
                                    "recycle_count": 600,
                                    "consumption": 30,
                                    "slot_id": 22,
                                    "slot_serial_id": battery_guid_3,
                                    "temp_cell": 35,
                                    "temp_mos": 36,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                },
                                {
                                    "battery_guid": battery_guid_4,
                                    "capacity": 98,
                                    "health": 1,
                                    "recycle_count": 600,
                                    "consumption": 30,
                                    "slot_id": 22,
                                    "slot_serial_id": battery_guid_4,
                                    "temp_cell": 37,
                                    "temp_mos": 38,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                }
                            ],
                            "exchange_time": exchange_time,
                            "extra_exchange": 0,
                            "scooter_data": {
                                "settings": "[{\"key\": \"0\",\"val\": \"0\",\"time\": 1435420079}]",
                                "riding_history": "0x000000006F02000045010000F2000000D4000000FA000000CE0000006600000003000000000000000000000000000000000000006303000008010000D50000003A0000001300000004000000000000000000000002000000090000003D00000010010000C20000008506000000000000AB07000000000000000000000D00000000000000000000004605B13BFE5AE43CFE5A0A0000002F41FE5A5043FE5A220000008044FE5ADE45FE5A060000008E56FE5AD159FE5A2F000000960100001414D8400C000000",
                                "fault": "<scooter.errors> <error key=\"64\" val=\"73\" time=\"2016-09-04T19:03:25.0000000Z\" />  </scooter.errors>",
                                "fault_snap_time": exchange_time,
                                "riding_distance": riding_distance,
                                "total_distance": total_distance,
                                "swap_span": 70247,
                                "version": "1.0.0.2",
                                "total_consumption": total_consumption,
                            },
                            "rating": 9000,
                            "rating_rule_id": "5EDBF33A-B7F7-64AB-8FB8-489D66395B7F",
                            "action": 1,
                            "rating_rule_type": 1,
                            "eject_new_candidate": False,
                            "base_price": 2.0,
                            "pps_price": 124.0,
                            "eula_state": 1,
                            "real_time_scooter_info": 1,
                            "eject_fail": 0,
                            "outlier_flag": outlier_flag
                        }
                    ]
                }
            ]
        }
        resp = self.init.request('post', "/batteries/swap-logs", json=data)
        return resp

    def batteries_swap_logs_post_obc(self, vm_id, swap_id, scooter_guid,
                                     battery_guid_1, battery_guid_2,
                                     battery_guid_3, battery_guid_4,
                                     riding_distance, total_distance,
                                     exchange_time, consumption=30,
                                     total_consumption=60, outlier_flag=0,
                                     account=None):
        """ Add swap-log with obc source

        Examples:
        | ${resp} = | Batteries Swap Logs Post OBC | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "type": 2,
            "add_data": [
                {
                    "source": "obc",
                    "swap_logs": [
                        {
                            "swap_id": swap_id,
                            "scooter_guid": scooter_guid,
                            "other_id": "FFFFFFFF-FFFF-ABEE-0000-000000000000",
                            "swap_in": [
                                {
                                    "battery_guid": battery_guid_1,
                                    "capacity": 10,
                                    "health": 1,
                                    "recycle_count": 400,
                                    "consumption": consumption,
                                    "slot_id": 1,
                                    "slot_serial_id": battery_guid_1,
                                    "temp_cell": 31,
                                    "temp_mos": 32,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                },
                                {
                                    "battery_guid": battery_guid_2,
                                    "capacity": 10,
                                    "health": 1,
                                    "recycle_count": 400,
                                    "consumption": consumption,
                                    "slot_id": 1,
                                    "slot_serial_id": battery_guid_2,
                                    "temp_cell": 33,
                                    "temp_mos": 34,
                                    "charging_rate": 0,
                                    "locked": True,
                                    "payload": "0x6464011E0000001E00000044C34610451046104410481046104810471043104310451043104810431004052310000000004B0B4B0B285A14004AEA110000000000000000000000000064131F00DE6F0200D7650200330600004B0B0000DE0A000000FFFF0000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF00000000008000800000000000000000008000000000000000000000FF7F00000000000000000000000000000000000000000000000000000000000000000000FFFF00000000000000000000000000000000000000000000010414",
                                    "cell_type": 1,
                                    "case_type": 1,
                                    "ups": 0,
                                    "max_charging_rate": 0,
                                    "chargeable": True,
                                    "dischargeable": False
                                }
                            ],
                            "exchange_time": exchange_time,
                            "extra_exchange": 0,
                            "scooter_data": {
                                "settings": "[{\"key\": \"0\",\"val\": \"0\",\"time\": 1435420079}]",
                                "riding_history": "0x000000006F02000045010000F2000000D4000000FA000000CE0000006600000003000000000000000000000000000000000000006303000008010000D50000003A0000001300000004000000000000000000000002000000090000003D00000010010000C20000008506000000000000AB07000000000000000000000D00000000000000000000004605B13BFE5AE43CFE5A0A0000002F41FE5A5043FE5A220000008044FE5ADE45FE5A060000008E56FE5AD159FE5A2F000000960100001414D8400C000000",
                                "fault": "<scooter.errors> <error key=\"64\" val=\"73\" time=\"2016-09-04T19:03:25.0000000Z\" />  </scooter.errors>",
                                "fault_snap_time": exchange_time,
                                "riding_distance": riding_distance,
                                "total_distance": total_distance,
                                "swap_span": 70247,
                                "version": "1.0.0.2",
                                "total_consumption": total_consumption,
                            },
                            "rating": 9000,
                            "rating_rule_id": "5EDBF33A-B7F7-64AB-8FB8-489D66395B7F",
                            "action": 1,
                            "rating_rule_type": 1,
                            "eject_new_candidate": False,
                            "base_price": 2.0,
                            "pps_price": 124.0,
                            "eula_state": 1,
                            "real_time_scooter_info": 1,
                            "eject_fail": 0
                        }
                    ]
                }
            ]
        }
        resp = self.init.request('post', "/batteries/swap-logs", json=data)
        return resp
