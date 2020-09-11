*** Settings ***
Documentation    Test suite of apply ach from bank for an es-bill which has es_contract_autopay_config
Resource    ../../init.robot

Force Tags    PaymentGateway - ACH - ACH Writeoff Apply
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Ach writeoff apply - empty - without authorization token and informations: applyDate and billDuedate
    ${resp} =    Ach Writeoff Apply    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Ach writeoff apply - empty - without authorization token
    ${resp} =    Ach Writeoff Apply    ${Bill.from_time}    ${Bill.to_time}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Ach writeoff apply - empty - without applyDate
    ${resp} =    Ach Writeoff Apply    ${EMPTY}    ${Bill.to_time}    ${auth}
    Verify Schema    ach.json    achWriteOffApply    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    Invalid applyDate

Ach writeoff apply - empty - without billDuedate
    ${resp} =    Ach Writeoff Apply    ${Bill.from_time}    ${EMPTY}    ${auth}
    Verify Schema    ach.json    achWriteOffApply    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    Invalid billDuedate
    
Ach writeoff apply - invalid - with incorrect applyDate -1: generate 19700101 file
    ${resp} =    Ach Writeoff Apply    -1    ${Bill.to_time}    ${auth}
    Wait Until Keyword Succeeds    10sec    5sec    Get Logs    Upload fileName: ACHP01_904_54387162_${unix_time_start}_1.ZIP successfully
    Verify Schema    ach.json    achWriteOffApply    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}     ACH writeoff apply success

Ach writeoff apply - invalid - with incorrect billDuedate
    ${resp} =    Ach Writeoff Apply    ${Bill.from_time}    0    ${auth}
    Verify Schema    ach.json    achWriteOffApply    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    There is no duedate bill in time 0 to pay

Ach writeoff apply - valid - with correct information
    ${resp} =    Ach Writeoff Apply    ${Bill.from_time}    ${Bill.to_time}    ${auth}
    Wait Until Keyword Succeeds    10sec    5sec    Get Logs    Upload fileName: ACHP01_904_54387162_${file_date}_1.ZIP successfully
    Verify Schema    ach.json    achWriteOffApply    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    ACH writeoff apply success

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${account_num} =    Generate Random String    10    [NUMBERS]
    Payment Gateway Test Data Setup    2
    Es Contract Autopay Config Post    ${es_contract_id}    ${User.first_name}    ${account_num}    8120023    ${User.profile_id}    3
    ${file_date} =    Evaluate    datetime.datetime.fromtimestamp(${Bill.from_time}).strftime('%Y%m%d')    datetime
    Set Suite Variable    ${auth}
    Set Suite Variable    ${unix_time_start}    19700101
    Set Suite Variable    ${file_date}
