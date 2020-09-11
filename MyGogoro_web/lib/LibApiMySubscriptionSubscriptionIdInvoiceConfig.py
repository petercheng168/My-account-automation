#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionSubscriptionIdInvoiceConfig(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_subscriptionId_invoice_config_patch(self, subscription_Id, invoice_format, donateTo=None, gogoro_sess=None, csrf_token=None):
        """ Update subscription invoice config """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "format": invoice_format,
            "eCarrierConfig": {
                "donateTo": donateTo
            }
        }
        if donateTo is None:
            data = {
                "format": invoice_format
            }
        resp = self.init.request(
            'patch', "/api/my/subscription/{}/invoice-config".format(subscription_Id), json=data)
        return resp
