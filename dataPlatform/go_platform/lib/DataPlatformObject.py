import uuid
import os
import random
import sys
import time
from robot.api import logger
from robot.libraries.String import String
from robot.libraries.DateTime import get_current_date, convert_date
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from lib.LibAppCipher import LibAppCipher


class Batteries(object):
    def __init__(self):
        rf_string = String()    # RF Library
        self.battery_guid = str(uuid.uuid4())
        self.charge_cycles = '0'
        self.manufacture_date = time.strftime("%Y-%m-%d")
        self.pn = rf_string.generate_random_string(2, '[NUMBERS]')
        self.sn = rf_string.generate_random_string(7, '[UPPER][NUMBERS]')
        self.pn = 'QA_TEST_' + self.pn
        self.battery_sn = 'TWSWQA' + self.sn
        self.state = '1'


class BatteriesReports(object):
    def __init__(self, login_user, battery_sn):
        rf_string = String()    # RF Library
        self.time = int(time.time() * 1000)
        self.login_user = 'sw.verify+{}@gogoro.com'.format(login_user)
        self.battery_sn = 'SWQA' + battery_sn
        self.cmd_id = rf_string.generate_random_string(8, '[NUMBERS]')
        self.cmd_val = rf_string.generate_random_string(8, '[UPPER]')
        self.log_path = '/log_' + time.strftime("%Y_%m_%d") + '.zip'
        self.description = rf_string.generate_random_string(8, '[UPPER]')


class Companies(object):
    def __init__(self, status):
        rf_string = String()    # RF Library
        self.company_name = 'SWQA' + \
            rf_string.generate_random_string(5, '[UPPER]')
        self.company_code = 'SWQA' + \
            rf_string.generate_random_string(5, '[NUMBERS]')
        self.company_type = 11
        self.company_sub_type = 11
        self.company_group_id = None
        self.brand_name = 'SWQA'
        self.address = '長安東路二段225號C棟11樓'
        self.zip_code = '10552'
        self.country_code = 'TW'
        self.contact_person_firstname = rf_string.generate_random_string(
            5, '[UPPER]')
        self.contact_person_lastname = rf_string.generate_random_string(
            5, '[UPPER]')
        self.contact_email = 'sw.verify+{}@gogoro.com'.format(int(time.time()))
        self.contact_phone1 = '09' + \
            rf_string.generate_random_string(8, '[NUMBERS]')
        self.contact_phone2 = '09' + \
            rf_string.generate_random_string(8, '[NUMBERS]')
        self.status = status


class Departments(object):
    def __init__(self):
        timestamp = int(round(time.time() * 1000))
        rf_string = String()    # RF Library
        self.department_id = None
        self.department_code = "DH_" + '{}'.format(timestamp)
        self.department_name = "DH_" + '{}'.format(timestamp)
        self.department_type = 1
        self.owner_company_id = None
        self.contract_start_date = timestamp
        self.contract_expiration_date = timestamp + 30 * 60 * 1000
        self.contact_address = '長安東路二段225號C棟11樓'
        self.contact_zip = '10552'
        self.contact_person = 'SWQA' + \
            rf_string.generate_random_string(5, '[UPPER]')
        self.contact_email = '{}@gogoro.com'.format(timestamp)
        self.contact_phone1 = rf_string.generate_random_string(8, '[NUMBERS]')
        self.contact_phone2 = rf_string.generate_random_string(8, '[NUMBERS]')
        self.country_code = 'TW'
        self.status = 1


class Employees(object):
    def __init__(self, password='Gogoro123'):
        rf_string = String()    # RF Library
        self.time = int(time.time() * 1000)
        self.emp_code = 'SWQA_{}'.format(self.time)
        self.contact_address = '長安東路二段225號C棟11樓'
        self.contact_zip = '10552'
        self.encode_password = LibAppCipher().encode_password_get(password).text
        self.first_name = rf_string.generate_random_string(5, '[UPPER]')
        self.middle_name = rf_string.generate_random_string(5, '[UPPER]')
        self.last_name = rf_string.generate_random_string(5, '[UPPER]')
        self.legal_first_name = rf_string.generate_random_string(5, '[UPPER]')
        self.legal_middle_name = rf_string.generate_random_string(5, '[UPPER]')
        self.legal_last_name = rf_string.generate_random_string(5, '[UPPER]')
        self.gender = 'M'
        self.mobile = '09' + rf_string.generate_random_string(8, '[NUMBERS]')
        self.phone = self.mobile
        self.email = 'sw.verify+{}@gogoro.com'.format(self.time)
        self.profile_id = 'E1' + \
            rf_string.generate_random_string(8, '[NUMBERS]')


