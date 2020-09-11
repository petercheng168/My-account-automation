import os

# Project root (application)
project_root = os.path.dirname(__file__)

common = {
    'EXTERNAL_BANK_URL': 'https://apposweb-t.taishinbank.com.tw',
    'PAYMENT_GATEWAY_MEMBER_ID': '74132',
    'PAYMENT_GATEWAY_WALLET_ID': '32',
    'PAYMENT_GATEWAY_CHECK_MEMBER_ID': '74122',
    'PAYMENT_GATEWAY_CHECK_WALLET_ID': '31',
    'PAYMENT_GATEWAY_API_KEY': 'UCESKU2WOFADFT302XZVALQE3RYGTKQY',
    'PAYMENT_GATEWAY_SCHEMA_PATH': os.path.join(project_root, 'paymentGateway', 'res', 'schema'),
    'PAYMENT_GATEWAY_LOCAL_STORAGE': os.path.join(project_root, 'paymentGateway', 'local_storage'),
    'PAYMENT_GATEWAY_CALENDER': os.path.join(project_root, 'paymentGateway', 'res', 'calender.json'),
    'PAYMENT_GATEWAY_ONE_TIME_NUMBER': '3565580700005806',
    'PAYMENT_GATEWAY_ONE_TIME_EXPIRED_DATE': '4112',
    'PAYMENT_GATEWAY_ONE_TIME_CVV2': '241',
    'PAYMENT_GATEWAY_PHONE_NUMBER': '0932987189',
    'PAYMENT_GATEWAY_CARD_NAME': '台新國際商業銀行',
    'PAYMENT_GATEWAY_BANK_CODE': '812',
    'PAYMENT_GATEWAY_ACCOUNT': 'sw.verify+pg_true@gogoro.com',
    'PAYMENT_GATEWAY_GUID': 'ad2dcb95-8027-428c-ae93-4b57595c0bf8',
    'LOG_SERVER_HOST': '10.6.1.58',
    'LOG_SERVER_ACCOUNT': 'rootadmin',
    'LOG_SERVER_PASSWORD': 'Temp@6789',
}

dev = {
    'GO_BANK_URL': 'http://10.6.1.43:8080',
    'BILLING_SCHEDULER_URL': 'http://10.6.1.44:6060',
    'PAYMENT_GATEWAY_CREDIT_CARD_NUMBER': '4050588100006902',
    'PAYMENT_GATEWAY_CREDIT_CARD_EXPIRED_DATE': '2508',
    'PAYMENT_GATEWAY_CREDIT_CARD_CVV2': '837',
    'PAYMENT_GATEWAY_URL': 'https://dev-pg.gogoro.com:3030',
    'PAYMENT_GATEWAY_SFTP_ADDRESS': '10.6.1.35',
    'PAYMENT_GATEWAY_SFTP_ACCOUNT': 'rootadmin',
    'PAYMENT_GATEWAY_SFTP_PASSWORD': 'gogorotest',
    'DEFAULT_USER_ID': '6mQWlnWR',
    'SFTP_HOME_ROOT': '/home/rootadmin'
}

pa = {
    'GO_BANK_URL': 'https://pa-gowallet.gogoro.com',
    'BILLING_SCHEDULER_URL': 'https://pa-billing2-scheduler-internal.gogoro.com',
    'PAYMENT_GATEWAY_CREDIT_CARD_NUMBER': '4050588100006902',
    'PAYMENT_GATEWAY_CREDIT_CARD_EXPIRED_DATE': '2508',
    'PAYMENT_GATEWAY_CREDIT_CARD_CVV2': '837',
    'PAYMENT_GATEWAY_URL': 'https://pg-test.gogoro.com',
    'PAYMENT_GATEWAY_SFTP_ADDRESS': '10.6.1.35',
    'PAYMENT_GATEWAY_SFTP_ACCOUNT': 'rootadmin',
    'PAYMENT_GATEWAY_SFTP_PASSWORD': 'gogorotest',
    'DEFAULT_USER_ID': 'XmlOE9N4',
    'SFTP_HOME_ROOT': '/home/rootadmin'
}

prod = {}

swqa = {
    'GO_BANK_URL': 'http://10.6.210.73:8080',
    'BILLING_SCHEDULER_URL': 'http://10.6.1.44:6061',
    'PAYMENT_GATEWAY_CREDIT_CARD_NUMBER': '4050588100006308',
    'PAYMENT_GATEWAY_CREDIT_CARD_EXPIRED_DATE': '2508',
    'PAYMENT_GATEWAY_CREDIT_CARD_CVV2': '115',
    'PAYMENT_GATEWAY_URL': 'http://10.6.1.58:3001',
    'PAYMENT_GATEWAY_SFTP_ADDRESS': '10.6.1.194',
    'PAYMENT_GATEWAY_SFTP_ACCOUNT': 'root',
    'PAYMENT_GATEWAY_SFTP_PASSWORD': 'Temp4321',
    'DEFAULT_USER_ID': 'VNWDg5mZ',
    'SFTP_HOME_ROOT': '/root'
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
