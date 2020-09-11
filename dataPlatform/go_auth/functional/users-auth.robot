*** Settings ***
Documentation    API baseline of Users Auth.

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GA_API_ROOT}/LibUsersAuth.py
Library           ${GA_LIB_ROOT}/LibJSONSchema.py
Resource          ${DP_ROOT}/standard_library_init.robot
Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GA_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot

Force Tags      Auth
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${user_email}               sw.verify+1584071317@gogoro.com
${login_phone}              0936123321
${password}                 0x4dcc8f918997a2409a8c0438434765a711990aadcc7f20eddb41c7dcb8a655d892067f7229f5e8f86d78fe28896da4297ad25f8c9f90f24c12efc31bb6abdfd5
${user_id}                  ZRVJD25R
${gogoro_guid}              89a65ffd-6a41-4234-8cb6-c0b5f19a9a1e
${country_code}             TW
${email_verified_status}    1
${phone_verified_status}    1

*** Test Cases ***
users-auth - get - get users auth with correct fields should be passed
    [Tags]    CID:5575
    ${resp} =    Users Auth Get    user_email=${user_email}    login_phone=${login_phone}    password=${password}
    Verify Status Code As Expected       ${resp}    200
    Verify Schema    users-auth.json    UsersAuthGet    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}                 ${user_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['gogoro_guid']}             ${gogoro_guid}
    Verify Response Contains Expected    ${resp.json()['data'][0]['country_code']}            ${country_code}
    Verify Response Contains Expected    ${resp.json()['data'][0]['email_verified']}          ${email_verified_status}
    Verify Response Contains Expected    ${resp.json()['data'][0]['login_phone_verified']}    ${phone_verified_status}

users-auth - get - get users auth with invalid required fields should be failed
    [Tags]    FET    CID:5578
    [Template]    Verify Users Auth Get With Invalid Fields
    11    UnAuthenticated                                      user_email=${user_email}    login_phone=${None}           password=123
    11    UnAuthenticated                                      user_email=${None}          login_phone=${login_phone}    password=123
    11    UnAuthenticated                                      user_email=${user_email}    login_phone=${login_phone}    password=123
    11    UnAuthenticated                                      user_email=123              login_phone=${login_phone}    password=${password}
    40    password cannot be null or empty.                    user_email=${user_email}    login_phone=${EMPTY}          password=${EMPTY}
    40    password cannot be null or empty.                    user_email=${EMPTY}         login_phone=${login_phone}    password=${EMPTY}
    40    password cannot be null or empty.                    user_email=${user_email}    login_phone=${login_phone}    password=${EMPTY}
    40    email & login_phone cannot be both null or empty.    user_email=${EMPTY}         login_phone=${EMPTY}          password=${password}

users-auth - get - get users auth with login phone and password should be passed
    [Tags]    CID:5574
    ${resp} =    Users Auth Get    login_phone=${login_phone}    password=${password}
    Verify Status Code As Expected       ${resp}    200
    Verify Schema    users-auth.json    UsersAuthGet    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}                 ${user_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['gogoro_guid']}             ${gogoro_guid}
    Verify Response Contains Expected    ${resp.json()['data'][0]['country_code']}            ${country_code}
    Verify Response Contains Expected    ${resp.json()['data'][0]['email_verified']}          ${email_verified_status}
    Verify Response Contains Expected    ${resp.json()['data'][0]['login_phone_verified']}    ${phone_verified_status}

users-auth - get - get users auth with null required fields should be failed
    [Tags]    FET    CID:5576
    [Template]    Verify Users Auth Get With Invalid Fields
    40    password must not be null                            user_email=${user_email}    login_phone=${None}           password=${None}
    40    password must not be null                            user_email=${None}          login_phone=${login_phone}    password=${None}
    40    password must not be null                            user_email=${user_email}    login_phone=${login_phone}    password=${None}
    40    password must not be null                            user_email=${None}          login_phone=${None}           password=${None}
    40    email & login_phone cannot be both null or empty.    user_email=${None}          login_phone=${None}           password=${password}

users-auth - get - get users auth with user email and password should be passed
    [Tags]    CID:5573
    ${resp} =    Users Auth Get    user_email=${user_email}    password=${password}
    Verify Status Code As Expected       ${resp}    200
    Verify Schema    users-auth.json    UsersAuthGet    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}                 ${user_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['gogoro_guid']}             ${gogoro_guid}
    Verify Response Contains Expected    ${resp.json()['data'][0]['country_code']}            ${country_code}
    Verify Response Contains Expected    ${resp.json()['data'][0]['email_verified']}          ${email_verified_status}
    Verify Response Contains Expected    ${resp.json()['data'][0]['login_phone_verified']}    ${phone_verified_status}

users-auth - get - get users auth with user email and password and invalid login phone should be passed
    [Tags]    CID:5609
    ${resp} =    Users Auth Get    user_email=${user_email}    login_phone=123    password=${password}
    Verify Status Code As Expected       ${resp}    200
    Verify Schema    users-auth.json    UsersAuthGet    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}                 ${user_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['gogoro_guid']}             ${gogoro_guid}
    Verify Response Contains Expected    ${resp.json()['data'][0]['country_code']}            ${country_code}
    Verify Response Contains Expected    ${resp.json()['data'][0]['email_verified']}          ${email_verified_status}
    Verify Response Contains Expected    ${resp.json()['data'][0]['login_phone_verified']}    ${phone_verified_status}

*** Keywords ***
# -------- Gogoro Keywords --------
Get Users Auth With Required Fields
    [Arguments]    ${user_email}    ${login_phone}    ${password}    &{fields}
    ${resp} =    Users Auth Get    user_email=${user_email}
    ...    login_phone=${login_phone}    password=${password}    &{fields}
    Verify Status Code As Expected    ${resp}    200
    [Return]    ${resp}

# -------- Verify Keywords --------
Verify Users Auth Get With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Get Users Auth With Required Fields    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify GoAuth Error Message       ${resp}    ${additional_code}    ${err_msg}