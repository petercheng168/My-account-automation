*** Settings ***
Documentation    Test suite for MyGogoro get public plans
Resource    ../../init.robot

Force Tags    MyGogoro    plan
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Get public plan
    ${resp} =    Api My Plan Get    gogoro_sess=${gogoro-sess}    csrf_token=${csrf_token}
    Verify Status Code As Expected    ${resp}    200
    Verify Schema    ../../../MyGogoro_web/res/schema/api-my-plan.json    getPublicPlan    ${resp.json()}

*** Keywords ***
Set User Variables
    ${password} =    Encode Password Get    Gogoro123
    ${User}    Set Variable    ${User('${password.text}')}
    Set Suite Variable    ${User}

Signup User
    Set User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Suite Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_Id}    1

SuiteSetup
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}