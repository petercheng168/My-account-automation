# -*- coding: utf-8 -*-
import logging
import coloredlogs


def set_logger(mod_name):

    level_style = dict(
        debug=dict(color='magenta'),
        info=dict(color='green'),
        warning=dict(color='blue'),
        error=dict(color='red'),
        critical=dict(color='red', bold=True))

    coloredlogs.install(level=logging.INFO, fmt='\n%(asctime)s - %(filename)s - %(message)s',
                        level_styles=level_style, isatty=True)
    logger = logging.getLogger(mod_name)

    return logger
