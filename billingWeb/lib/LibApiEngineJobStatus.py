#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiEngineJobStatus(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_engine_job_status_get(self, billing_cookie=None):
        """ 
        Get billing engine job status
        """
        self.init.authHeader(billing_cookie)
        resp = self.init.request('get', "/api/engine/job-status")
        return resp
