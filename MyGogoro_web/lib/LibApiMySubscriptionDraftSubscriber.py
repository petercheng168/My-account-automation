#!/usr/bin/env python
# -*- coding: utf-8 -*-
from LibBase import LibBase


class LibApiMySubscriptionDraftSubscriber(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def api_my_subscription_draft_subscriber_put(self, gender, firstName, lastName, birthday, idNumber, mobile,
                                                 invoice_city, invoice_district, invoice_zipCode, invoice_address,
                                                 contact_city, contact_district, contact_zipCode, contact_address, 
                                                 gogoro_sess=None, csrf_token=None):
        """ Subscription draft with subscriber """
        self.init.authHeader(gogoro_sess, csrf_token)
        data = {
            "gender": gender,
            "firstName": firstName,
            "lastName": lastName,
            "birthday": birthday,
            "idNumber": idNumber,
            "mobile": mobile,
            "invoiceAddress": {
                "city": invoice_city,
                "district": invoice_district,
                "zipCode": invoice_zipCode,
                "address": invoice_address
            },
            "contactAddress": {
                "city": contact_city,
                "district": contact_district,
                "zipCode": contact_zipCode,
                "address": contact_address
            }
        }
        resp = self.init.request('put', "/api/my/subscription/draft/subscriber", json=data)
        return resp
