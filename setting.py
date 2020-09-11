import os

# Project root (application)
project_root = os.path.dirname(__file__)

common = {
    # Cipher variables
    'CIPHER_PASSWORD': '123',
    'CIPHER_HOST': '10.6.1.46',
    # DataPlatform variables
    'DATAPLATFORM_BASEPATH': '/go-platform/v1',
    # DataPlatform variables
    'DATAPLATFORM_GLOBAL_BASEPATH': '/go-platform-global-service/v1',
    # DMS variables
    'DMS_BASEPATH': '/bin/api/index.prg',
    # Gmail variables
    'GMAIL_ACCOUNT': 'sw.verify@gogoro.com',
    'GMAIL_PASSWORD': 'TeMP@v6789',
    # Other variables
    'API_TIMEOUT': 20,
    'DRIVER_PATH': os.getcwd(),
    # 'DRIVER_VERSION': "chromedriver_78",
    'SALT': "gogoro",
    'TEST_TIMEOUT': 300,
    'WINDOW_HEIGHT': '1080',
    'WINDOW_WEIGHT': '1920',
    # MY ACCOUNT variables
    'MY_ACCOUNT_URL': 'https://pa-network-my.gogoro.com',
    'MYGOGORO_GN_HOST': 'pa-network-my.gogoro.com',
    'MY_ACCOUNT_WINDOW_HEIGHT': '1080',
    'MY_ACCOUNT_WINDOW_WEIGHT': '1920',
    # MY ACCOUNT address
    'MY_ACCOUNT_ADDRESS_OLD': '臺北市松山區長安東路二段225號C棟11樓',
    'MY_ACCOUNT_ADDRESS_NEW': '基隆市仁愛區長安東路二段225號C棟11樓',
    # Other variables
    'TEST_TIMEOUT': 300,
    'BROWSER_PATH': os.getcwd(),
    'DRIVER_VERSION': "chromedriver_80",
    'CHANGE_PASSWORD_MAILBOX_URL': 'http://www.yopmail.com/zh/',
    'MOBILE_NUM': "0988168168",
}

pa = {
    # Cipher variables
    'CIPHER_GSS_ACCOUNT': 'pa.gss_admin@gogoro.com',
    'CIPHER_GEN_ACCOUNT': 'pa.gen_admin@gogoro.com',
    'CIPHER_SUPER_ACCOUNT': 'pa.gen_super_admin@gogoro.com',
    'CIPHER_PORT': '3032',
    'CIPHER_DEV': 'pa',
    'CIPHER_APP': 'pa',
    'CIPHER_RESOURCE': 'pa',
    'GO_CLIENT_HEADER': 'pa',
    # Evnironment variables
    'DATAPLATFORM_STG_HOST': 'pa-goplatform.gogoro.com',
    'DATAPLATFORM_STG_PORT': '443',
    'PROTOCOL': 'https',
    # MyGogoro variables
    'MYGOGORO_GN_HOST': 'pa-network-my.gogoro.com',
    'MYGOGORO_GN_DOMAIN': 'https://pa-network-my.gogoro.com/login?lang=zh-TW',
    'NEWMYGOGORO_PA_DOMAIN': 'https://pa-uat-network-my.gogoro.com',
    'NEWMYGOGORO_PA_HOST': 'pa-uat-network-my.gogoro.com',
    'MYGOGORO_GSS_HOST': 'pa-my.gogoro.com',
    'MYGOGORO_ACCOUNT': 'gogopasw008_2020-1@yopmail.com',
    'MYGOGORO_ACCOUNT3': 'tim.wu@gogoro.com',
    'PASSWORD1' : 'Gogoro888',
    'PASSWORD2' : 'Gogoro321',
    'PASSWORD3' : 'Ggr12345',
    'PASSWORD3_ENCODE' : 'WPlCaSyY2KvitLeebxPQN0FYj1rKcFrSxxuX9uVrgyjIK5/v8DVbRewyhCxSNUIFpJtXyuEYjyKdMrlvjga6Wg==',
    'FORGOT_PASSWORD_ACCOUNT': 'gogopasw008_2020-1@yopmail.com',
    'FORGOT_PASSWORD_INVALID_ACCOUNT': '3939889@gmail.com',
    'CHANGE_ACCOUNT_EMAIL': 'gogopasw001+9999@gmail.com',       #gmail
    'CHANGE_ACCOUNT_Y_EMAIL': 'pasw007@yopmail.com',       #yopmail
    'CHANGE_INVALID_ACCOUNT_EMAIL': 'gogopasw001gmail.com',
    'ACCOUNT_IN_MAILBOX': 'pasw007',
    'ACCOUNT_IN_GMAIL': 'gogopasw001',
    'ACCOUNT_IN_GMAIL_PASSWORD': 'gogoro520',
    'NEW_PASSWORD': 'Gogoro520',
    'FIRST_NAME_CHANGE_ONE': '亞瑟士',
    'FIRST_NAME_CHANGE_TWO': '亞瑟',
    'LAST_NAME_CHANGE_ONE': '土',
    'LAST_NAME_CHANGE_TWO': '王',
    'ONE_BATTERY_USER_NAME': 'SWQA',
    'DISPLAY_NAME_CHANGE_ONE': 'Go亞瑟',
    'DISPLAY_NAME_CHANGE_TWO': '亞瑟Go',
    # Test source
    'VM_GUID': '8E3CEE90-8E87-4681-B519-015151219605',
    'GO_BANK_URL': 'https://pa-gowallet.gogoro.com',
    'BILLING_SCHEDULER_URL': 'https://pa-billing2-scheduler-internal.gogoro.com',
    'PAYMENT_GATEWAY_URL': 'https://pg-test.gogoro.com',
    'LOWER': 'qwertyuiopasdfghjklzxcvbnm', 
    'UPPER': 'QWERTYUIOPASDFGHJKLZXCVBNM',
    'NUMBERS': '1234567890',
    'LETTERS': 'LOWER&UPPER'
    

}


su = {

}

# Variable for chose environment variable via python
env_variable = su


def get_variables(env):
    if env == 'pa':
        pa.update(common)
        return pa
    else:
        su.update(common)
        return su
