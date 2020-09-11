*** Settings ***
Documentation    Test suite of apple pay
Resource    ../../init.robot

Force Tags    PaymentGateway - Apple Pay - Apple Pay
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Apple pay with all empty
    ${resp} =    Apple Pay    ${EMPTY}    bank_code=${EMPTY}    pay_target=${EMPTY}    version=${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Apple pay with auth only
    ${resp} =    Apple Pay    ${auth}    bank_code=${EMPTY}    pay_target=${EMPTY}    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameter OrderNo

Apple pay given order_no
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    bank_code=${EMPTY}    pay_target=${EMPTY}    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter amount

Apple pay given incorrect order_no
    ${resp} =    Apple Pay    ${auth}    order_no=wrong    bank_code=${EMPTY}    pay_target=${EMPTY}    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: wrong Invalid parameter amount

Apple pay given order_no, amt
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    amt=109100.00    bank_code=${EMPTY}    pay_target=${EMPTY}    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter data

Apple pay given order_no, incorrect amt
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    amt=wrong    bank_code=${EMPTY}    pay_target=${EMPTY}    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter data

Apple pay given order_no, amt, bank_code
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    amt=109100.00    pay_target=${EMPTY}    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter data

Apple pay given order_no, amt, incorrect bank_code
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    amt=109100.00    bank_code=wrong    pay_target=${EMPTY}    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter data

Apple pay given order_no, amt, bank_code, pay_target
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    amt=109100.00    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter data

Apple pay given order_no, amt, bank_code, incorrect pay_target
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    amt=109100.00    pay_target=wrong    version=${EMPTY}
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter data

Apple pay given order_no, amt, bank_code, pay_target, version
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    amt=109100.00
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter data

Apple pay given order_no, amt, bank_code, pay_target, incorrect version
    ${resp} =    Apple Pay    ${auth}    order_no=${dms_order_no}    amt=109100.00    version=wrong
    Verify Schema    apple_pay.json    getApplePay    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] orderNo: ${dms_order_no} Invalid parameter data

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    Set Suite Variable    ${auth}
    Set Suite Variable    ${dms_order_no}    P095683132