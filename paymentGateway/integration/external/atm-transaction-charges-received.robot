*** Settings ***
Documentation    Test suite of receive the transaction result by ATM
Resource    ../../init.robot

Force Tags    PaymentGateway - External - ATM Transaction Charges Received
Suite Setup    Suite Setup
Test Setup    Generate ES Bill And TRNACTNO
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
ATM transaction charges received - valid - with partial pay
    Atm Transaction Charges Received    ${partical_transaction_no_1}    ${t_date}    ${partical_amt_1}    ${trnact_no}
    ...    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    ${resp} =    Atm Transaction Charges Received    ${partical_transaction_no_2}    ${t_date}    ${partical_amt_2}    ${trnact_no}
    ...    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Verify Schema    external.json    atmTransactionChargesReceived    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    1
    Should Contain    ${resp.json()['Message']}    success

ATM transaction charges received - valid - with total pay
    ${resp} =    Atm Transaction Charges Received    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}
    ...    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Verify Schema    external.json    atmTransactionChargesReceived    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    1
    Should Contain    ${resp.json()['Message']}    success

*** Keywords ***
Generate ES Bill And TRNACTNO
    ${transaction_prefix} =    Generate Random String    21    [NUMBERS]
    ${s_date} =    Get Current Date    increment=-1 days    result_format=%Y%m%d
    Payment Gateway Test Data Setup    1    5    new_user
    ${es_bill_info} =    Get ES Bill Info
    Set Test Variable    ${s_date}
    Set Test Variable    ${transaction_no}    A${transaction_prefix}${s_date}000001TB
    Set Test Variable    ${partical_transaction_no_1}    A${transaction_prefix}${s_date}000002TB
    Set Test Variable    ${partical_transaction_no_2}    A${transaction_prefix}${s_date}000003TB
    Set Test Variable    ${trnact_no}    ${es_bill_info['store_barcode2']}

Suite Setup
    ${t_date} =    Get Current Date    result_format=%Y%m%d
    ${time} =    Get Current Date    result_format=%H%M%S
    Set Suite Variable    ${t_date}
    Set Suite Variable    ${amt}    60
    Set Suite Variable    ${partical_amt_1}    10
    Set Suite Variable    ${partical_amt_2}    50
    Set Suite Variable    ${time}
    Set Suite Variable    ${atm_txn_code}    ATM
    Set Suite Variable    ${positive_sign}    +