*** Settings ***
Documentation    Test suite for MyGogoro update user password
Resource    ../../init.robot

Force Tags    MyGogoro    profile    password
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Update user password
    [Setup]    Signin User After Signup And Set New Password
    ${resp} =    Api My Profile Password Put    ${User.encode_password}    ${new_password}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.text}    OK
    Verify New Cookie Be Able To Use    ${User.email}    ${new_password}

*** Keywords ***
Set New Password
    ${password} =    Encode Password Get    Gogoro456
    Set Test Variable    ${new_password}    ${password.text}

Set User Variables
    ${password} =    Encode Password Get    Gogoro123
    ${User}    Set Variable    ${User('${password.text}')}
    Set Test Variable    ${User}

Signin User After Signup And Set New Password
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Test Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}
    Set New Password

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
