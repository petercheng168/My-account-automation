*** Settings ***
Documentation    Test suite of users scooters

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GP_API_ROOT}/LibUsersScooters.py

Resource          ../init.robot

Force Tags    Users-Scooters
Test Timeout    ${TEST_TIMEOUT}

*** Variable ***
${user_id}                   QLjB0lgL
${brand_company_code_GSS}    1500


*** Test Cases ***
users-scooters - get - invalid - get users scooters with invalid required fields
    [Tags]    FET
    [Template]    Verify Users Scooters Get With Invalid Fields
    803010003    decode failed                               user_id=invalidUserId    brand_company_code=${brand_company_code_GSS}    
    604040002    Unable to find the company with code        user_id=${user_Id}       brand_company_code=AAA

users-scooters - get - valid - get users scooters 
    ${resp} =    Users Scooters Get     user_id=${user_id}    brand_company_code=${brand_company_code_GSS}
    Verify Status Code As Expected       ${resp}                                    200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    manufacture_time
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    vin
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    plate_date
    Verify Schema    users-scooters.json    userScootersGet    ${resp.json()}


*** Keywords ***
Verify Users Scooters Get With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =   Users Scooters Get   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg} 