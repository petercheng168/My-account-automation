# -*- coding: utf-8 -*-
import pyminizip


class LibZip:

    def __init__(self):
        pass

    @staticmethod
    def zip_file(source_file, target_zip, password=None):
        pyminizip.compress(source_file, None, target_zip, password, 5)

    @staticmethod
    def unzip_file(source_zip, target_path, password=None):
        pyminizip.uncompress(source_zip, password, target_path, 1)
