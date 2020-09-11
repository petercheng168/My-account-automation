#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../'))
from _init_ import _init_
from robot.libraries.BuiltIn import BuiltIn


class LibPerformanceTime(object):
    def __init__(self):
        self.init = _init_()
        self.webdriver = BuiltIn().get_library_instance('SeleniumLibrary')

    @staticmethod
    def average_time(temp_array):
        """ Get the average time of the function """
        first_stage = second_stage = third_stage = fourth_stage = 0.0
        count = len(temp_array) / 4
        for index in range(0, int(count)):
            first_stage = first_stage + float(temp_array[index * 3])
            second_stage = second_stage + float(temp_array[index * 3 + 1])
            third_stage = third_stage + float(temp_array[index * 3 + 2])
            fourth_stage = fourth_stage + float(temp_array[index * 3 + 3])
        first_stage = first_stage / count
        second_stage = second_stage / count
        third_stage = third_stage / count
        fourth_stage = fourth_stage / count
        result = [round(first_stage, 2), round(second_stage, 2), round(third_stage, 2), round(fourth_stage, 2)]
        return result

    def clear_resp_info(self):
        """ Clean start, end and duration time data """
        self.driver.execute_script("window.performance.clearMarks()")
        self.driver.execute_script("window.performance.clearMeasures()")

    def get_driver(self):
        """ Get webdriver """
        self.driver = self.webdriver.driver

    def get_mark_resp_time(self):
        """ Get performance duration time with million seconds """
        self.driver.execute_script("window.performance.measure('measure', 'mark_start', 'mark_end')")
        resp_time = self.driver.execute_script("return window.performance.getEntriesByType('measure')[0].duration")
        return resp_time

    @staticmethod
    def get_total_time(temp_array):
        """ Get total measure time with 1 round """
        total_time = temp_array[0] + temp_array[1] + temp_array[2] + temp_array[3]
        return total_time

    def mark_start(self):
        """ Decide start time of performance measuring """
        self.driver.execute_script("window.performance.mark('mark_start')")

    def mark_end(self):
        """ Decide end time of performance measuring """
        self.driver.execute_script("window.performance.mark('mark_end')")

    @staticmethod
    def maximum_time(temp_array):
        """ Get the maximum time of the function """
        first_list = []
        second_list = []
        third_list = []
        fourth_list = []
        count = len(temp_array) / 4
        for index in range(0, int(count)):
            first_list.append(temp_array[index * 3])
            second_list.append(temp_array[index * 3 + 1])
            third_list.append(temp_array[index * 3 + 2])
            fourth_list.append(temp_array[index * 3 + 3])
        result = [round(max(first_list), 2), round(max(second_list), 2), round(max(third_list), 2),
                  round(max(fourth_list), 2)]
        return result

    @staticmethod
    def minimum_time(temp_array):
        """ Get the minimum time of the function """
        first_list = []
        second_list = []
        third_list = []
        fourth_list = []
        count = len(temp_array) / 4
        for index in range(0, int(count)):
            first_list.append(temp_array[index * 3])
            second_list.append(temp_array[index * 3 + 1])
            third_list.append(temp_array[index * 3 + 2])
            fourth_list.append(temp_array[index * 3 + 3])
        result = [round(min(first_list), 2), round(min(second_list), 2), round(min(third_list), 2),
                  round(min(fourth_list), 2)]
        return result
