*** Settings ***
Documentation    Test suite of user
Resource    ../init.robot

Force Tags    Users
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Create user with required field
    [Setup]    Setup User Variables
    ${resp} =    Users Post    ${company_code}    ${first_name}    ${gender}    ${email}    ${status}    ${enable_e_carrier}    gogoro_guid=${gogoro_guid}
    Verify Status Code As Expected    ${resp}    200
    Verify Schema    users.json    userCreate    ${resp.json()}

Get user with detailed information
    [Setup]    Create User
    ${resp} =    Users Get    ${user_Id}    2
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}    ${user_Id}
    Verify Schema    users.json    userGetDetail    ${resp.json()}

Get user with minimum PII
    [Setup]    Create User
    ${resp} =    Users Get    ${user_Id}    1
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}    ${user_Id}
    Verify Schema    users.json    userGetPII    ${resp.json()}

*** Keywords ***
Create User
    Setup User Variables
    ${resp} =    Users Post    ${company_code}    ${first_name}    ${gender}    ${email}    ${status}    ${enable_e_carrier}    gogoro_guid=${gogoro_guid}    password=${password}    login_phone=${login_phone}
    Set Test Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}

Setup User Variables
    ${first_name} =    Generate Random String    5    [UPPER][NUMBERS]
    ${password} =    Generate Random String    5    [NUMBERS]
    ${phone} =    Generate Random String    8    [NUMBERS]
    ${password} =    Encode Password    ${password}
    ${gogoro_guid} =    Generate Random UUID
    ${time} =    Evaluate    int(time.time() * 1000)    time
    Set Test Variable    ${time}
    Set Test Variable    ${login_phone}    09${phone}
    Set Test Variable    ${first_name}
    Set Test Variable    ${password}
    Set Test Variable    ${gogoro_guid}
    Set Test Variable    ${gender}    M
    Set Test Variable    ${email}    test+${time}+user@gogoro.com
    Set Test Variable    ${status}    1
    Set Test Variable    ${enable_e_carrier}    0

SuiteSetup
    Set Suite Variable    ${company_code}    1300