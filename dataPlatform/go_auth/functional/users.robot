*** Settings ***
Documentation    API baseline of Go Auth Users.

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GA_API_ROOT}/LibUsers.py
Library           ${GA_LIB_ROOT}/LibJSONSchema.py

Resource          ${DP_ROOT}/standard_library_init.robot
Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GA_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot

Force Tags      Users
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${user_id}                  ZRVJD25R
${email}                    sw.verify+1584071317@gogoro.com
${phone}                    0936123321
${gogoro_guid}              89a65ffd-6a41-4234-8cb6-c0b5f19a9a1e
${country_code}             TW
${email_verified_status}    1
${phone_verified_status}    1
${invalid_user_id}          123
${non_exist_user_id}        4mkVrdrN
${non_exist_email}          4mkVrdrN@gogoro.com
${non_exist_phone}          090000000012

*** Test Cases ***
users - get - get users with invalid required fields
    [Tags]    FET    CID:6212
    [Template]    Verify Users Global Get With Invalid Fields
    40    user_id, email or login_phone cannot be all null or empty.    user_id=${EMPTY}    user_email=${EMPTY}    login_phone=${EMPTY}
    40    the length of email '${invalid_len_str_257}' is not valid.    user_email=${invalid_len_str_257}
    40    decode failed : ${invalid_user_id}     user_id=${invalid_user_id}

users - get - get users with non exist required fields
    [Tags]    FET    CID:6210
    [Template]    Verify Users Global Get With Non Exist Fields
    user_id=${non_exist_user_id}
    user_email=${non_exist_email}
    login_phone=${non_exist_phone}

users - get - get users with null required fields should be failed
    [Tags]    FET    CID:6211
    ${resp} =    Users Global Get    user_id=${None}    user_email=${None}    login_phone=${None}
    Verify Status Code As Expected    ${resp}    200
    Verify GoAuth Error Message       ${resp}    40    user_id, email or login_phone cannot be all null or empty.

users - get - get users with required fields
    [Tags]    CID:6213
    [Template]    Verify Users Global Get With Valid Fields
    user_id=${user_id}
    user_email=${email}
    login_phone=${phone}
    user_id=${user_id}     user_email=${email}
    user_id=${user_id}     login_phone=${phone}
    user_email=${email}    login_phone=${phone}
    user_id=${user_id}     user_email=${email}     login_phone=${phone}

*** Keywords ***
# --------  Test Setup     --------
Test Setup
    ${invalid_len_str_257} =    Generate SWQA Random String    257
    Set Test Variable    ${invalid_len_str_257}

# -------- Gogoro Keywords --------
# -------- Verify Keywords --------
Verify Users Global Get With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Users Global Get    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify GoAuth Error Message       ${resp}    ${additional_code}    ${err_msg}

Verify Users Global Get With Non Exist Fields
    [Arguments]    &{fields}
    ${resp} =    Users Global Get    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data']}    []

Verify Users Global Get With Valid Fields
    [Arguments]    &{fields}
    ${resp} =    Users Global Get    &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify Schema    users.json    UsersGet    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}                 ${user_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['gogoro_guid']}             ${gogoro_guid}
    Verify Response Contains Expected    ${resp.json()['data'][0]['email']}                   ${email}
    Verify Response Contains Expected    ${resp.json()['data'][0]['email_verified']}          ${email_verified_status}
    Verify Response Contains Expected    ${resp.json()['data'][0]['login_phone']}             ${phone}
    Verify Response Contains Expected    ${resp.json()['data'][0]['login_phone_verified']}    ${phone_verified_status}
    Verify Response Contains Expected    ${resp.json()['data'][0]['country_code']}            ${country_code}