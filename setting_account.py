import os

# Project root (application)
project_root = os.path.dirname(__file__)

common = {
    'BROWSER_LANGUAGE': 'en_US',
    'ACCOUNT_DASHBOARD_WINDOW_HEIGHT': '1080',
    'ACCOUNT_DASHBOARD_WINDOW_WEIGHT': '1920',
    'ACCOUNT_DASHBOARD_SUPER_ADMIN_EMAIL': 'dev.account_dashboard_super_admin@gogoro.com',
    'ACCOUNT_DASHBOARD_GROUP_ADMIN_EMAIL': 'dev.account_dashboard_group_admin@gogoro.com',
    'ACCOUNT_DASHBOARD_ADMIN_EMAIL': 'dev.account_dashboard_admin@gogoro.com',
    'ACCOUNT_DASHBOARD_MANAGER_EMAIL': 'dev.account_dashboard_manager@gogoro.com',
    'ACCOUNT_DASHBOARD_USER_EMAIL': 'dev.account_dashboard_user@gogoro.com',
    'ACCOUNT_DASHBOARD_ADMIN_PASSWORD': '123',
    'ACCOUNT_DASHBOARD_OTHER_PASSWORD': 'Temp4321'
}

dev = {
    'ACCOUNT_DASHBOARD_GDK_ADMIN_EMAIL': 'sw.verify+qa_pgo_admin@gogoro.com',
    'ACCOUNT_DASHBOARD_GDK_MANAGER_EMAIL': 'sw.verify+qa_pgo_manager@gogoro.com',
    'ACCOUNT_DASHBOARD_GEN_ADMIN_EMAIL': 'sw.verify+qa_gen_admin@gogoro.com',
    'ACCOUNT_DASHBOARD_GEN_MANAGER_EMAIL': 'sw.verify+qa_gen_manager@gogoro.com',
    'ACCOUNT_DASHBOARD_GSS_ADMIN_EMAIL': 'sw.verify+qa_gss_admin@gogoro.com',
    'ACCOUNT_DASHBOARD_GSS_MANAGER_EMAIL': 'sw.verify+qa_gss_manager@gogoro.com',
    'ACCOUNT_DASHBOARD_URL': 'http://qa-account-dashboard.devgogoro.com'
}
pa = {}
prod = {}
swqa = {
    'ACCOUNT_DASHBOARD_URL': 'http://swqa-account-dashboard.devgogoro.com'
}

# Variable for chose environment variable via python
env_variable = dev


def get_variables(env):
    if env == 'pa':
        pa.update(common)
        return pa
    elif env == 'prod':
        prod.update(common)
        return prod
    elif env == 'swqa':
        swqa.update(common)
        return swqa
    else:
        dev.update(common)
        return dev
