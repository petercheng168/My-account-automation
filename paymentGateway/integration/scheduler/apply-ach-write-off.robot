*** Settings ***
Documentation    Test suite of send ACH request to FTP
Resource    ../../init.robot

Force Tags    PaymentGateway - Scheduler - Apply ACH Writeoff
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Apply ACH write-off - valid - with correct information
    ${resp} =    Apply ACH Write Off    ${auth}
    Verify Schema    scheduler.json    applyACHWriteOff    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['code']}    0
    Should Be Equal As Strings    ${resp.json()['message']}     ACH writeoff apply success

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${account_num} =    Generate Random String    10    [NUMBERS]
    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    Payment Gateway Test Data Setup    2    5    new_user
    Add Wallets    ${user_id}    1    9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0    ${0}    TWD    ${auth}
    Add Automated Clearing Houses    ${user_id}    ${User.first_name}    ${account_num}    8120000    ${User.profile_id}A
    ...    ${User.profile_id}    ${transaction_id}    3    ${auth}
    Set Suite Variable    ${auth}