*** Settings ***
Documentation    API baseline of Auth Client.
Force Tags       Auth

Variables        ../../../env.py
Variables        ${PROJECT_ROOT}/setting.py   dev

Library          ${GA_API_ROOT}/LibAuthRefresh.py
Library          ${GP_USERS_API_ROOT}/LibUsers.py
Library          ${PROJECT_ROOT}/lib/LibCrypto.py

Variables        ${GP_LIB_ROOT}/DataPlatformObject.py

Resource         ${DP_ROOT}/standard_library_init.robot
Resource         ${GA_KEYWORD_ROOT}/keywords_common.robot
Resource         ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource         ${PROJECT_ROOT}/lib/keywords_common.robot

Test Setup       Test Setup
Test Timeout     ${TEST_TIMEOUT}

*** Variables ***
${auth_client_id}    a6mnMNob
${err_guid}          5c3aadee-f169-43cc-8e7c-4689fc964d69
${err_user_id}       ZpLbxNQK

*** Test Cases ***
auth-refresh - add - add auth-refresh with required fields
    ${resp} =    Auth Refresh Add    user_id=${user_id}    auth_client_id=${auth_client_id}    expiration_time=${furture_timestamp}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Json Data Should Contains Key    ${resp}    refresh_token_id

auth-refresh - add - add auth-refresh with correct fields
    ${resp} =    Auth Refresh Add    user_id=${user_id}    auth_client_id=${auth_client_id}    expiration_time=${furture_timestamp}    refresh_token_guid=${guid}
    ${get_resp} =    Auth Refresh Get    refresh_token_id=${resp.json()["data"][0]["refresh_token_id"]}
    Verify Status Code As Expected                   ${resp}    200
    Verify Response Json Data Should Contains Key    ${resp}    refresh_token_id
    Verify Response Contains Expected                ${get_resp.json()['data'][0]['refresh_token_guid']}    ${guid}
    Verify Response Contains Expected                ${get_resp.json()['data'][0]['user_id']}               ${user_id}
    Verify Response Contains Expected                ${get_resp.json()['data'][0]['auth_client_id']}        ${auth_client_id}

auth-refresh - add - add auth-refresh with null required fields
    [Tags]    FET
    [Template]    Verify Auth Refresh Add With Invalid Fields
    40    user_id cannot be null or empty            user_id=${None}       auth_client_id=${auth_client_id}    expiration_time=${furture_timestamp}
    40    auth_client_id cannot be null or empty     user_id=${user_id}    auth_client_id=${None}              expiration_time=${furture_timestamp}
    40    expiration_time cannot be null             user_id=${user_id}    auth_client_id=${auth_client_id}    expiration_time=${None}

auth-refresh - add - add auth-refresh with invalid required fields
    [Tags]    FET    fix_1574
    [Template]    Verify Auth Refresh Add With Invalid Fields
    40    decode failed                 user_id=${1}          auth_client_id=${auth_client_id}    expiration_time=${furture_timestamp}
    40    decode failed                 user_id=${user_id}    auth_client_id=${1}                 expiration_time=${furture_timestamp}
    40    Value is out of range : -1    user_id=${user_id}    auth_client_id=${auth_client_id}    expiration_time=${-1}

auth-refresh - add - add auth-refresh with invalid non required fields
    [Tags]    FET    fix_1575
    [Template]    Verify Auth Refresh Add With Invalid Fields
    40    refresh_token_guid is not valid    refresh_token_guid=SWQA

auth-refresh - get - get auth-refresh with required fields
    [Setup]    Create Auth Refresh Setup
    [Template]    Verify Auth Refresh Get With Valid Fields
    user_id=${user_id}
    refresh_token_id=${auth_refresh_id}
    refresh_token_guid=${guid}
    refresh_token_id=${auth_refresh_id}    refresh_token_guid=${err_guid}
    user_id=${err_user_id}    refresh_token_id=${auth_refresh_id}
    user_id=${err_user_id}    refresh_token_guid=${guid}

auth-refresh - get - get auth-refresh with null required fields
    [Tags]    FET
    [Setup]    Create Auth Refresh Setup
    [Template]    Verify Auth Refresh Get With Invalid Fields
    40    refresh_token_id, refresh_token_guid and user_id cannot be all null or empty    user_id=${None}
    40    refresh_token_id, refresh_token_guid and user_id cannot be all null or empty    refresh_token_id=${None}
    40    refresh_token_id, refresh_token_guid and user_id cannot be all null or empty    refresh_token_guid=${None}

