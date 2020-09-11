class RobotListener(object):
    ROBOT_LISTENER_API_VERSION = 2
    ROBOT_LIBRARY_SCOPE = "TEST SUITE"

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        self.keywords = []

    # this defines the "start keyword" listener method.
    # the leading underscore prevents it from being treated
    # as a keyword
    def _start_keyword(self, name, attrs):
        self.keywords.append(name)
        # if len(self.keywords) == 1:
        #     print("[" + self.keywords[0] + "]")

    def _end_keyword(self, name, attrs):
        self.keywords.pop()
