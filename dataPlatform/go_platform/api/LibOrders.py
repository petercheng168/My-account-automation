import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibOrders(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def orders_get(self, order_type, offset=0, limit=10, account=None,
                   dms_order_no=None, order_id=None, create_time_from=None,
                   create_time_to=None, promise_delivery_date_from=None,
                   promise_delivery_date_to=None, payment_complete=None,
                   status=None, sales_channel=None):
        """ Get orders info
        Examples:
        | ${resp} = | Orders Get | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "order_id": order_id,
                "dms_order_no": dms_order_no,
                "type": order_type,
                "create_time_from": create_time_from,
                "create_time_to": create_time_to,
                "promise_delivery_date_from": promise_delivery_date_from,
                "promise_delivery_date_to": promise_delivery_date_to,
                "payment_complete": payment_complete,
                "status": status,
                "sales_channel": sales_channel,
                "pagination_criteria": {
                    "offset": offset,
                    "limit": limit
                }
            }
        }
        resp = self.init.request('post', "/orders", json=data)
        return resp

    def orders_post(self, order_type, order_number, order_state, user_id, flow_status, loan_app_date=None,
                    loan_approval_date=None, account=None):
        """ Create orders
        Examples:
        | ${resp} = | Orders Post | data |
        """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": {
                "r02": "ES600000",
                "r01": "1500",
                "r04": order_type,
                "r05": order_number,
                "r06": 1463529600,
                "r07": "5%",
                "r10": "A",
                "r08": 129100,
                "r09": 6148,
                "r11": "Gogoro 門市。付款方式：現金 $129100。車用防水攜行包寄送地址：蘇小民#0963001001#100臺北市中正區景星里23鄰館前東路26號。是否有騎過Gogoro:Y。",
                "r16": order_state,
                "r03": "",
                "r51": 0,
                "r52": 0,
                "r53": 0,
                "r46": "144",
                "r40": 0,
                "r43": "red",
                "r27": "10010000",
                "r41": 1463529600,
                "r29": "A",
                "r30": "",
                "r25": {
                    "c03": "蘇小民eeeee",
                    "c07": "jefflin.su@gogoro.com",
                    "c06": "0963001001",
                    "c08": "A123456789",
                    "c05": "M",
                    "c20": "1985-07-22",
                    "c16": "臺北市",
                    "c17": "中正區",
                    "c15": "100",
                    "c18": "三愛里景星里23鄰館前東路26號",
                    "c23": "臺北市",
                    "c24": "中正區",
                    "c22": "100",
                    "c25": "三愛里景星里23鄰館前東路26號",
                    "c26": "144",
                    "c27": user_id
                },
                "r18": {
                    "c27": user_id
                },
                "r28": {
                    "c27": user_id
                },
                "r23": [
                    {
                        "y01": "D",
                        "y02": "ES313002",
                        "y09": "123",
                        "y03": "蘇小民zzzz",
                        "y04": "0963001001",
                        "y06": "臺北市",
                        "y07": "中正區",
                        "y05": "100",
                        "y08": "景星里23鄰館前東路26號"
                    }],
                "r24": [
                    {
                        "d02": "GSBK2-000-DC",
                        "d03": "Gogoro S2 Adventure Tour Edition",
                        "d04": 1,
                        "d05": 128800,
                        "d06": 128800,
                        "d07": 6133,
                        "d08": 128800,
                        "d09": "100%",
                        "d10": 0,
                        "d11": None,
                        "d12": None
                    }
                ],
                "r31": {
                    "n01": "80607612",
                    "n02": 78800.05,
                    "n03": 58000.32,
                    "n04": "WOR",
                    "n05": 6,
                    "n06": "test_id",
                    "n07": "2.5",
                    "n08": 13000,
                    "n09": loan_app_date,
                    "n10": loan_approval_date
                },
                "r47": "TW",
                "flow_status": flow_status
            }
        }
        resp = self.init.request('post', "/orders", json=data)
        return resp

    def orders_update(self, order_id, order_type, order_number, order_state, user_id,
                      flow_status, scooter_allocation_flag, plate=None, plate_date=None,
                      delivery_place=None, delivery_time=None, sales_portal_flag=None,
                      loan_app_date=None, loan_approval_date=None, account=None):
        """ Update orders
        Examples:
        | ${resp} = | Orders Update | data |
        """
        if sales_portal_flag == None:
            self.init.authHeader(account)
            data = {
                "op_code": "update",
                "update_data": {
                    "order_id": order_id,
                    "r02": "ES600000",
                    "r01": "1500",
                    "r04": order_type,
                    "r05": order_number,
                    "r06": 1463529600,
                    "r07": "5%",
                    "r10": "A",
                    "r08": 129100,
                    "r09": 6148,
                    "r11": "Gogoro 門市。付款方式：現金 $129100。車用防水攜行包寄送地址：蘇小民#0963001001#100臺北市中正區景星里23鄰館前東路26號。是否有騎過Gogoro:Y。",
                    "r16": order_state,
                    "r03": "",
                    "r51": 0,
                    "r52": 0,
                    "r53": 0,
                    "r46": "144",
                    "r40": 0,
                    "r43": "red",
                    "r27": "10010000",
                    "r41": 1463529600,
                    "r29": "A",
                    "r30": "",
                    "r18": {
                        "c27": user_id
                    },
                    "r28": {
                        "c27": user_id
                    },
                    "r23": [
                        {
                            "y01": "D",
                            "y02": "ES313002",
                            "y09": "123",
                            "y03": "蘇小民zzzz",
                            "y04": "0963001001",
                            "y06": "臺北市",
                            "y07": "中正區",
                            "y05": "100",
                            "y08": "景星里23鄰館前東路26號"
                        }],
                    "r24": [
                        {
                            "d02": "GSBK2-000-DC",
                            "d03": "Gogoro S2 Adventure Tour Edition",
                            "d04": 1,
                            "d05": 128800,
                            "d06": 128800,
                            "d07": 6133,
                            "d08": 128800,
                            "d09": "100%",
                            "d10": 0,
                            "d11": None,
                            "d12": None
                        }
                    ],
                    "r31": {
                        "n01": "80607612",
                        "n02": 78800.05,
                        "n03": 58000.32,
                        "n04": "WOR",
                        "n05": 6,
                        "n06": "test_id",
                        "n07": "2.5",
                        "n08": 13000,
                        "n09": loan_app_date,
                        "n10": loan_approval_date
                    },
                    "r39": 100,
                    "r47": "TW",
                    "r42": plate,
                    "r45": plate_date,
                    "flow_status": flow_status,
                    "r50": delivery_place,
                    "scooter_allocation_flag": scooter_allocation_flag
                }
            }
            resp = self.init.request('post', "/orders", json=data)
            return resp
        else:
            self.init.authHeader(account)
            data = {
                "op_code": "update",
                "update_data": {
                    "order_id": order_id,
                    "r04": order_type,
                    "r08": 109100.0,
                    "r09": 5195.0,
                    "r39": 109100.0,
                    "r40": 0.0,
                    "r43": "CF",
                    "r46": "GSBH2-000-CF",
                    "r51": 0.0,
                    "r52": 108800.0,
                    "r53": 300.0,
                    "r16": order_state,
                    "flow_status": flow_status,
                    "r74": delivery_time,
                    "scooter_allocation_flag": scooter_allocation_flag
                }
            }
            resp = self.init.request('post', "/orders", json=data)
            return resp
