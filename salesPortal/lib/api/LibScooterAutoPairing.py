#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibScooterAutoPairing(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def get_scooter_pair_result_detail_post(self, order_no, start_date, end_date,
                                            company_id=None, department_id=None,
                                            allocation_failure_reason=0,
                                            offset=0, limit=200,
                                            token=None, hash_id=None):
        """ Get assign scooter order scooter pairing result from group admin
        Args:
            order_no   (str): dms_order_no
            start_date (str): Example Format
            - 2020-03-16T07:57:02.197Z
            - 2020-03-18
            end_date   (str): Same format with start_date, to describe the interval of pairing result

        Return:
            resp: Return json object

        Examples:
            | Get Scooter Pair Result Detail Post | PAYLOAD |
        """
        self.init.auth(token, hash_id)
        data = {
            "OrderNo": order_no,
            "CompanyId": company_id,
            "DepartmentId": department_id,
            "IsDraft": True,
            "AllocationFailureReason": allocation_failure_reason,
            "StartDate": start_date,
            "EndDate": end_date,
            "PaginationCriteria": {
                "Offset": offset,
                "Limit": limit
            }
        }
        resp = self.init.request('post', '/scooter-auto-pairing/get-scooter-pair-result-detail', json=data)
        return resp

    def get_scooter_pair_result_master_post(self, start_date, end_date,
                                            company_id=None, pairing_id=None,
                                            offset=0, limit=200,
                                            token=None, hash_id=None):
        """ Get whole scooter pairing result from group admin
        Args:
            start_date (str): Example Format
            - 2020-03-16T07:57:02.197Z
            - 2020-03-18
            end_date   (str): Same format with start_date, to describe the interval of pairing result

        Return:
            resp: Return json object

        Examples:
            | Get Scooter Pair Result Master Post | PAYLOAD |
        """
        self.init.auth(token, hash_id)
        data = {
            "StartDate": start_date,
            "EndDate": end_date,
            "CompanyId": company_id,
            "Id": pairing_id,
            "IsDraft": True,
            "PaginationCriteria": {
                "Offset": offset,
                "Limit": limit
            }
        }
        resp = self.init.request('post', '/scooter-auto-pairing/get-scooter-pair-result-master', json=data)
        return resp
