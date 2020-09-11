#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionDraftInvoiceConfig(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_draft_invoice_config_put(self, invoice_format, title, vatNumber, includeVat, gogoro_sess=None, csrf_token=None):
        """ Subscription draft with invoice config """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "format": invoice_format,
            "title": title,
            "vatNumber": vatNumber,
            "includeVat": includeVat
        }
        resp = self.init.request('put', "/api/my/subscription/draft/invoice-config", json=data)
        return resp
