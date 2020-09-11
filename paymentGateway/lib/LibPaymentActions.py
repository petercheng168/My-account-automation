# -*- coding: utf-8 -*-
import re
import os
import sys
import json
from datetime import date, timedelta, datetime, time
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from goBank.api.Wallet import Wallet
from lib.LibAppCipher import LibAppCipher
from lib.LibLogger import set_logger
from lib.LibSSHCommand import LibSSHCommand
from lib.LibVar import LibVar

logger = set_logger(__name__)


class LibPaymentActions:

    def __init__(self):
        self.variable = LibVar()
        self.log_host = self.variable.get_var('LOG_SERVER_HOST')
        self.log_account = self.variable.get_var('LOG_SERVER_ACCOUNT')
        self.log_password = self.variable.get_var('LOG_SERVER_PASSWORD')
        self.calender = self.variable.get_var('PAYMENT_GATEWAY_CALENDER')

    @staticmethod
    def get_credit_card_and_delete(user_id, wallet_id, credit_card_number):
        credit_card_id = None
        auth = LibAppCipher().app_cipher_get(account=None)
        response = Wallet()
        get_json = response.get_credit_cards(wallet_id, auth).json()

        for i in get_json['data']:
            if i['credit_card_number'] == credit_card_number:
                credit_card_id = i['credit_card_id']

        if credit_card_id is None:
            raise Exception('The credit card is not activate')

        delete_json = response.delete_credit_cards(wallet_id, user_id, credit_card_id, auth).json()
        if delete_json['code'] != 0:
            raise Exception('Delete user_id: {} wallet_id:{} credit_card_number:{} is failure'
                            .format(user_id, wallet_id, credit_card_number))

    def get_logs(self, log_text):
        ssh = LibSSHCommand(self.log_host, self.log_account, self.log_password)
        logs = ssh.exec_command('cd services/;docker-compose logs --tail=10')

        if log_text in logs:
            return True
        else:
            return False

    def get_working_day(self, days, date_format):
        """
        Get working day depends on the calender
        """
        holiday = {}

        with open(self.calender, 'r') as file:
            data = json.loads(file.read())
        for i in data['result']['records']:
            holiday[i['date']] = i['isHoliday']

        count = 1
        while True:
            working_date = (date.today() - timedelta(days=count)).strftime('%Y/%-m/%-d')
            if working_date in holiday and holiday[working_date] == '否' or working_date not in holiday:
                days -= 1
                if days == 0:
                    break
            count += 1

        working_date = datetime.strptime(working_date, '%Y/%m/%d').strftime(date_format)

        return working_date

    @staticmethod
    def get_timestamp_interval(days):
        if isinstance(days, str):
            days = int(days)
        today = date.today()
        calculate_days = today + timedelta(days=days)
        from_time = datetime.combine(calculate_days, time.min).strftime('%s')
        to_time = datetime.combine(calculate_days, time.max).strftime('%s')

        return {'from_time': from_time, 'to_time': to_time}

    @staticmethod
    def replace_ach_file(source_file, target_file, **kwargs):
        with open(source_file, 'r', newline='') as file:
            file_data = file.read()

        for key, value in kwargs.items():
            file_data = file_data.replace(key, value)

        with open(source_file, 'w', newline='') as file:
            file.write(file_data)

        os.rename(source_file, target_file)

    # args should put the account_num, bank_barcode1, r_code
    @staticmethod
    def replace_ach_p01_file(source_file, target_file, *args: list):
        with open(source_file, 'r', newline='') as file:
            lines = file.readlines()

        with open(source_file, 'w', newline='') as file:
            for line_index in range(len(lines)):
                if line_index == 0:
                    first_line_r1 = re.search(r'^BOFACHP01(\d{14})81200129990250', lines[0]).group(1)
                    lines[line_index] = lines[line_index].replace(lines[line_index], 'BOFACHR01' + first_line_r1 +
                                                                  '99902508120012' + ' ' * 123 + '\r\n')
                    file.write(lines[line_index])
                elif line_index == len(lines) - 1:
                    last_line_r = re.search(r'^EOFACHP01(\d{8})81200129990250(\d{8})(\d{16})', lines[len(lines) - 1])
                    last_line_r1 = last_line_r.group(1)
                    last_line_r2 = last_line_r.group(2)
                    last_line_r3 = last_line_r.group(3)
                    lines[line_index] = lines[line_index].replace(lines[line_index], 'EOFACHR01' + last_line_r1 +
                                                                  '99902508120012' + last_line_r2 + last_line_r3 +
                                                                  ' ' * 105)
                    file.write(lines[line_index])
                else:
                    for element in args:
                        if len(element) != 3:
                            raise Exception('The input data is invalid!')
                        account_num = element[0]
                        bank_barcode1 = element[1]
                        r_code = element[2]
                        middle_line_r = re.search(
                            r'^NSD(\d{9})8120012(\d{14})(812\d{4})(\d{14})(0000000060)00B54387162\s{2}' + account_num
                            + '\s{6}0{14}\s' + bank_barcode1, lines[line_index])
                        middle_line_r1 = middle_line_r.group(1)
                        middle_line_r2 = middle_line_r.group(2)
                        middle_line_r3 = middle_line_r.group(3)
                        middle_line_r4 = middle_line_r.group(4)
                        middle_line_r5 = middle_line_r.group(5)

                        lines[line_index] = lines[line_index].replace(lines[line_index], 'RSD' + middle_line_r1 +
                                                                      middle_line_r3 + middle_line_r4 + '8120012' +
                                                                      middle_line_r2 + middle_line_r5 + r_code +
                                                                      'B54387162  ' + account_num + ' ' * 6 + '0' * 14
                                                                      + ' ' + bank_barcode1 + ' ' * 36 + '\r\n')
                        file.write(lines[line_index])

        os.rename(source_file, target_file)

    @staticmethod
    def filter_get_card_page_info(card_number, expired_date, auth_url):
        """
        card number: 3565580700005806 will split to card_no1 ~ card_no4
        expired date: 4112 will split to expired_year and expired_month
        binding card will get the auth_url and will split to trans_id
        """
        bank_info = {}

        card_no1, card_no2, card_no3, card_no4 = card_number[0:4], card_number[4:8], card_number[8:12], card_number[
                                                                                                        12:16]
        expired_year, expired_month = re.search('([0-9][0-9])([0-9][0-9])', expired_date).group(1, 2)
        trans_id = re.search('(.*)?id=(.*)', auth_url).group(2)

        bank_info.update({'card_no1': card_no1, 'card_no2': card_no2, 'card_no3': card_no3, 'card_no4': card_no4,
                          'expired_year': expired_year, 'expired_month': expired_month, 'trans_id': trans_id})

        return bank_info
