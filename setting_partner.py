import os

# Project root (application)
project_root = os.path.dirname(__file__)

common = {
    'BROWSER_LANGUAGE': 'en_US',
    'PARTNET_PORTAL_WINDOW_HEIGHT': '1080',
    'PARTNET_PORTAL_WINDOW_WEIGHT': '1920',
    'PARTNER_DASHBOARD_SALES_ADMIN': 'sw.verify+partner_dashboard_sales_admin@gogoro.com',
    'PARTNER_PORTAL_PROCUREMENT_MANAGER': 'sw.verify+partner_portal_procurement_manager@gogoro.com',
    'PARTNER_PORTAL_PASSWORD': 'Temp4321',
    'PARTNER_DASHBOARD_POLO_URL': 'http://polo-partner-dashboard.devgogoro.com',
    'PARTNER_DASHBOARD_TW_URL': 'http://tw-partner-dashboard.devgogoro.com',
    'PARTNER_PORTAL_GSS_URL': 'http://gss-partner-portal.devgogoro.com',
    'PARTNER_PORTAL_GTW_URL': 'http://gtw-partner-portal.devgogoro.com',
    'PARTNER_PORTAL_RL_URL': 'http://rl-partner-portal.devgogoro.com',
    'PARTNER_PORTAL_RY_URL': 'http://ry-partner-portal.devgogoro.com',
}

dev = {}
pa = {}
prod = {}

# Variable for chose environment variable via python
env_variable = dev


def get_variables(env):
    if env == 'pa':
        pa.update(common)
        return pa
    elif env == 'prod':
        prod.update(common)
        return prod
    else:
        dev.update(common)
        return dev