class EsBills(object):
    def __init__(self, **kwargs):
        random_year = random.randint(1971, 2100)
        random_month = format(random.randint(1, 12), '02')
        bill_period = "{}-{}".format(random_year, random_month)
        self.bill_period = kwargs.get('bill_period', bill_period)
        issue_date = int(convert_date(
            "{}-10".format(self.bill_period), result_format='epoch'))

        due_date = int(convert_date(
            "{}-20".format(self.bill_period), result_format='epoch'))

        due_date = int(get_current_date(
            increment='15 days', result_format='epoch', exclude_millis='yes'))

        self.date_from = int(get_current_date(
            increment='-15 days', result_format='epoch', exclude_millis='yes'))
        self.date_to = int(get_current_date(
            increment='15 days', result_format='epoch', exclude_millis='yes'))
        self.last_calc_date = self.date_from - 86400

        self.accumulated_es_bill_id = kwargs.get(
            'accumulated_es_bill_id', None)
        self.amount = kwargs.get('amount', 499)
        self.balance = kwargs.get('balance', "499.0")
        self.previous_balance = kwargs.get('previous_balance', 0)
        self.previous_paid_amount = kwargs.get('previous_paid_amount', 0)
        self.adjustment_amount = kwargs.get('adjustment_amount', 0)
        self.bill_status = kwargs.get('bill_status', 1)
        self.discarded_es_bill_id = kwargs.get('discarded_es_bill_id', None)
        self.unissued_invoice_amount = kwargs.get('unissued_invoice_amount', 0)
        self.issue_date = kwargs.get('issue_date', issue_date)
        self.due_date = kwargs.get('due_date', due_date)
        self.taxable_amount = kwargs.get('taxable_amount', float(
            self.balance) - float(self.adjustment_amount))
        self.tran_no = 178552762


class EsContracts(object):
    def __init__(self, es_plan_id=None, addon_code=None, addon_id=None,
                 promotion_id=None, default_plan_id=None, cycle_end_day=31,
                 contract_shift=0):
        """
        contract_shift(int): default is 0 day, it means that will shift 0 day.
        """
        if default_plan_id is None:
            default_plan_id = es_plan_id

        self.es_contract_id = None
        self.addon_code = addon_code
        self.addon_id = addon_id
        self.es_plan_id = es_plan_id
        self.default_plan_id = default_plan_id
        self.promotion_id = promotion_id
        self.start_date = int(time.time())
        self.effective_date = int(time.time())
        self.end_date = int(time.time() + 10)
        self.cycle_end_day = cycle_end_day
        self.contract_date = int(time.time() + 86400 * contract_shift)



class Hubs(object):
    def __init__(self, status=1):
        rf_string = String()    # RF Library
        self.hub_code = rf_string.generate_random_string(8, '[NUMBERS]')
        self.name = rf_string.generate_random_string(8, '[NUMBERS]')
        self.type = 123
        self.country_code = "TW"
        self.address = "長安東路二段225號C棟11樓"
        self.city = "Taipei"
        self.zip = 10552
        self.status = status
        self.remark = "remark"


class Orders(object):
    def __init__(self, order_no=None):
        rf_string = String()    # RF Library

        self.order_id = None
        self.owner_id = None

        if order_no is None:
            self.order_no = 'P0' + \
                rf_string.generate_random_string(8, '[NUMBERS]')
        else:
            self.order_no = order_no


