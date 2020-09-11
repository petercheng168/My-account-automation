import time
import uuid
from datetime import date, timedelta
from robot.libraries.String import String


class Batteries(object):
    def __init__(self):
        rf_string = String()    # RF Library
        self.pn = rf_string.generate_random_string(2, '[NUMBERS]')
        self.sn = rf_string.generate_random_string(7, '[UPPER][NUMBERS]')
        self.battery_guid = str(uuid.uuid4())
        self.battery_sn = 'TWPASW' + self.sn
        self.charge_cycles = '0'
        self.state = '1'
        self.manufacture_date = time.strftime("%Y-%m-%d")
        self.pn = 'QA_TEST_' + self.pn

class Scooters(object):
    def __init__(self, company_code, scooter_model):
        rf_string = String()    # RF Library
        self.company_code = company_code
        self.file_name = rf_string.generate_random_string(8, '[LETTERS][NUMBERS]')
        self.plate_first = rf_string.generate_random_string(2, '[UPPER]')
        self.plate_second = rf_string.generate_random_string(4, '[NUMBERS]')
        self.keyfobs_id = rf_string.generate_random_string(3, '[NUMBERS]')
        self.vin = rf_string.generate_random_string(13, '[UPPER][NUMBERS]')
        self.scooter_guid = str(uuid.uuid4())
        self.plate = 'E' + self.plate_first + '-' + self.plate_second
        self.matnr = 'PI' + scooter_model + '-160-ORI'
        self.motor_num = self.matnr
        self.scooter_vin = 'PASW' + self.vin
        self.atmel_key = 'ED554638AD91C64694A39262CA1A3C14663B8ACBDF8E074E98BBD965EA1969C8'
        self.atmel_sn = '0123F61FCBFED2A0B1'
        self.manufacture_date = time.strftime("%Y-%m-%d")
        self.state = '9'
        self.es_state = '13'
        self.ecu_mac = 'rpNx83uY'
        self.ecu_sn = 'MABBQUFCBBIwABYzRQBkEA=='
        self.ecu_status = '1'
        self.keyfobs_status = '1'

class User(object):
    def __init__(self, password):
        rf_string = String()    # RF Library
        self.time = int(time.time())
        self.company_code = 1300
        self.status = 1
        self.enable_e_carrier = 1
        self.country_code = 'TW'
        self.gender = 'M'
        self.gogoro_guid = str(uuid.uuid4())
        self.first_name = rf_string.generate_random_string(5, '[UPPER]')
        self.last_name = 'PASW' + rf_string.generate_random_string(5, '[UPPER]')
        self.display_name = self.last_name + self.first_name
        # self.email = 'pasw.verify+{}@gogoro.com'.format(self.time)   #this account have a lot of scooters, the invoice setting cannot be change by userself
        self.email = 'pasw.verify.{}@yopmail.com'.format(self.time)
        self.emailv1 = 'pasw.verify-{}@yopmail.com'.format(self.time)
        self.mobile = '09' + rf_string.generate_random_string(8, '[NUMBERS]')
        # self.mobile = '886' + '09' + rf_string.generate_random_string(8, '[NUMBERS]')
        self.encode_password = password
        # Since myaccount user should over 20 ages. Therefore, the birthday is use current date -7500 days.
        self.birthday = (date.fromtimestamp(time.time()) + timedelta(days=-7500)).isoformat()
        self.contact_city = '臺北市'
        self.contact_district = '松山區'
        self.contact_zipcode = '10552'
        self.contact_address = '長安東路二段225號C棟11樓'
        self.phone = self.mobile
        # self.phone = self.mobile.replace('09', '+8869')
        # self.phone_number = self.phone.replace('+886', '')
        # print(self.phone)
        self.occupation = '1'
        self.invoice_city = '臺北市'
        self.invoice_district = '松山區'
        self.invoice_zipcode = '10552'
        self.invoice_address = '長安東路二段225號C棟11樓'
        