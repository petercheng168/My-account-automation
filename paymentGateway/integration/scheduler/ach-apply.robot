*** Settings ***
Documentation    Test suite of send ACH application request to SFTP
Resource    ../../init.robot

Force Tags    PaymentGateway - Internal - ACH Apply
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
ACH apply - empty - without authorization token and userIds list
    ${resp} =    Ach Apply    ${empty_user_list}    ${EMPTY}
    Verify Schema    scheduler.json    achApply   ${resp.json()}    401
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.json()['error']['code']}    0
    Should Be Equal As Strings    ${resp.json()['error']['message']}     Unauthorized

ACH apply - empty - without authorization token
    ${resp} =    Ach Apply    ${user_list}    ${EMPTY}
    Verify Schema    scheduler.json    achApply   ${resp.json()}    401
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.json()['error']['code']}    0
    Should Be Equal As Strings    ${resp.json()['error']['message']}     Unauthorized

ACH apply - empty - without userIds list
    ${resp} =    Ach Apply    ${empty_user_list}    ${auth}
    Verify Schema    scheduler.json    achApply   ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['error']['code']}    0
    Should Be Equal As Strings    ${resp.json()['error']['message']}     Invalid userIds

ACH apply - invalid - without incorrect userIds list
    ${resp} =    Ach Apply    ${incorrect_user_list}    ${auth}
    Verify Schema    scheduler.json    achApply   ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['code']}    -1
    Should Be Equal As Strings    ${resp.json()['message']}     Did not find any Gobank ACH data which need to be applied

ACH apply - valid - with one user in userIds list
    ${resp} =    Ach Apply    ${user_list}    ${auth}
    Verify Schema    scheduler.json    achApply   ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['code']}    0
    Should Be Equal As Strings    ${resp.json()['message']}     ACH apply success

ACH apply - valid - with multiple user in userIds list
    [Setup]  Generate user list include multiple user
    ${resp} =    Ach Apply    ${multiple_user_list}    ${auth}
    Verify Schema    scheduler.json    achApply   ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['code']}    0
    Should Be Equal As Strings    ${resp.json()['message']}     ACH apply success

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${account_num} =    Generate Random String    10    [NUMBERS]
    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    Payment Gateway Test Data Setup    2    5    new_user
    Add Wallets    ${user_id}    1    9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0    ${0}    TWD    ${auth}
    Add Automated Clearing Houses    ${user_id}    ${User.first_name}    ${account_num}    8120000    ${User.profile_id}A
    ...    ${User.profile_id}    ${transaction_id}    3    ${auth}
    ${user_list}    Create List    ${user_id}
    ${incorrect_user_list}    Create List    m4wP3AEZ
    ${empty_user_list}    Create List
    Set Suite Variable    ${auth}
    Set Suite Variable    ${empty_user_list}
    Set Suite Variable    ${user_list}
    Set Suite Variable    ${incorrect_user_list}

Generate user list include multiple user
    ${multiple_user_list}    Create List
    :FOR    ${index}    IN RANGE    2
    \    ${account_num} =    Generate Random String    10    [NUMBERS]
    \    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    \    Payment Gateway Test Data Setup    2    5    new_user
    \    Add Wallets    ${user_id}    1    9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0    ${0}    TWD    ${auth}
    \    Add Automated Clearing Houses    ${user_id}    ${User.first_name}    ${account_num}    8120000    ${User.profile_id}A    ${User.profile_id}    ${transaction_id}    3    ${auth}
    \    Append To List    ${multiple_user_list}    ${user_id}
    Set Test Variable    ${multiple_user_list}
