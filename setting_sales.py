import os

# Project root (application)
project_root = os.path.dirname(__file__)

common = {
    'BROWSER_LANGUAGE': 'zh_TW',
    'FRANCHISE_ACCOUNT': 'PT0012T',
    'SALES_ACCOUNT': 'QA00002',
    'SALES_PORTAL_ACCESSORY_PLATE': 'WDW-5778',
    'SALES_PORTAL_BUYER_EMAIL': 'sw.verify+1562750828@gogoro.com',
    'SALES_PORTAL_DRIVER_EMAIL': 'sw.verify+1562896307@gogoro.com',
    'SALES_PORTAL_FEMALE_BUYER_EMAIL': 'sw.verify+1566268692@gogoro.com',
    'SALES_PORTAL_GMAIL_SENDER': 'automated@gogoro.com',
    'SALES_PORTAL_LEGAL_ENTITY_EMAIL': 'order-system@gogoro.com',
    'SALES_PORTAL_OWNER_EMAIL': 'sw.verify+1562835706@gogoro.com',
    'SALES_PORTAL_SCOOTER_MODEL': 'Gogoro S2 Café Racer (MY19)',
    'SALES_PORTAL_WINDOW_HEIGHT': '1024',
    'SALES_PORTAL_WINDOW_WEIGHT': '768',
    # Transfer scooter information
    'SALES_PORTAL_TRANSFER_NEW_OWNER_ACCOUNT': 'sw.verify+1561532242@gogoro.com',
    'SALES_PORTAL_TRANSFER_NEW_OWNER_NAME': '綠豆沙',
    'SALES_PORTAL_TRANSFER_NEW_OWNER_PHONE': '4456',
    'SALES_PORTAL_TRANSFER_OLD_OWNER_ACCOUNT': 'sw.verify+1561516757@gogoro.com',
    'SALES_PORTAL_TRANSFER_OLD_OWNER_NAME': '陳龍馬',
    'SALES_PORTAL_TRANSFER_OLD_OWNER_PHONE': '5075',
    'SALES_PORTAL_TRANSFER_PROFILEID': 'A161751283'
}

dev = {
    'FRANCHISE_PASS': '123',
    'PAGE_CONTAINS_TIMEOUT': '30s',
    'SALES_BILLING_ACCOUNT': 'DEV86018',
    'SALES_BILLING_PASSWORD': '123',
    'SALES_PASSWORD': '123',
    'SALES_PORTAL_ADMIN_ACCOUNT': 'sw.verify+dev-gss.admin@gogoro.com',
    'SALES_PORTAL_API_URL': 'dev-sales.gogoro.com/tw',
    'SALES_PORTAL_BILLING_ADMIN_ACCOUNT': 'dev.sales_portal_billing_admin@gogoro.com',
    'SALES_PORTAL_DIRECT_URL': 'http://dev-sales.gogoro.com/tw/home?p=directlogin',
    'SALES_PORTAL_DMS_KEY_ONE': 'WgKz45uMxF7jQAYKR9H\/xhNMTvjFZPDc+Fg\/jbYno6lF7KUXJRUA',
    'SALES_PORTAL_DMS_KEY_TWO': 'aAD48PmMxF52LgRXO5m4I280XzH58PERCpdmsLt+Whc9cPYRfJAbK3d7Xq1jXkk3JA==',
    'SALES_PORTAL_GO_SUPPORT': 'http://10.0.1.169:8099/Account/Login',
    'SALES_PORTAL_MANAGER_ACCOUNT': 'sw.verify+dev-gss.manager@gogoro.com',
    'SALES_PORTAL_TRANSFER_PLATE': 'J73-SWQA',
    'SALES_PORTAL_TRANSFER_VIN': 'SWQAD6WVXUAWNWNCX',
    'SALES_PORTAL_URL': 'http://dev-sales.gogoro.com/tw',
    'SALES_PORTAL_USER_ACCOUNT': 'sw.verify+dev-gss.user@gogoro.com',
    'SCOOTER_AUTO_PAIRING_DEFAULT_ACCOUNT': 'QA00002',
    'SCOOTER_AUTO_PAIRING_PASSWORD': '123'
}

pa = {
    'FRANCHISE_PASS': 'Temp4321',
    'PAGE_CONTAINS_TIMEOUT': '20s',
    'SALES_BILLING_ACCOUNT': 'PA86020',
    'SALES_BILLING_PASSWORD': '123',
    'SALES_PASSWORD': 'Temp4321',
    'SALES_PORTAL_ADMIN_ACCOUNT': 'sw.verify+pa-gss.admin@gogoro.com',
    'SALES_PORTAL_API_URL': 'pa-sales.gogoro.com/tw',
    'SALES_PORTAL_BILLING_ADMIN_ACCOUNT': 'pa.sales_portal_billing_admin@gogoro.com',
    'SALES_PORTAL_DIRECT_URL': 'https://pa-sales.gogoro.com/tw/home?p=directlogin',
    'SALES_PORTAL_DMS_KEY_ONE': 'CgCujB6NxF4\/5BIKPecJo4yQL\/uuylr3NAu4HTp6JAFvDs9jGlcV',
    'SALES_PORTAL_DMS_KEY_TWO': 'KQElegqNxF61jHP8LTwDWhKhgXD8km7Fuy\/uboz\/jxAqqoWzgKTCQRS7H\/uqrqwicQ==',
    'SALES_PORTAL_GO_SUPPORT': 'http://10.0.1.179/Account/Login',
    'SALES_PORTAL_MANAGER_ACCOUNT': 'sw.verify+pa-gss.manager@gogoro.com',
    'SALES_PORTAL_TRANSFER_PLATE': 'FEC-SWQA',
    'SALES_PORTAL_TRANSFER_VIN': 'SWQAVE73BBTQN4TFK',
    'SALES_PORTAL_URL': 'https://pa-sales.gogoro.com/tw',
    'SALES_PORTAL_USER_ACCOUNT': 'sw.verify+pa-gss.user@gogoro.com',
    'SCOOTER_AUTO_PAIRING_DEFAULT_ACCOUNT': '10000733T',
    'SCOOTER_AUTO_PAIRING_PASSWORD': 'Temp4321'
}

prod = {
    'SALES_PORTAL_PROD_EMAIL': 'sw.devops@gogoro.com',
    'SALES_PORTAL_PROD_URL': 'https://sales.gogoro.com/tw/home?p=login',
    'SALES_PROD_ACCOUNT': 'sw.devops@gogoro.com',
    'SALES_PROD_PASS': 'Temp4321'
}

swqa = {
    'PAGE_CONTAINS_TIMEOUT': '30s',
    'SALES_PASSWORD': '123',
    'SALES_PORTAL_API_URL': 'dev-qa-sales.gogoro.com/tw',
    'SALES_PORTAL_DIRECT_URL': 'https://dev-qa-sales.gogoro.com/tw/home?p=directlogin',
    'SALES_PORTAL_DMS_KEY_ONE': 'WgKz45uMxF7jQAYKR9H\/xhNMTvjFZPDc+Fg\/jbYno6lF7KUXJRUA',
    'SALES_PORTAL_DMS_KEY_TWO': 'aAD48PmMxF52LgRXO5m4I280XzH58PERCpdmsLt+Whc9cPYRfJAbK3d7Xq1jXkk3JA==',
    'SALES_PORTAL_MANAGER_ACCOUNT': 'sw.verify+dev-gss.manager@gogoro.com',
    'SALES_PORTAL_URL': 'https://dev-qa-sales.gogoro.com/tw'
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