class Scooters(object):
    def __init__(self, company_code, scooter_model):
        rf_string = String()    # RF Library
        self.scooter_id = None
        self.atmel_key = 'ED554638AD91C64694A39262CA1A3C14663B8ACBDF8E074E98BBD965EA1969C8'
        self.atmel_sn = '0123F61FCBFED2A0B1'
        self.company_code = company_code
        self.ecu_mac = 'rpNx83uY'
        self.ecu_sn = 'MABBQUFCBBIwABYzRQBkEA=='
        self.ecu_status = '1'
        self.es_state = '13'
        self.file_name = rf_string.generate_random_string(
            8, '[LETTERS][NUMBERS]')
        self.guid = str(uuid.uuid4())
        self.keyfobs_id = rf_string.generate_random_string(3, '[NUMBERS]')
        self.keyfobs_status = '1'
        self.manufacture_date = time.strftime("%Y-%m-%d")
        self.matnr = 'PI' + scooter_model + '-160-ORI'
        self.motor_num = self.matnr
        self.plate_first = rf_string.generate_random_string(3, '[UPPER]')
        self.plate_second = rf_string.generate_random_string(4, '[NUMBERS]')
        self.plate = self.plate_first + '-' + self.plate_second
        self.state = '9'
        self.plate_date = int(time.time())
        self.vin = 'SWQA' + \
            rf_string.generate_random_string(13, '[UPPER][NUMBERS]')
        self.warranty_start = int(time.time())
        self.warranty_end = int(time.time() + 10)


class Users(object):
    def __init__(self, password='Gogoro123'):
        rf_string = String()    # RF Library
        self.user_id = None
        self.contract_owner_id = None
        self.birthday = time.strftime("%Y-%m-%d")
        self.company_code = 1300
        self.contact_address = '長安東路二段225號C棟11樓'
        self.contact_city = '臺北市'
        self.contact_district = '松山區'
        self.contact_zip = '10552'
        self.country_code = 'TW'
        self.enable_e_carrier = 1
        self.encode_password = LibAppCipher().encode_password_get(password).text
        self.first_name = rf_string.generate_random_string(5, '[UPPER]')
        self.last_name = rf_string.generate_random_string(5, '[UPPER]')
        self.gender = 'M'
        self.gogoro_guid = str(uuid.uuid4())
        self.invoice_address = '長安東路二段225號C棟11樓'
        self.invoice_city = '臺北市'
        self.invoice_district = '松山區'
        self.invoice_zip = '10552'
        self.mobile = '09' + rf_string.generate_random_string(8, '[NUMBERS]')
        self.occupation = '1'
        self.phone = self.mobile
        self.login_phone = self.mobile
        self.status = 1
        self.time = int(time.time() * 1000)
        self.display_name = self.last_name + self.first_name
        self.email = 'pasw.verify+{}@gogoro.com'.format(self.time)
        self.profile_id = 'E1' + \
            rf_string.generate_random_string(8, '[NUMBERS]')


class Parts(object):
    def __init__(self, part_category_type, names=None, prices=None):
        rf_string = String()    # RF Library
        self.sequence_id = 'SWQA' + \
            rf_string.generate_random_string(6, '[NUMBERS]')
        self.part_code = 'SWQA' + \
            rf_string.generate_random_string(6, '[NUMBERS]')
        self.part_category_type = part_category_type
        self.part_category_sub_type = 0
        self.part_category_id = None
        self.brand_company_code = None
        self.names = names
        self.production_start_time = int(time.time())
        self.production_end_time = int(time.time())
        self.sale_status = 1
        self.sale_suspend_time = int(time.time())
        self.warranty_period = 12
        self.warranty_distance = rf_string.generate_random_string(
            4, '[NUMBERS]')
        self.endurance_period = 12
        self.endurance_distance = rf_string.generate_random_string(
            4, '[NUMBERS]')
        self.prices = prices


class PartsName(object):
    def __init__(self, lang, value):
        self.lang = lang
        self.value = value


class PartsPrice(object):
    def __init__(self, part_code, price_type, amount, currency):
        self.part_code = part_code
        self.price_type = price_type
        self.amount = amount
        self.currency = currency
ˋ