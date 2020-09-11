*** Settings ***
Documentation    Test suite for MyGogoro
Resource    ../../init.robot

Force Tags    MyGogoroWeb Register
Suite Setup    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
# Suite Teardown    Close All Browsers
# Test Setup    Signup User
Test Timeout    ${TEST_TIMEOUT}
Test Teardown    Test Teardown


*** Test Case ***
Register Negative test- Disagree EULA
    Click Register Button  
    Click EULA Cancel Button 
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/login

Register Negative test- Invalid data        #M01-03-01
    Click Register Button
    # Wait Until element is visible   //html/body/div[1]/div/div/div 
    Click EULA Agree Button 
    Fill In Invalid Data Into Email Of The New Account
    # Fill In Invalid Data Into Mobile Of The New Account
    Fill In Invalid Format Into Password Of The New Account
    Fill In Invalid Length Into Password Of The New Account
    Fill In Invalid Data Into Last Name Of The New Account
    Fill In Invalid Data Into First Name Of The New Account
    Click Gender Raido Button- Male Radio Button  
    Click Registered Button
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/register

Register Negative test- Field is empty          #M01-04-01
    Click Register Button
    # Wait Until element is visible   //html/body/div[1]/div/div/div
    Click EULA Agree Button 
    Click Registered Button
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/register

Register Negative test- registered and verified         

    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/login

Register Negative test- registered and not veriftered           #M01-03-01
    # Signup User Unverified 
    Signup User    email_verified=0
    Login With Email And Password Unverified    ${User.email}    Gogoro123
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/verify
    # Click Element       //*[@id="app"]/div/footer/a[1]


# Register Negative test- resend verify mail    #M01-17-01
#     Signup User    email_verified=1
#     Login With Email And Password   ${User.email}    Gogoro123
#     Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/new-sub
#     Close All Browsers
#     Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
#     Go To   https://${MYGOGORO_GN_HOST}/verify
#     Click Not Received Mail
#     Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/send-verify
#     Fill In Resend Mail
#     Click Resend Mail Button
#     Wait Until Keyword Succeeds    10s    2s   Verfiy Mail Verified Msg    您的 Email 已認證，請重新登入\n確認     

# Register Negative test- resend not verify mail
#     Signup User    email_verified=0
#     Login With Email And Password Unverified    ${User.email}    Gogoro123
#     Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/verify
#     Click Not Received Mail
#     Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/send-verify
#     Fill In Resend Mail
#     Click Resend Mail Button
#     Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://${MYGOGORO_GN_HOST}/verify


*** Keywords ***
Set User Variables
    ${password} =    Encode Password Get    Gogoro123
    ${User}    Set Variable    ${User('${password.text}')}
    Set Test Variable    ${User}

Signup User
    [Arguments]    ${email_verified}=1
    Set User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Test Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_Id}    ${email_verified}

# Signup User Unverified 
#     Set User Variables
#     ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
#     ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
#     ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
#     ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
#     ...    ${User.country_code}    mobile_phone1=${User.mobile}    password=${User.encode_password}\
#     ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
#     Set Test Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
#     Users Update Email Verified    ${user_Id}    0    # 0= Unverified,  1= verified

Fill In All Valid Data
    Fill In Valid Data Into Last Name Of The New Account
    Fill In Valid Data Into First Name Of The New Account
    Fill In Valid Data Into Email Of The New Account
    Fill In Valid Data Into Mobile Of The New Account
    Fill In Valid Data Into Password Of The New Account
    Fill In Valid Data Into passwordConfirm Of The New Account

Input User Mail
    [Documentation]    Input user email at login page
    [Arguments]    ${email}
    Wait Until Element Is Enabled    //input[@type="text"][@name="email"]
    Input Text    //input[@type="text"][@name="email"]    ${email}
    
Input User Passwords
    [Documentation]    Input user password at login page
    [Arguments]    ${password}
    Wait Until Element Is Enabled    //input[@type="password"][@name="password"]
    Input Text    //input[@type="password"][@name="password"]    ${password}

# -------- MyGogoro Keywords --------
Login With Email And Password Unverified
    [Documentation]    Login My Account domain with user email and password
    [Arguments]    ${email}    ${password}
    Input User Mail    ${email}
    Input User Passwords    ${password}
    Click Rounded Button    登入
    Wait Until Location Is    https://${MYGOGORO_GN_HOST}/login    30s


Test Teardown
     Go To    https://pa-network-my.gogoro.com/login
     Sleep      5s