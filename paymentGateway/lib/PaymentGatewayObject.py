import re
import time
import uuid
import datetime
from lib.LibVar import LibVar
from robot.libraries.String import String


class SetUpBill:
    def __init__(self, user_id, email, es_contract_id, scooter_id, payment_type, bill_period, to_time, from_time,
                 issue_date, last_calc_date):
        self.user_id = user_id
        self.bill_period = bill_period
        self.amount = 60
        self.bank_code1 = self.generate_bank_code1()
        self.bank_code2 = self.amount
        self.store_code1 = self.generate_store_code()['store_code1']
        self.store_code2 = self.generate_store_code()['store_code2']
        self.store_code3 = self.generate_store_code()['store_code3']
        self.contact_address = '長安東路二段225號C棟11樓'
        self.contact_zipcode = '105'
        self.email = email
        self.to_time = to_time
        self.from_time = from_time
        self.issue_date = issue_date
        self.last_calc_date = last_calc_date
        self.es_contract_id = es_contract_id
        self.scooter_id = scooter_id
        self.payment_type = payment_type
        self.settle_days = 31
        self.bill_to_name = 'PG Test'
        self.base_price_amount = 10
        self.over_unit_price_amount = 10
        self.other_charge_amount = 10
        self.addon_price_amount = 10
        self.promotion_price_amount = 10
        self.penalty_amount = 0
        self.delivery_method = 1
        self.resource_type = 5
        self.other_data = 'Test data'
        self.details_amount = 499
        self.latest_bill_calc_end_date = last_calc_date
        self.tax_amount = 10
        self.tax_rate = 10
        self.adjustment_amount = 0
        self.balance = 60
        self.bill_status = 1
        self.previous_balance = 150
        self.previous_paid_amount = 150
        self.payment_type = payment_type

    def generate_store_code(self):
        store_code1 = None
        check_code = '00'
        code_result = {}
        date = int(datetime.date.today().strftime('%Y%m%d'))

        store_code1_date = re.search(r'^1(\d{2})(\d{2})(\d{2})$', str(date - 19110000))

        year = store_code1_date.group(1)
        month = store_code1_date.group(2)
        day = store_code1_date.group(3)

        if day <= '10' or day > '25':
            day = '10'
            store_code1 = year + month + '10694'
        elif '10' < day <= '25':
            day = '25'
            store_code1 = year + month + '25694'

        store_code2 = self.bank_code1
        store_code3 = month + day + check_code + str(self.amount).zfill(9)

        check_code = self.generate_check_code(store_code1=store_code1, store_code2=store_code2, store_code3=store_code3)

        store_code3 = month + day + check_code + str(self.amount).zfill(9)
        store_code1 = store_code1.replace(store_code1[-2:], 'RU')

        code_result.update({'store_code1': store_code1, 'store_code2': store_code2, 'store_code3': store_code3})

        return code_result

    @staticmethod
    def generate_check_code(**kwargs):
        code_list = {}

        for key, value in kwargs.items():
            odd = [value[i] for i in range(len(value)) if i % 2 == 0]
            even = [value[i] for i in range(len(value)) if i % 2 != 0]
            code_list.update({key: {'odd': odd, 'even': even}})

        def code_sum(check_list):
            init = 0
            cal = 0
            for i in list(map(int, check_list)):
                init = i + init
                cal = init

            return cal

        code1 = str((code_sum(code_list['store_code1']['odd']) + code_sum(code_list['store_code2']['odd']) + code_sum(
            code_list['store_code3']['odd'])) % 11)
        if code1 == '0':
            code1 = 'A'
        elif code1 == '10':
            code1 = 'B'

        code2 = str((code_sum(code_list['store_code1']['even']) + code_sum(code_list['store_code2']['even']) + code_sum(
            code_list['store_code3']['even'])) % 11)
        if code2 == '0':
            code2 = 'X'
        elif code2 == '10':
            code2 = 'Y'

        result = code1 + code2

        return result

    @staticmethod
    def generate_bank_code1():
        total = 0
        enterprise_code = '8765'
        rf_string = String()
        random_code = rf_string.generate_random_string(11, '[NUMBERS]')
        bank_code_prefix = enterprise_code + random_code

        for i in range(len(bank_code_prefix)):
            if i % 2 == 0:
                total = int(bank_code_prefix[i:i + 1]) * 3 + total
            else:
                total = int(bank_code_prefix[i:i + 1]) * 1 + total

        if total % 10 == 0:
            bank_code_1 = bank_code_prefix + '0'
        else:
            bank_code_1 = bank_code_prefix + str(10 - (total % 10))

        return bank_code_1


class SetUpScooter:
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
        self.scooter_vin = 'SWQA' + self.vin
        self.atmel_key = 'ED554638AD91C64694A39262CA1A3C14663B8ACBDF8E074E98BBD965EA1969C8'
        self.atmel_sn = '0123F61FCBFED2A0B1'
        self.manufacture_date = time.strftime("%Y-%m-%d")
        self.state = '9'
        self.es_state = '13'
        self.ecu_mac = 'rpNx83uY'
        self.ecu_sn = 'MABBQUFCBBIwABYzRQBkEA=='
        self.ecu_status = '1'
        self.keyfobs_status = '1'


class SetUpUser:
    def __init__(self, user_type, password):
        if user_type == 'new_user':
            rf_string = String()    # RF Library
            self.time = int(time.time())
            self.company_code = 1300
            self.status = 1
            self.enable_e_carrier = 1
            self.country_code = 'TW'
            self.gender = 'M'
            self.gogoro_guid = str(uuid.uuid4())
            self.first_name = rf_string.generate_random_string(5, '[UPPER]')
            self.last_name = rf_string.generate_random_string(5, '[UPPER]')
            self.display_name = self.last_name + self.first_name
            self.email = 'pasw.verify-{}@yopmail.com'.format(self.time)
            self.mobile = '09' + rf_string.generate_random_string(8, '[NUMBERS]')
            self.profile_id = 'A1' + rf_string.generate_random_string(8, '[NUMBERS]')
            self.encode_password = password
            self.birthday = time.strftime("%Y-%m-%d")
            self.contact_city = '臺北市'
            self.contact_district = '松山區'
            self.contact_zipcode = '10552'
            self.contact_address = '長安東路二段225號C棟11樓'
            self.phone = self.mobile
            self.occupation = '1'
            self.invoice_city = '臺北市'
            self.invoice_district = '松山區'
            self.invoice_zipcode = '10552'
            self.invoice_address = '長安東路二段225號C棟11樓'
        else:
            self.variable = LibVar()
            self.encode_password = password
            self.email = self.variable.get_var('PAYMENT_GATEWAY_ACCOUNT')
            self.gogoro_guid = self.variable.get_var('PAYMENT_GATEWAY_GUID')
