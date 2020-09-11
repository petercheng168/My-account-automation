#!/usr/bin/env python
# -*- coding: utf-8 -*-
import base64
import hashlib
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../'))
from hashids import Hashids
from lib.LibVar import LibVar


class LibCrypto(object):

    def __init__(self, salt='SALT'):
        self.LibVar = LibVar()
        self.SALT = self.LibVar.get_var(salt)

    def encode_hashid(self, encode_id):
        if isinstance(encode_id, int) is False:
            encode_id = int(encode_id)
        hash_ids = Hashids(salt='{}'.format(self.SALT), min_length=8,
                           alphabet='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890')
        hash_id = hash_ids.encode(encode_id)
        return hash_id

    def decode_encodeid(self, hash_id):
        # if isinstance(encode_id, int) is False:
        #     encode_id = int(encode_id)
        hash_ids = Hashids(salt='{}'.format(self.SALT), min_length=8,
                           alphabet='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890')
        encode_id = hash_ids.decode(hash_id)
        return encode_id[0]

    @staticmethod
    def encode_text_with_base64(text, algorithms):
        m = None
        if algorithms == 'sha256':
            m = hashlib.sha256()
        elif algorithms == 'sha512':
            m = hashlib.sha512()
        m.update(bytes(text, encoding='utf-8'))
        crypto_text = str(base64.b64encode(m.digest()), encoding='utf-8')

        return crypto_text
