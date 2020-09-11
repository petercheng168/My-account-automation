*** Settings ***
Documentation    Test suite of auto payment with credit card
Resource    ../../init.robot

Force Tags    PaymentGateway - Scheduler - Auto Pay Credit Card
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Auto pay credit card - valid - with correct information
    ${resp} =    Auto Pay Credit Card    ${auth}
    Verify Schema    scheduler.json    autoPayCreditCard    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['code']}    0
    Should Be Equal As Strings    ${resp.json()['message']}    Send auto pay credit card request success, chargeRes: {"code":0,"data":[{"code":1,"resultCode":0,"resultMessage":"Success"}]}

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    Payment Gateway Test Data Setup    3    0    exist_user
    Set Suite Variable    ${auth}