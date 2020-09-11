# -*- coding: utf-8 -*-
import json
import requests
import os
import sys
import multiprocessing
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from lib.LibVar import LibVar
from lib.LibLogger import set_logger
from json import JSONDecodeError
from requests.exceptions import ReadTimeout

logger = set_logger(__name__)


class Base:

    def __init__(self):
        self.variable = LibVar()
        self.pg_url = self.variable.get_var('PAYMENT_GATEWAY_URL')
        self.bind_card_url = self.variable.get_var('EXTERNAL_BANK_URL')
        self.tspg_url = None
        self.scheduler_url = self.variable.get_var('BILLING_SCHEDULER_URL')
        self.timeout = self.variable.get_var('API_TIMEOUT')
        self.headers = {
            'Content-Type': 'application/json'
        }

    def pg_post(self, end_point, data, auth=None):
        api_request = None
        try:
            if auth is not None:
                self.headers.update({'Authorization': 'bearer {}'.format(auth)})
            host = self.pg_url + end_point

            payload = json.dumps(data)
            api_request = requests.post(host, headers=self.headers, data=payload, timeout=self.timeout)

            logger.info('{} status_code is {}, payload is {}, auth is {} and the response json is {}'.format(
                end_point, api_request.status_code, data, auth, api_request.json()))

            api_request.close()
        except JSONDecodeError:
            logger.info('{} status_code is {}, payload is {}, auth is {} and the response text is {}'.format(
                end_point, api_request.status_code, data, auth, api_request.text))
        except ReadTimeout:
            logger.info('HTTPSConnectionPool Read Timeout, payload is {}, auth is {}'.format(
                data, auth))
        except Exception as ex:
            logger.exception(ex)

        return api_request

    def pg_request(self, method, end_point, data, auth=None):
        api_request = None
        try:
            if auth is not None:
                self.headers.update({'Authorization': 'bearer {}'.format(auth)})
            host = self.pg_url + end_point

            payload = json.dumps(data)

            api_request = requests.request(method, host, headers=self.headers, data=payload, timeout=self.timeout)

            logger.info('{} status_code is {}, payload is {}, auth is {} and the response json is {}'.format(
                end_point, api_request.status_code, data, auth, api_request.json()))

            api_request.close()
        except JSONDecodeError:
            logger.info('{} status_code is {}, payload is {}, auth is {} and the response text is {}'.format(
                end_point, api_request.status_code, data, auth, api_request.text))
        except ReadTimeout:
            logger.info('HTTPSConnectionPool Read Timeout, payload is {}, auth is {}'.format(
                data, auth))
        except Exception as ex:
            logger.exception(ex)

        return api_request

    def scheduler_request(self, method, end_point, auth, data=None):
        api_request = None
        try:
            if auth is not None:
                self.headers.update({
                    'Authorization': 'bearer {}'.format(auth),
                    'Go-Client': self.variable.get_var('GO_CLIENT_HEADER')
                })
            host = self.scheduler_url + end_point

            if data is None:
                api_request = requests.request(method, host, headers=self.headers, timeout=self.timeout)
            else:
                payload = json.dumps(data)
                api_request = requests.request(method, host, headers=self.headers, data=payload, timeout=self.timeout)

            logger.info('{} status_code is {}, payload is {}, auth is {} and the response json is {}'.format(
                end_point, api_request.status_code, data, auth, api_request.json()))

            api_request.close()
        except JSONDecodeError:
            logger.info('{} status_code is {}, payload is {}, auth is {} and the response text is {}'.format(
                end_point, api_request.status_code, data, auth, api_request.text))
        except ReadTimeout:
            logger.info('HTTPSConnectionPool Read Timeout, auth is {}'.format(auth))
        except Exception as ex:
            logger.exception(ex)

        return api_request

    def external_request(self, method, end_point, data=None):
        api_request = None
        try:
            if data is None:
                api_request = requests.request(method, self.tspg_url)
            else:
                host = self.bind_card_url + end_point

                if self.headers['Content-Type'] == 'application/json':
                    payload = json.dumps(data)
                else:
                    payload = data
                api_request = requests.request(method, host, headers=self.headers, data=payload)

            logger.info('{} status_code is {}, payload is {} and the response text is {}'.format(
                end_point, api_request.status_code, data, api_request.text))

            api_request.close()
        except Exception as ex:
            logger.exception(ex)

        return api_request

    def multiprocess_pg_post(self, count, end_point, data, auth=None):
        pool = multiprocessing.Pool(processes=count)
        result = []
        for i in range(count):
            result.append(pool.apply_async(self.pg_post, args=(end_point, data[i], auth)))
        pool.close()
        pool.join()

        return result
