import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../'))
from setting import *
from robot.libraries.BuiltIn import BuiltIn
from robot.running.context import EXECUTION_CONTEXTS as contexts


class LibVar(object):

    def __init__(self):
        self.BuiltIn = BuiltIn()
        self.robot_status = True if contexts.current else False

    def get_var(self, variable):
        var = None
        if self.robot_status:
            try:
                var = self.BuiltIn.get_variable_value('${}'.format(variable))
            except:
                print('import BuiltIn failed')
        else:
            if variable in common.keys():
                var = common['{}'.format(variable)]
            else:
                var = env_variable['{}'.format(variable)]
        return var
