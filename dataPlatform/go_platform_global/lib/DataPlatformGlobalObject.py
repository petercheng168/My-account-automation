import time
import uuid
import os
import sys
import random
from robot.libraries.String import String

__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))


class PartsCategories(object):

    def __init__(self, names, part_category_id=None):
        self.part_category_id = part_category_id
        self.type = random.randint(1, 4)
        self.sub_type = random.randint(100, 65535)
        self.names = names

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