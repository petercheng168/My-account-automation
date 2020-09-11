*** Settings ***
Documentation    API baseline of ACH.

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GB_API_ROOT}/LibWalletsAutomatedClearingHouses.py

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GB_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot

Force Tags      ACH
Suite Setup     Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${user_id}          8RAowkWm
${bank_code}        8120000
${account_name}     SWQA
${account_num}      SWQA_lnaqo98d0n
${wallet_ach_id}    jrLOPvRO

*** Test Cases ***
wallets-automated-clearing-houses - add - valid - create ach with valid status
    [Template]    Verify ACH Add With Valid Fields
    status=0
    status=1
    status=2
    status=3
    status=4
    status=5

wallets-automated-clearing-houses - add - invalid - create ach with invalid status
    [Tags]    FET
    [Template]    Verify ACH Add With Invalid Fields
    6    addData[0].status must not be null    user_id=${user_id}    account_name=${account_name}    account_num=${account_num}    bank_code=${bank_code}    account_owner_profile_id=${EMPTY}    application_date=0    effective_date=${timestamp}    status=${None}
    6    addData[0].status must not be null    user_id=${user_id}    account_name=${account_name}    account_num=${account_num}    bank_code=${bank_code}    account_owner_profile_id=${EMPTY}    application_date=0    effective_date=${timestamp}    status=6

wallets-automated-clearing-houses - update - valid - update ach with valid status
    [Tags]    CID:C4990
    [Template]    Verify ACH Update With Valid Fields
    status=0
    status=1
    status=2
    status=3
    status=4
    status=5

wallets-automated-clearing-houses - update - invalid - update ach with invalid status
    [Tags]    FET    CID:C4996
    [Template]    Verify ACH Update With Invalid Fields
    6    updateData[0].status must not be null    user_id=${user_id}    wallet_ach_id=${wallet_ach_id}    account_name=${account_name}    account_num=${account_num}    bank_code=${bank_code}    account_owner_profile_id=${EMPTY}    application_date=0    effective_date=${timestamp}    status=${None}
    6    updateData[0].status must not be null    user_id=${user_id}    wallet_ach_id=${wallet_ach_id}    account_name=${account_name}    account_num=${account_num}    bank_code=${bank_code}    account_owner_profile_id=${EMPTY}    application_date=0    effective_date=${timestamp}    status=${None}

*** Keywords ***
Suite Setup
    ${timestamp} =    Evaluate    int(time.time())   time
    ${furture_timestamp} =    Evaluate    int(time.time() + 86400)   time
	Set Suite Variable    ${timestamp}
	Set Suite Variable    ${furture_timestamp}

Test Setup
    ${account_num} =    Generate Random String    8    [STRINGS]
    ${account_num} =    Set Variable    SWQA_${account_num}
    Set Test Variable    ${account_num}

Verify ACH Add With Valid Fields
    [Arguments]    &{fields}
    Test Setup
    Wallets Automated Clearing Houses Add
    ...    user_id=${user_id}                   account_name=${account_name}
    ...    account_num=${account_num}           bank_code=${bank_code}
    ...    account_owner_profile_id=${EMPTY}    application_date=0
    ...    effective_date=${timestamp}
    ...    &{fields}

Verify ACH Add With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    Test Setup
    ${resp} =    Wallets Automated Clearing Houses Add    &{fields}
    Verify Status Code As Expected    ${resp}    400
    Verify GoBank Error Message       ${resp}    ${additional_code}    ${err_msg}

Verify ACH Update With Valid Fields
    [Arguments]    &{fields}
    Wallets Automated Clearing Houses Update
    ...    user_id=${user_id}              wallet_ach_id=${wallet_ach_id}
    ...    account_name=${account_name}    account_num=${account_num}
    ...    bank_code=${bank_code}          account_owner_profile_id=${EMPTY}
    ...    application_date=0
    ...    effective_date=${timestamp}
    ...    &{fields}

Verify ACH Update With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    Test Setup
    ${resp} =    Wallets Automated Clearing Houses Update    &{fields}
    Verify Status Code As Expected    ${resp}    400
    Verify GoBank Error Message       ${resp}    ${additional_code}    ${err_msg}