*** Settings ***
Documentation    Test suite for MyGogoro update user password
Resource    ../../init.robot

Force Tags    MyGogoro    profile    password
# Suite Setup    SuiteSetup  #建立新帳號
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Update user password
    [Setup]    Signin User After Signup And Set New Password
    Go To Login Page
    sleep  2s
    Go To Logout Page
    ${resp} =    Api My Profile Password Put    ${User.encode_password}    ${new_password}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.text}    OK
    Verify New Cookie Be Able To Use    ${User.email}    ${new_password}
    log     ${new_password}
    Go To Login Page
    sleep  2s
    Click Message Button
    Login With Email And Password  ${User.email}    Gogoro456
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/new-sub


*** Keywords ***
Set New Password
    ${password} =    Encode Password Get    Gogoro456
    Set Test Variable    ${new_password}    ${password.text}

# Set User Variables
#     ${password} =    Encode Password Get    Gogoro123
#     # ${User}    Set Variable    ${User('${password.text}')}
#     # Set Test Variable    ${User}
#     ${password} =    Encode Password Get    Gogoro123
#     Set Suite Variable    ${User}    ${User('${password.text}')}

Signin User After Signup And Set New Password
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Test Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}
    Set New Password

Set User Variables
    ${password} =    Encode Password Get    Gogoro123
    Set Suite Variable    ${User}    ${User('${password.text}')}
    
Signup User
    Set User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    profile_id=E123456789    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    ${user_id} =    Set Variable        ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_id}    1

SuiteSetup
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}
    ${addon_end_date} =    Get Current Date    UTC    result_format=%Y-%m-%d
    Set Suite Variable    ${addon_end_date}
    Set Suite Variable    ${csrf_token}


Go To Login Page
    Open Browser    ${MYGOGORO_GN_DOMAIN}    ${WINDOW_HEIGHT}    ${WINDOW_WEIGHT}
    Login With Email And Old Password     ${User.email}    Gogoro123

Click Message Button
    Click Element   //html/body/div/div/div[2]/footer/button

Go To Logout Page
    Go To   https://pa-network-my.gogoro.com/logout
