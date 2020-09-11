*** Settings ***
Documentation    API baseline of Auth Client.

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${PROJECT_ROOT}/lib/LibCrypto.py
Library           ${GA_API_ROOT}/LibAuthClients.py

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GA_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot

Force Tags      Auth Client
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${app_id}    webservice.app.gogoro
${new_app_id}    swqa.app.gogoro

*** Test Cases ***
auth-clients - add - add client with required fields
    [Template]    Verify Auth Client Add With Valid Fields
    ${guid}    ${1}    ${1}
    ${guid}    ${0}    ${1}
    ${guid}    ${1}    ${2}
    ${guid}    ${1}    ${3}
    ${guid}    ${1}    ${4}

auth-clients - add - add client with correct fields
    ${resp} =    Auth Clients Add    client_guid=${guid}    trusted=${1}    support_grant_type=${3}    client_app_id=${app_id}
    ...    secret=SWQA    redirect_uri=${None}    description=SWQA
    ${get_resp} =    Auth Clients Get    auth_client_ids=${{["${resp.json()["data"][0]["auth_client_id"]}"]}}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['client_guid']}            ${guid}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['client_app_id']}          ${app_id}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['trusted']}                ${1}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['support_grant_type']}     ${3}

auth-clients - add - add client with null required fields
    [Tags]    FET
    [Template]    Verify Auth Client Add With Invalid Fields
    40    add_data[0].client_guid cannot be null or empty      client_guid=${None}    trusted=${1}       support_grant_type=${1}
    40    add_data[0].trusted value is not valid               client_guid=${guid}    trusted=${None}    support_grant_type=${1}
    40    add_data[0].support_grant_type value is not valid    client_guid=${guid}    trusted=${1}       support_grant_type=${None}

auth-clients - add - add client with invalid required fields
    [Tags]    FET
    [Template]    Verify Auth Client Add With Invalid Fields
    40    add_data[0].client_guid is not valid                  client_guid=SWQA       trusted=${1}     support_grant_type=${1}
    40    add_data[0].trusted value is not valid               client_guid=${guid}    trusted=${2}     support_grant_type=${1}
    40    add_data[0].trusted value is not valid               client_guid=${guid}    trusted=${-1}    support_grant_type=${1}
    40    add_data[0].support_grant_type value is not valid    client_guid=${guid}    trusted=${1}     support_grant_type=${0}
    40    add_data[0].support_grant_type value is not valid    client_guid=${guid}    trusted=${1}     support_grant_type=${5}

auth-clients - update - update client with required fields
    [Setup]    Create Auth Client Setup
    [Template]    Verify Auth Client Update With Valid Fields
    ${auth_client_id}    ${0}    ${1}
    ${auth_client_id}    ${1}    ${1}
    ${auth_client_id}    ${0}    ${2}
    ${auth_client_id}    ${0}    ${3}
    ${auth_client_id}    ${0}    ${4}

auth-clients - update - update client with correct fields
    [Setup]    Create Auth Client Setup
    ${resp} =    Auth Clients Update    client_id=${auth_client_id}    client_app_id=${new_app_id}    secret=SWQA_Test    trusted=${0}
    ...    redirect_uri=${None}    support_grant_type=${1}    description=SWQA_Test
    ${get_resp} =    Auth Clients Get    auth_client_ids=${{["${auth_client_id}"]}}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['client_app_id']}          ${new_app_id}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['trusted']}                ${0}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['support_grant_type']}     ${1}

auth-clients - update - update client with null required fields
    [Tags]    FET
    [Setup]    Create Auth Client Setup
    [Template]    Verify Auth Client Update With Invalid Fields
    40    update_data[0].trusted value is not valid               trusted=${None}
    40    update_data[0].support_grant_type value is not valid    support_grant_type=${None}

auth-clients - update - update client with invalid required fields
    [Tags]    FET
    [Setup]    Create Auth Client Setup
    [Template]    Verify Auth Client Update With Invalid Fields
    40    update_data[0].trusted value is not valid               trusted=${-1}
    40    update_data[0].trusted value is not valid               trusted=${2}
    40    update_data[0].support_grant_type value is not valid    support_grant_type=${0}
    40    update_data[0].support_grant_type value is not valid    support_grant_type=${5}

auth-clients - get - get client with required fields
    [Setup]    Create Auth Client Setup
    [Template]    Verify Auth Client Get With Valid Fields
    auth_client_ids=${{["${auth_client_id}"]}}
    client_guids=${{["${guid}"]}}
    client_app_ids=${{["${app_id}"]}}

