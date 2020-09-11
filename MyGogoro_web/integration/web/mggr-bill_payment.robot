*** Settings ***
Documentation    Test suite of receive the transaction result by credit card
Resource    ../../init.robot

Force Tags    PaymentGateway - External - Credit Card Transaction Charges Received
Suite Setup    Suite Setup
Test Setup    Init Bill Info
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Credit card transaction charges received - valid - with partial pay
    Credit Card Transaction Charges Received    ${var}    ${mid}    ${tid}    ${pay_type}    ${tx_type}
    ...    ${ret_code}    ${ret_msg}    ${partical_order_no_1}    ${auth_id_resp}    ${rrn}    ${order_status}
    ...    ${purchase_date}    ${partical_tx_amt_1}    ${first_6_digit_of_pan}    ${last_4_digit_of_pan}
    ${resp} =    Credit Card Transaction Charges Received    ${var}    ${mid}    ${tid}    ${pay_type}    ${tx_type}
    ...    ${ret_code}    ${ret_msg}    ${partical_order_no_2}    ${auth_id_resp}    ${rrn}    ${order_status}
    ...    ${purchase_date}    ${partical_tx_amt_2}    ${first_6_digit_of_pan}    ${last_4_digit_of_pan}
    Verify Schema    external.json    creditCardTransactionChargesReceived    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    success

Credit card transaction charges received - valid - with total pay
    ${resp} =    Credit Card Transaction Charges Received    ${var}    ${mid}    ${tid}    ${pay_type}    ${tx_type}
    ...    ${ret_code}    ${ret_msg}    ${order_no}    ${auth_id_resp}    ${rrn}    ${order_status}    ${purchase_date}
    ...    ${tx_amt}    ${first_6_digit_of_pan}    ${last_4_digit_of_pan}
    Verify Schema    external.json    creditCardTransactionChargesReceived    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    success

*** Keywords ***
Init Bill Info
    Payment Gateway Test Data Setup    1    5    new_user
    ${es_bill_info} =    Get ES Bill Info
    Set Test Variable    ${order_no}    2103_${es_bill_info['es_bill_id']}_${random_string}
    Set Test Variable    ${partical_order_no_1}    2103_${es_bill_info['es_bill_id']}_${random_string_1}
    Set Test Variable    ${partical_order_no_2}    2103_${es_bill_info['es_bill_id']}_${random_string_2}

Suite Setup
    ${random_string} =    Generate Random String    3    [NUMBERS][LETTERS]
    ${random_string_1} =    Generate Random String    3    [NUMBERS][LETTERS]
    ${random_string_2} =    Generate Random String    3    [NUMBERS][LETTERS]
    ${date} =    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Set Suite Variable    ${random_string}
    Set Suite Variable    ${random_string_1}
    Set Suite Variable    ${random_string_2}
    Set Suite Variable    ${var}    1.0.0
    Set Suite Variable    ${mid}    999812666555029
    Set Suite Variable    ${tid}    T0000000
    Set Suite Variable    ${pay_type}    ${1}
    Set Suite Variable    ${tx_type}    ${1}
    Set Suite Variable    ${ret_code}    00
    Set Suite Variable    ${ret_msg}    交易成功
    Set Suite Variable    ${auth_id_resp}    123456
    Set Suite Variable    ${rrn}    123456789012
    Set Suite Variable    ${order_status}    03
    Set Suite Variable    ${purchase_date}    ${date}
    Set Suite Variable    ${tx_amt}    6000
    Set Suite Variable    ${partical_tx_amt_1}    1000
    Set Suite Variable    ${partical_tx_amt_2}    5000
    Set Suite Variable    ${first_6_digit_of_pan}    414763
    Set Suite Variable    ${last_4_digit_of_pan}    0306