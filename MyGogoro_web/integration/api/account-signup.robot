*** Settings ***
Documentation    Test suite for MyGogoro signup scenario
Resource    ../../init.robot

Force Tags    MyGogoro    signup
Test Timeout    ${TEST_TIMEOUT}

*** Variable ***
@{occupation_list}    1    2    3    4    5    6
@{gender_list}    male    female

*** Test Case ***
Signup with expected account information
    [Setup]    Test Setup For Signup User Variables
    ${resp}    Account Signup Post    ${gender}    ${User.last_name}    ${User.first_name}    ${User.display_name}\
    ...    ${User.email}    ${User.mobile}    ${User.encode_password}    ${User.birthday}    ${User.contact_city}\
    ...    ${User.contact_district}    ${User.contact_zipcode}    ${User.contact_address}    ${User.phone}    ${occupation}\
    ...    ${User.invoice_city}    ${User.invoice_district}    ${User.invoice_zipcode}    ${User.invoice_address}
    Verify Status Code As Expected    ${resp}    201
    Verify Schema    ../../..MyGogoro_web/res/schema/signup.json    userCreate    ${resp.json()}
    Verify Email Exists    no-reply@gogoro.com    ${GMAIL_ACCOUNT}    ${GMAIL_PASSWORD}
    Verify User Field Is Expected Via Email    ${User.email}    2    country_code    TW

Signup with country code
    [Setup]    Test Setup For Signup User Variables
    ${resp}    Account Signup Post    ${gender}    ${User.last_name}    ${User.first_name}    ${User.display_name}\
    ...    ${User.email}    ${User.mobile}    ${User.encode_password}    ${User.birthday}    ${User.contact_city}\
    ...    ${User.contact_district}    ${User.contact_zipcode}    ${User.contact_address}    ${User.phone}    ${occupation}\
    ...    ${User.invoice_city}    ${User.invoice_district}    ${User.invoice_zipcode}    ${User.invoice_address}    country=JP
    Verify Status Code As Expected    ${resp}    201
    Verify Schema    ../../..MyGogoro_web/res/schema/signup.json    userCreate    ${resp.json()}
    Verify Email Exists    no-reply@gogoro.com    ${GMAIL_ACCOUNT}    ${GMAIL_PASSWORD}
    Verify User Field Is Expected Via Email    ${User.email}    2    country_code    JP

*** Keywords ***
Test Setup For Signup User Variables
    ${password} =    Encode Password Get    Gogoro123
    ${occupation} =    Evaluate    random.choice($occupation_list)    random
    ${gender} =    Evaluate    random.choice($gender_list)    random
    ${User}    Set Variable    ${User('${password.text}')}
    Set Test Variable    ${occupation}
    Set Test Variable    ${gender}
    Set Test Variable    ${User}