auth-clients - get - get client with null required fields
    [Tags]    FET    fix_1577
    [Setup]    Create Auth Client Setup
    [Template]    Verify Auth Client Get With Invalid Fields
    40    At least one list [get_data.auth_client_ids or get_data.client_guids or get_data.auth_client_app_ids] must be given    auth_client_ids=${None}
    40    At least one list [get_data.auth_client_ids or get_data.client_guids or get_data.auth_client_app_ids] must be given    client_guids=${None}
    40    At least one list [get_data.auth_client_ids or get_data.client_guids or get_data.auth_client_app_ids] must be given    client_app_ids=${None}

auth-clients - get - get client with invaild required fields
    [Tags]    FET
    [Setup]    Create Auth Client Setup
    [Template]    Verify Auth Client Get With Invalid Fields
    40    decode failed    auth_client_ids=${{["${decode_auth_client_id}"]}}

*** Keywords ***
# --------  Suite Setup    --------
# --------  Test Setup     --------
Test Setup
    ${guid} =    Generate Random UUID
    Set Test Variable    ${guid}

Create Auth Client Setup
    Test Setup
    ${resp} =    Auth Clients Add    client_guid=${guid}    trusted=${1}    support_grant_type=${3}    client_app_id=${app_id}
    ...    secret=SWQA    redirect_uri=${None}    description=SWQA
    ${decode_auth_client_id} =    Decode Encodeid      ${resp.json()["data"][0]["auth_client_id"]}
    Set Test Variable    ${auth_client_id}    ${resp.json()["data"][0]["auth_client_id"]}
    Set Test Variable    ${decode_auth_client_id}

# -------- Setup  Keywords --------
# -------- Gogoro Keywords --------
Create Auth Client With Required Fields
    [Arguments]    ${client_guid}=${guid}    ${trusted}=${1}    ${support_grant_type}=${3}
    ...            &{fields}
    ${resp} =    Auth Clients Add
    ...    client_guid=${client_guid}    trusted=${trusted}       support_grant_type=${support_grant_type}
    ...    &{fields}
    Verify Status Code As Expected    ${resp}    200
    [Return]    ${resp}

Update Auth Client With Required Fields
    [Arguments]    ${client_id}=${auth_client_id}    &{fields}
    ${resp} =    Auth Clients Update    client_id=${client_id}    &{fields}
    Verify Status Code As Expected    ${resp}    200
    [Return]    ${resp}

# -------- Verify Keywords --------
Verify Auth Client Add With Valid Fields
    [Arguments]    ${client_guid}    ${trusted}    ${support_grant_type}    &{fields}
    Test Setup
    ${resp} =    Auth Clients Add    ${client_guid}    ${trusted}    ${support_grant_type}    &{fields}
    Verify Status Code As Expected                   ${resp}    200
    Verify Response Json Data Should Contains Key    ${resp}    auth_client_id

Verify Auth Client Add With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Create Auth Client With Required Fields    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify GoAuth Error Message       ${resp}    ${additional_code}    ${err_msg}

Verify Auth Client Get With Invalid Fields And Empty Response
    [Arguments]    &{fields}
	${resp} =    Auth Clients Get    &{fields}
	Verify Status Code As Expected    ${resp}    200
	Verify Response Contains Expected     ${resp.json()['data']}    ${{[]}}

Verify Auth Client Get With Valid Fields
	[Arguments]    &{fields}
	${resp} =    Auth Clients Get    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify Response Contains Expected    ${resp.json()['data'][0]['client_app_id']}          ${app_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['trusted']}                ${1}
    Verify Response Contains Expected    ${resp.json()['data'][0]['support_grant_type']}     ${3}
    Verify Response Contains Expected    ${resp.json()['data'][0]['secret']}                 SWQA

Verify Auth Client Get With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Auth Clients Get    &{fields}
	Verify Status Code As Expected    ${resp}    200
    Verify GoAuth Error Message       ${resp}    ${additional_code}    ${err_msg}

Verify Auth Client Update With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Update Auth Client With Required Fields    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Auth Client Update With Valid Fields
    [Arguments]    ${client_id}    ${trusted}    ${support_grant_type}
    ${resp} =    Auth Clients Update    client_id=${client_id}    trusted=${trusted}    support_grant_type=${support_grant_type}
    ${get_resp} =    Auth Clients Get    auth_client_ids=${{["${auth_client_id}"]}}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['trusted']}                ${trusted}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['support_grant_type']}     ${support_grant_type}