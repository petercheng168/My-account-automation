# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../'))
from paymentGateway.api.Base import Base
from lib.LibLogger import set_logger

logger = set_logger(__name__)


class ConvenientStore(Base):

    def __init__(self):
        super().__init__()

    def write_off_convenient_store(self, file_name, auth):
        """
        Get conveninet store write-off file from Taishin and send the write-off request to write-off service
        :param file_name: string type
        :param auth: get from cipher
        Examples:
        | Write Off Convenient Store | PAYLOAD |
        """
        payload = {
            'fileName': file_name,
        }

        response = super().pg_post('/api/payment/convenient_store_write_off', payload, auth=auth)

        return response
