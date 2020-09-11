*** Settings ***
Documentation    Test suite of the write off by virtual account write off
Resource    ../../init.robot

Force Tags    PaymentGateway - ATM - VA Write Off
Suite Setup    Suite Setup
Test Setup    Generate ES Bill And TRNACTNO
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Virtual account write off - empty - without all informations
    ${resp} =    VA Write Off    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid TransactionNo
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - empty - without AMT
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${EMPTY}    ${trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid AMT
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - empty - without SDATE
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${EMPTY}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid sDate
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - empty - without SIGN
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid paymentChannel
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - empty - without TDATE
    ${resp} =    VA Write Off    ${transaction_no}    ${EMPTY}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid TDATE
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - empty - without TIME
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${EMPTY}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid sTime
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - empty - without TransactionNo
    ${resp} =    VA Write Off    ${EMPTY}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid TransactionNo
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - empty - without TRNACTNO
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${EMPTY}    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid TRNACTNO
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - empty - without TXNCODE
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${EMPTY}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid paymentChannel
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - invalid - with incorrect AMT: integer type
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${incorrect_amt}    ${trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid AMT
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - invalid - with incorrect SDATE: %Y%m%d%H
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${incorrect_s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid sDate
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - invalid - with incorrect SIGN: negative sign
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${negative_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    data/amount should be >= 1
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - invalid - with incorrect TDATE: %Y%m%d%H
    ${resp} =    VA Write Off    ${transaction_no}    ${incorrect_t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid TDATE
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - invalid - with incorrect TIME: %H%M%S%f
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${incorrect_time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid sTime
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - invalid - with incorrect TransactionNo: higher then maxLength
    ${resp} =    VA Write Off    ${incorrect_transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Invalid TransactionNo
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - invalid - with incorrect TRNACTNO: non-exist TRNACTNO
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${incorrect_trnact_no}    ${s_date}    ${time}    ${atm_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    0
    Should Be Equal As Strings    ${resp.json()['Message']}    Internal Server Error: no bills found
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    543

Virtual account write off - valid - with correct information: ATM TXNCODE
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${rem_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    1
    Should Be Equal As Strings    ${resp.json()['Message']}    success
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    200

Virtual account write off - valid - with correct information: OTC TXNCODE
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${otc_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    1
    Should Be Equal As Strings    ${resp.json()['Message']}    success
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    200

Virtual account write off - valid - with correct information: REM TXNCODE
    ${resp} =    VA Write Off    ${transaction_no}    ${t_date}    ${amt}    ${trnact_no}    ${s_date}    ${time}    ${rem_txn_code}    ${positive_sign}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Result']}    1
    Should Be Equal As Strings    ${resp.json()['Message']}    success
    Should Be Equal As Strings    ${resp.json()['StatusCode']}    200

*** Keywords ***
Generate ES Bill And TRNACTNO
    ${transaction_prefix} =    Generate Random String    21    [NUMBERS]
    ${incorrect_transaction_prefix} =    Generate Random String    22    [NUMBERS]
    ${s_date} =    Get Current Date    increment=-1 days    result_format=%Y%m%d
    Payment Gateway Test Data Setup    1
    ${es_bill_info} =    Get ES Bill Info
    Set Test Variable    ${s_date}
    Set Test Variable    ${transaction_no}    A${transaction_prefix}${s_date}000001TB
    Set Test Variable    ${incorrect_transaction_no}    A${incorrect_transaction_prefix}${s_date}000001TB
    Set Test Variable    ${trnact_no}    ${es_bill_info['store_barcode2']}

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${t_date} =    Get Current Date    result_format=%Y%m%d
    ${incorrect_t_date} =    Get Current Date    result_format=%Y%m%d%H
    ${incorrect_s_date} =    Get Current Date    increment=-1 days    result_format=%Y%m%d%H
    ${time} =    Get Current Date    result_format=%H%M%S
    ${incorrect_time} =    Get Current Date    result_format=%H%M%S%f
    ${incorrect_amt} =    Convert To Integer    60
    ${incorrect_trnact_no} =    Generate Random String    16    [NUMBERS]
    Set Suite Variable    ${auth}
    Set Suite Variable    ${t_date}
    Set Suite Variable    ${incorrect_t_date}
    Set Suite Variable    ${incorrect_s_date}
    Set Suite Variable    ${amt}    60
    Set Suite Variable    ${incorrect_amt}
    Set Suite Variable    ${incorrect_trnact_no}
    Set Suite Variable    ${time}
    Set Suite Variable    ${incorrect_time}
    Set Suite Variable    ${otc_txn_code}    OTC
    Set Suite Variable    ${rem_txn_code}    REM
    Set Suite Variable    ${atm_txn_code}    ATM
    Set Suite Variable    ${negative_sign}    -
    Set Suite Variable    ${positive_sign}    +