auth-refresh - get - get auth-refresh with invaild required fields
    [Tags]    FET    fix_1576
    [Setup]    Create Auth Refresh Setup
    [Template]    Verify Auth Refresh Get With Invalid Fields
    40    decode failed    user_id=${1}
    40    decode failed    refresh_token_id=${decode_auth_refresh_id}
    40    decode failed    refresh_token_id=SWQA

auth-refresh - get - get auth-refresh with invaild required fields should be failed
    [Tags]    FET
    [Setup]    Create Auth Refresh Setup
    [Template]    Verify Auth Refresh Get With Invalid Fields
    40    refresh_token_guid is not valid    refresh_token_guid=SWQA
    40    refresh_token_guid is not valid    refresh_token_guid=${1111}

*** Keywords ***
# --------  Suite Setup    --------
# --------  Test Setup     --------
Test Setup
    ${furture_timestamp} =    Evaluate    int(time.time() + 86400)   time
    ${guid} =    Generate Random UUID
    Set Test Variable    ${furture_timestamp}
    Set Test Variable    ${guid}
    Set Test Variable    ${User}    ${Users()}
    Users Create Setup

Create Auth Refresh Setup
    Test Setup
    ${resp} =    Auth Refresh Add    user_id=${user_id}    auth_client_id=${auth_client_id}    expiration_time=${furture_timestamp}    refresh_token_guid=${guid}
    ${decode_auth_refresh_id} =    Decode Encodeid      ${resp.json()["data"][0]["refresh_token_id"]}
    Set Test Variable    ${auth_refresh_id}    ${resp.json()["data"][0]["refresh_token_id"]}
    Set Test Variable    ${decode_auth_refresh_id}

Users Create Setup
    ${resp} =    Users Post
    ...    ${User.company_code}    ${User.first_name}    ${User.gender}
    ...    ${User.email}           ${User.status}
    ...    ${User.enable_e_carrier}
    ...    invoice_address=${User.invoice_address}
    ...    invoice_district=${User.invoice_district}
    ...    invoice_city=${User.invoice_city}
    ...    gogoro_guid=${User.gogoro_guid}
    ...    profile_id=${User.profile_id}
    ...    password=${User.encode_password}
    Set Test Variable    ${user_id}    ${resp.json()['data'][0]['user_id']}

# -------- Setup  Keywords --------
# -------- Gogoro Keywords --------
Create Auth Refresh With Required Fields
    [Arguments]    ${user_id}=${user_id}    ${auth_client_id}=${auth_client_id}    ${expiration_time}=${furture_timestamp}
    ...            &{fields}
    ${resp} =    Auth Refresh Add
    ...    user_id=${user_id}    auth_client_id=${auth_client_id}    expiration_time=${expiration_time}
    ...    &{fields}
    Verify Status Code As Expected    ${resp}    200
    [Return]    ${resp}

# -------- Verify Keywords --------
Verify Auth Refresh Add With Valid Fields
    [Arguments]    ${client_guid}    ${trusted}    ${support_grant_type}    &{fields}
    ${resp} =    Auth Refresh Add    ${client_guid}    ${trusted}    ${support_grant_type}    &{fields}
    Verify Status Code As Expected                   ${resp}    200
    Verify Response Json Data Should Contains Key    ${resp}    auth_client_id

Verify Auth Refresh Add With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Create Auth Refresh With Required Fields    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify GoAuth Error Message       ${resp}    ${additional_code}    ${err_msg}

Verify Auth Refresh Get With Valid Fields
	[Arguments]    &{fields}
	${resp} =    Auth Refresh Get    &{fields}
	Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['refresh_token_guid']}    ${guid}
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}               ${user_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['auth_client_id']}        ${auth_client_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['refresh_token_id']}      ${auth_refresh_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['refresh_token_guid']}    ${guid}

Verify Auth Refresh Get With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Auth Refresh Get    &{fields}
	Verify Status Code As Expected    ${resp}    200
    Verify GoAuth Error Message       ${resp}    ${additional_code}    ${err_msg}

Verify Auth Refresh Get With Invalid Fields And Empty Response
    [Arguments]    &{fields}
	${resp} =    Auth Refresh Get    &{fields}
	Verify Status Code As Expected    ${resp}    200
	Verify Response Contains Expected     ${resp.json()['data']}    ${{[]}}