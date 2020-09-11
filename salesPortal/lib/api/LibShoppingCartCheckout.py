#!/usr/bin/env python
# -*- coding: utf-8 -*-
from robot.libraries.BuiltIn import BuiltIn
import json
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase


class LibShoppingCartCheckout(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------

    def _get_licensing_payload(self, licensing_location, licensing_location_id, agency_fee, plate_type='gogoro_plate'):
        """ Get sales portal's licensing payload
        Args:
            plate_type (str): gogoro_plate is 代領牌, self_plate is 自領牌

        Returns:
            dict: The return value
        """
        licensing = {
            "gogoro_plate": {
                "LicensingStatus": 1,
                "LicensingLocation": licensing_location,
                "LicensingLocationId": licensing_location_id,
                "InsuredYears": 2,
                "Stamp": 1,
                "ChooseLicensing": 0,
                "ChooseRemark": None,
                "AgencyFees": agency_fee
            },
            "self_plate": {
                "LicensingStatus": 2,
                "LicensingLocation": licensing_location,
                "LicensingLocationId": licensing_location_id,
                "InsuredYears": 0,
                "Stamp": 0,
                "ChooseLicensing": 0,
                "ChooseRemark": None,
                "AgencyFees": 0
            }
        }
        return licensing[plate_type]

    def _get_payment_type(self, payment_type='cash'):
        """ Get sales portal's payment type and information
        Args:
            payment_type (str): cash is 現金, loan is 貸款, credit_card is 信用卡刷卡

        Return:
            dict: The return value
        """
        payment = {
            "cash": {
                "Type": 2,
                "CreditCard": {},
                "Cash": {},
                "Loan": {},
                "Receivables": {},
                "IsPaymentChange": 0
            },
            "loan": {
                "Type": 3,
                "IsPaymentChange": 0,
                "Loan": {
                    "Amount": 52380,
                    "DownPayment": 1000,
                    "LoanId": "80607612",
                    "LoanCompany": "遠信國際租賃股份有限公司",
                    "Interest": 1,
                    "CoSigner": 0,
                    "IsBorrowerSameOwner": True,
                    "Period": 6,
                    "InterestRate": 2.5,
                    "PeriodAmount": 8954,
                    "PeriodIndex": 0
                }
            },
            "card": {
                "Type": 1,
                "CreditCard": {
                    "Type": 3,
                    "Amount": 109200,
                    "Period": 0,
                    "Month": "12",
                    "Year": "2028",
                    "SecurityCode": "541",
                    "CardNo": 4938170188888994
                }
            }
        }
        return payment[payment_type]

    def _get_scooter_payload(self, pdi_store_id, pairing_account, pairing_user_guid, sing_date,
                                subsidy_city, tes_subsidy_type_id, local_subsidy_type_id, license_type,
                                licensing, subsidy_type, is_tes, is_epa, is_epb, scooter_type='normal'):
        """ Get sales portal's scooter payload
        Args:
            scooter_type (str): normal is 一般購車, legal_entity is 法人贈車

        Returns:
            dict: The return value
        """
        if local_subsidy_type_id:
            local_subsidy_type_id = int(local_subsidy_type_id)
        scooter = {
            "normal": {
                "PDIStoreId": pdi_store_id,
                "PairingAccount": pairing_account,
                "PairingUserId": pairing_user_guid,
                "SingingDay": sing_date,
                "SubsidyType": subsidy_type,
                "SubsidyApplication": 2,
                "SubsidyCounty": subsidy_city,
                "BeDeprecatedSamePerson": 1,
                "Subsidy": {
                    "TesSubsidyTypeId": int(tes_subsidy_type_id),
                    "LocalSubsidyTypeId": local_subsidy_type_id,
                    "IsTES": is_tes,
                    "IsEPA": is_epa,
                    "IsEPB": is_epb
                },
                "Licensing": licensing,
                "LicenseType": license_type
            },
            "legal_entity":   {
                "PDIStoreId": pdi_store_id,
                "PairingAccount": pairing_account,
                "PairingUserId": pairing_user_guid,
                "SingingDay": sing_date,
                "SubsidyType": 1,
                "SubsidyApplication": 1,
                "SubsidyCounty": "",
                "BeDeprecatedSamePerson": 1,
                "Subsidy": {
                    "TesSubsidyTypeId": 2,
                    "LocalSubsidyTypeId": None,
                    "IsTES": is_tes,
                    "IsEPA": is_epa,
                    "IsEPB": is_epb
                },
                "Licensing": licensing,
                "LicenseType": license_type
            }
        }
        return scooter[scooter_type]

    def shopping_cart_checkout_post(self, user_id, employee_no, buyer_email, buyer_name, buyer_gender, buyer_phone, buyer_city,
                                        buyer_district, buyer_zipcode, buyer_address, owner_email, owner_name, owner_gender,
                                        owner_profile_id, owner_phone, owner_birthday, owner_city, owner_district,
                                        owner_zipcode, owner_address, driver_name, driver_email, sales_channel_no, 
                                        sales_channel_name, invoice_number, invoice_date, store_id, pdi_store_id,
                                        pairing_user_guid, sing_date, subsidy_city, tes_subsidy_type_id, local_subsidy_type_id,
                                        licensing_location, licensing_location_id, agency_fee, license_type, order_type,
                                        scooter_type='normal', plate_type='1', document_payer=1, payment_type='cash',
                                        subsidy_type=2, is_tes=True, is_epa=True, is_epb=True, token=None, hash_id=None):
        """ Add scooter into shopping cart
        Args:
            user_id (str): buyer guid
            employee_no (str): sales portal account
            store_id (str): department code
            pdi_store_id (str): department code
            pairing_user_guid (str): driver guid
            sing_date (str): driver birthday, format is YYYY-MM-dd
            tes_subsidy_type_id (int): reference mapping table
            local_subsidy_type_id (int): reference mapping table
            order_type (int): 1 = scooter order , 2 = legal entity order

        Returns:
            resp: Return json object

        Examples:
            | Shopping Cart Checkout Post | PAYLOAD |
        """
        self.init.auth(token, hash_id)
        licensing = self._get_licensing_payload(licensing_location, licensing_location_id, agency_fee, plate_type)
        payment = self._get_payment_type(payment_type)
        scooter = self._get_scooter_payload(pdi_store_id, driver_email, pairing_user_guid, sing_date, subsidy_city,
                                            tes_subsidy_type_id, local_subsidy_type_id, license_type, licensing,
                                            subsidy_type, is_tes, is_epa, is_epb, scooter_type)
        data = {
            "Bag": 1,
            "UserId": user_id,
            "OrderNo": None,
            "OrderType": order_type,
            "CustomerSource": 1,
            "SalesChannelNo": sales_channel_no,
            "SalesChannelName": sales_channel_name,
            "SalesStoreNo": None,
            "SalesStoreName": None,
            "DiscountPlanId": None,
            "EmployeeNo": employee_no,
            "CheckEmployeeNo": None,
            "Recommended": None,
            "Remark": None,
            "Invoice": {
                "Numbers": invoice_number,
                "GUINumbers": None,
                "Donation": None,
                "DonationNumbers": None,
                "Date": invoice_date
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
                },
                {
                    "ProjectCode": "EVT250",
                    "ProjectName": "Gogoro 3系列全新改款送藍牙耳機與安全帽",
                    "ProjectDescription": "Gogoro 3系列全新改款送藍牙耳機與安全帽",
                    "Remark": None,
                    "Product": [],
                    "Delivery": {}
                }
            ],
            "Buyer": {
                "Email": buyer_email,
                "Name": buyer_name,
                "Gender": int(buyer_gender),
                "Mobile": buyer_phone,
                "City": buyer_city,
                "CityId": None,
                "District": buyer_district,
                "DistrictId": None,
                "ZipCode": buyer_zipcode,
                "Address": buyer_address
            },
            "Owner": {
                "Email": owner_email,
                "Name": owner_name,
                "Gender": int(owner_gender),
                "IDCard": owner_profile_id,
                "Mobile": owner_phone,
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
                "Name": driver_name,
                "Email": driver_email
            },
            "Deliveries": {},
            "DeliveryConditions": {
                "Type": 2,
                "StoreId": store_id
            },
            "Scooter": scooter,
            "Payment": payment,
            "Contract": {},
            "Recommend": {},
            "IsReceiveAward": -1,
            "TestRide": 1,
            "DocumentFeePayer": document_payer
        }
        resp = self.init.request('post', '/shopping-cart/checkout', json=data)
        return resp
