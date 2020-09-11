import os
import sys
import time
import uuid
from robot.libraries.String import String
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../dataPlatform/go_platform/api'))
from LibUsers import LibUsers

class CreditCards(object):
    def __init__(self):
        self.credit_card_no = '4938-1701-8888-9018'
        self.credit_card_month = '12'
        self.credit_card_year = '2028'
        self.credit_card_pwd = '554'

class Roles(object):
    def __init__(self, email):
        resp = LibUsers().users_get_email(email, 2).json()['data'][0]

        self.user_id = resp['user_id']
        self.user_guid = resp['gogoro_guid']
        self.email = email
        self.full_phone = resp['mobile_phone1']
        self.part_phone = self.full_phone[6:]
        self.profile_id = resp['profile_id']
        self.name = resp['last_name'] + resp['first_name']
        self.birthday = resp['birthday']
        self.birthday_year = self.birthday[:4]
        self.birthday_month = self.birthday[5:7]
        self.birthday_day = self.birthday[8:10]
        self.address = resp['contact_address']
        self.city = resp['contact_city']
        self.district = resp['contact_district']
        self.zipcode = resp['contact_zip']
        self.full_address = self.city + self.district + self.address

        gender_list = {
            "M": 1,
            "F": 2,
            "O": 3
        }
        self.gender = gender_list[resp['gender']]

class Scooters(object):
    def __init__(self, scooter_model):
        rf_string = String()    # RF Library
        self.company_code = '1500'
        self.country = 'TW'
        self.keyfobs_id = rf_string.generate_random_string(3, '[NUMBERS]')
        self.vin = rf_string.generate_random_string(13, '[UPPER][NUMBERS]')
        self.plate = rf_string.generate_random_string(3, '[UPPER][NUMBERS]')+'-'+rf_string.generate_random_string(4, '[UPPER][NUMBERS]')
        self.scooter_guid = str(uuid.uuid4())
        self.matnr = scooter_model
        self.motor_num = self.matnr
        self.scooter_vin = 'SWQA' + self.vin
        self.atmel_key = 'ED554638AD91C64694A39262CA1A3C14663B8ACBDF8E074E98BBD965EA1969C8'
        self.atmel_sn = '0123F61FCBFED2A0B1'
        self.manufacture_date = time.strftime("%Y-%m-%d")
        self.state = '1'
        self.es_state = '13'
        self.ecu_mac = 'rpNx83uY'
        self.ecu_sn = 'MABBQUFCBBIwABYzRQBkEA=='
        self.ecu_status = '1'
        self.keyfobs_status = '1'
        self.keyfobs_id = '321'

class Orders(object):
    def __init__(self, order_no):
        self.order_id = None
        self.owner_id = None
        self.order_no = order_no