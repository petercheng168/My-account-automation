#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.libraries.BuiltIn import BuiltIn
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase
from salesPortal.lib.ProductList import *


class LibShoppingCartModifyOrder(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def _get_loan_payment(self, payment_type='2'):
        """ Get scooter payment detail information payload
        Args:
            payment_type (str): 2 is cash, 3 is loan

        Returns:
            dict: The return value
        """
        loan_payments = {
            "2":
                {},
            "3":
                loan
        }
        return loan_payments[payment_type]

    def _get_scooter_information_payload(self, scooter_model='Gogoro VIVA'):
        """ Get scooter detail information payload
        Args:
            scooter_model (str): default with Gogoro VIVA

        Returns:
            dict: The return value
        """
        products = {
            "Accessories":
            [
                accessory_keychain,
                accessory_mat,
                agency_serivce_fee,
                gogoros2caferacer
            ],
            "Gogoro VIVA":
            [
                agency_serivce_fee,
                gogoroviva
            ],
            "Gogoro S2 Cafe Racer":
            [
                agency_serivce_fee,
                gogoros2caferacer
            ],
            "Legal Entity":
            [
                gogoros2caferacer_discount
            ],
            "Legal_Entity+Gogoro 2 Delight+Anti slip mat":
            [
                accessory_mat_discount,
                gogoro2delight_discount
            ],
            "Legal_Entity+Gogoro 2 Delight+Light sensor":
            [
                light_sensor_discount,
                gogoro2delight_discount
            ],
            "Legal_Entity+Gogoro 2 Rumbler+Light sensor":
            [
                light_sensor_discount,
                gogoro2rumbler_discount
            ],
            "Legal_Entity+GogoroS2CaféRacer+Anti slip mat":
            [
                accessory_mat_discount,
                gogoros2caferacer_discount
            ]
        }
        return products[scooter_model]

    def shopping_cart_modify_order_post(self, order_no, order_type, sales_channel_no, owner_email, owner_name,
                                        owner_gender, owner_profile_id, owner_mobile, owner_birthday, owner_city,
                                        owner_district, owner_zipcode, owner_address, licensing_location, licensing_location_id,
                                        license_type, payment_type, is_payment_change, document_fee_payer, scooter_model,
                                        agency_fees=-1, is_receive_award=-1, token=None, hash_id=None):
        """ Update scooter order information in shopping cart
        Args:
        Returns:
            resp: Return json object
        Examples:
            | Shopping Cart Modify Order Post | PAYLOAD |
        """
        self.init.auth(token, hash_id)

        products = [
            documentation_fee
        ]
        products += self._get_scooter_information_payload(scooter_model)
        payments = self._get_loan_payment(payment_type)

        data = {
            "Bag": 1,
            "UserId": None,
            "OrderNo": order_no,
            "OrderType": order_type,
            "SalesChannelNo": sales_channel_no,
            "SalesChannelName": None,
            "SalesStoreNo": None,
            "SalesStoreName": None,
            "DiscountPlanId": None,
            "EmployeeNo": None,
            "CheckEmployeeNo": None,
            "Recommended": None,
            "Remark": None,
            "Invoice": {
                "Numbers": None,
                "GUINumbers": None,
                "Donation": None,
                "DonationNumbers": None,
                "Date": None
            },
            "Discount": [],
            "ProjectActivity": [
                {
                    "ProjectCode": "EVT217",
                    "ProjectName": "購買 Gogoro 全車系贈送 Gogoro 極輕都會風雨衣",
                    "ProjectDescription": "購買 Gogoro 全車系贈送 Gogoro 極輕都會風雨衣",
                    "Remark": None,
                    "Product": [],
                    "Delivery": {}
                }
            ],
            "Buyer": {
                "Email": None,
                "Name": None,
                "Gender": -1,
                "Mobile": None,
                "City": None,
                "CityId": None,
                "District": None,
                "DistrictId": None,
                "ZipCode": None,
                "Address": None
            },
            "Owner": {
                "Email": owner_email,
                "Name": owner_name,
                "Gender": owner_gender,
                "IDCard": owner_profile_id,
                "Mobile": owner_mobile,
                "Birthday": owner_birthday,
                "City": owner_city,
                "CityId": None,
                "District": owner_district,
                "DistrictId": None,
                "ZipCode": owner_zipcode,
                "Address": owner_address,
                "CivilServants": 0,
                "PurchaseMethod": 0
            },
            "Driver": {
                "Name": owner_name,
                "Email": owner_email
            },
            "Deliveries": {},
            "DeliveryConditions": {
                "Type": -1,
                "StoreId": None
            },
            "Scooter": {
                "PDIStoreId": None,
                "PairingAccount": None,
                "PairingUserId": None,
                "SingingDay": None,
                "SubsidyType": -1,
                "SubsidyApplication": -1,
                "SubsidyCounty": None,
                "BeDeprecatedSamePerson": -1,
                "Subsidy": {
                    "TesSubsidyTypeId": 1,
                    "LocalSubsidyTypeId": 2003,
                    "IsTES": True,
                    "IsEPA": True,
                    "IsEPB": True
                },
                "Licensing": {
                    "LicensingStatus": 1,
                    "LicensingLocation": licensing_location,
                    "LicensingLocationId": licensing_location_id,
                    "InsuredYears": 2,
                    "Stamp": 1,
                    "ChooseLicensing": 0,
                    "ChooseRemark": None,
                    "AgencyFees": agency_fees
                },
                "LicenseType": license_type
            },
            "Payment": {
                "Type": payment_type,
                "IsPaymentChange": is_payment_change,
                "cash": {},
                "loan": payments
            },
            "Contract": {
                "InvoicesGUINumbers": None,
                "InvoicesTitle": None
            },
            "Recommend": {},
            "IsReceiveAward": is_receive_award,
            "DocumentFeePayer": document_fee_payer,
            "ProductList": [
                {
                    "Id": "00000000-0000-0000-0000-000000000000",
                    "Name": "",
                    "Type": 0,
                    "Descriptions": None,
                    "Product":
                        products
                }
            ]
        }
        print(data)
        resp = self.init.request('post', '/shopping-cart/modify-order', json=data)
        return resp
