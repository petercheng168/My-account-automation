#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibScooterList(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def scooter_list_get(self, token=None, hash_id=None):
        """ Get scooter list with detail information
        Return:
            resp: Return json object

        Examples:
            | Scooter List Get |
        """
        self.init.auth(token, hash_id)
        
        resp = self.init.request('get', '/scooter/list')
        return resp
