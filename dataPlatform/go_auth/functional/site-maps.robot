*** Settings ***
Documentation    API baseline of Site-Maps.

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GA_API_ROOT}/LibSiteMaps.py
Resource          ${DP_ROOT}/standard_library_init.robot
Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GA_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GA_KEYWORD_ROOT}/keywords_site_maps.robot

Force Tags      Site-Maps
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${country_code}                     TW
@{service_type}                     MY_GGR
${site_url}                         https://dev-my.gogoro.com/
@{multiple_service_types_string}    GGR_APP, MY_GGR, MY_GN, SWX_APP
@{multiple_service_types}           GGR_APP  MY_GGR  MY_GN  SWX_APP
@{invalid_service_type}             SWQA_TEST

*** Test Cases ***
site-maps - get - get site maps with invalid required fields
    [Tags]    FET    CID:5571
    [Template]    Verify Site Maps Get With Invalid Fields
    40    country_code value is not valid.          country_code=ABC
    40    country_code value is not valid.          country_code=123
    40    country_code value is not valid.          country_code=!@#
    40    country_code value is not valid.          country_code=1
    40    country_code value is not valid.          country_code=12
    40    country_code value is not valid.          country_code=!
    40    country_code value is not valid.          country_code=A
    40    country_code cannot be null or empty.     country_code=${EMPTY}
    40    service_types cannot be null or empty.    service_types=@{EMPTY}
    40    service_types is not valid.               service_types=@{multiple_service_types_string}
    40    service_types is not valid.               service_types=@{invalid_service_type}

site-maps - get - get site maps with multiple service_type
    [Tags]    CID:6197
    ${resp} =     Site Maps Get    country_code=${country_code}
    ...    service_types=@{multiple_service_types}
    Verify Status Code As Expected       ${resp}    200
    Verify Site Maps Response As Expected    ${resp.json()['data']}    GGR_APP    https://mobile-dev-gpf.gogoroapp.com/
    Verify Site Maps Response As Expected    ${resp.json()['data']}    MY_GGR     https://dev-my.gogoro.com/
    Verify Site Maps Response As Expected    ${resp.json()['data']}    MY_GN      https://dev-network-my.gogoro.com/
    Verify Site Maps Response As Expected    ${resp.json()['data']}    SWX_APP    https://dev-swx.gogoro.com/

site-maps - get - get site maps with non exist country_code should return service type url
    [Tags]    CID:5569
    ${resp} =    Site Maps Get    country_code=KR
    ...    service_types=@{service_type}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['site_url']}        ${site_url}
    Verify Response Contains Expected    ${resp.json()['data'][0]['service_type']}    @{service_type}
    Verify Response Contains Expected    ${resp.json()['data'][0]['site_type']}       1

site-maps - get - get site maps with null required fields
    [Tags]    FET    CID:5570
    [Template]    Verify Site Maps Get With Invalid Fields
    40    country_code cannot be null or empty.     country_code=${None}
    40    service_types cannot be null or empty.    service_types=${None}

site-maps - get - get site maps with required fields
    [Tags]    CID:5537
    ${resp} =    Get Site Maps With Required Fields
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['site_url']}        ${site_url}
    Verify Response Contains Expected    ${resp.json()['data'][0]['service_type']}    @{service_type}
    Verify Response Contains Expected    ${resp.json()['data'][0]['site_type']}       1

*** Keywords ***
# -------- Gogoro Keywords --------
Get Site Maps With Required Fields
    [Arguments]    ${country_code}=${country_code}    ${service_types}=@{service_type}    &{fields}
    ${resp} =    Site Maps Get    country_code=${country_code}
    ...    service_types=${service_types}    &{fields}
    [Return]    ${resp}

# -------- Verify Keywords --------
Verify Site Maps Get With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Get Site Maps With Required Fields    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify GoAuth Error Message       ${resp}    ${additional_code}    ${err_msg}

Verify Site Maps Get With Valid Fields
    [Arguments]    &{fields}
    ${resp} =    Get Site Maps With Required Fields    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['site_url']}        ${site_url}
    Verify Response Contains Expected    ${resp.json()['data'][0]['service_type']}    @{service_type}
    Verify Response Contains Expected    ${resp.json()['data'][0]['site_type']}       1