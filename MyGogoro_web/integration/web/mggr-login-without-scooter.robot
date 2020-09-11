*** Settings ***
Documentation    Test suite for MyGogoro
Resource    ../../init.robot

Force Tags    MyGogoroWeb Login without scooter
Suite Setup    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
Suite Teardown    Close All Browsers
Test Setup    Signup User
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Login gogoro account which without scooter
    Login With Email And Password    ${User.email}    Gogoro321
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/new-sub

*** Keywords ***
Set User Variables
    ${password} =    Encode Password Get    Gogoro321
    ${User}    Set Variable    ${User('${password.text}')}
    Set Test Variable    ${User}

Signup User
    Set User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Test Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_Id}    1