*** Settings ***
Documentation    Test suite of apple pay
Resource    ../../init.robot

Force Tags    PaymentGateway - Apple Pay - Apple Pay Refund
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Apple pay refund with all empty
    ${resp} =    Apple Pay Refund    ${EMPTY}    ${EMPTY}    bankCode=${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Apple pay refund with incorrect auth
    ${resp} =    Apple Pay Refund    ${dms_order_no}    wrong    bankCode=${bank_code}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Apple pay refund without bank code
    ${resp} =    Apple Pay Refund    ${dms_order_no}    ${auth}    bankCode=${EMPTY}
    Verify Schema    apple_pay.json    getApplePayRefund    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameter payTarget

Apple pay refund without order number
    ${resp} =    Apple Pay Refund    ${EMPTY}    ${auth}    bankCode=${bank_code}
    Verify Schema    apple_pay.json    getApplePayRefund    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameter payTarget

Apple pay refund with incorrect bank_code
    ${resp} =    Apple Pay Refund    ${dms_order_no}    ${auth}    bankCode=${incorrect_bank_code}
    Verify Schema    apple_pay.json    getApplePayRefund    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameter payTarget

Apple pay refund with incorrect order number
    ${resp} =    Apple Pay Refund    ${incorrect_dms_order_no}    ${auth}     bankCode=${bank_code}
    Verify Schema    apple_pay.json    getApplePayRefund    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameter payTarget

# It should not show error in this case
Apple pay refund
    ${resp} =    Apple Pay Refund    ${dms_order_no}    ${auth}    bankCode=${bank_code}
    Verify Schema    apple_pay.json    getApplePayRefund    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameter payTarget

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${incorrect_bank_code} =    Generate Random String    3    [NUMBERS]
    ${incorrect_dms_order_no} =    Generate Random String    10    [NUMBERS][LETTERS]
    Set Suite Variable    ${auth}
    Set Suite Variable    ${bank_code}    812
    Set Suite Variable    ${incorrect_bank_code}
    Set Suite Variable    ${dms_order_no}    P095683132
    Set Suite Variable    ${incorrect_dms_order_no}