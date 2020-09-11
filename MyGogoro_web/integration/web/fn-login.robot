*** Settings ***
Documentation    Test suite for MyGogoro
Resource    ../../init.robot

Force Tags    MyGogoroWeb Login
Test Timeout    ${TEST_TIMEOUT}
Suite Setup    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
# Suite Teardown    Close All Browsers

*** Test Cases ***
Login function- Empty           #M01-06-01
    Blank Textbox For Login Page

Login function- Invalid data            #M01-07-01
    Input Invalid data For Login Page

# Login function- Valid data
#     [Setup]    TestSetupForUpdateUser
#     Input Valid Data For Login Page
#     Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://pa-network-my.gogoro.com/dashboard 
#     # “Verify Page URL” setting in keywords_common.robot
#     Verify Navigate to MyAccount Dashboard After Click Login Button
#     # Navigate To My Profile Page
#     Go To     https://pa-network-my.gogoro.com/my-profile
#     Click Element   //*[@id="app"]/div[2]/div/form/section[1]/div[3]/label[4]/label
#     Click Element   //*[@id="app"]/div[2]/div/form/section[5]/div/button
#     ${resp} =    Api My Profile Patch    ${User.email}    ${first_name}    ${last_name}\
#     ...    ${display_name}    ${id_number}    ${gender}    ${birthday}    ${occupation}\
#     ...    ${mobile}    ${contact_city}    ${contact_district}    ${contact_zipcode}\
#     ...    ${contact_address}    ${invoice_city}    ${invoice_district}    ${invoice_zipcode}\
#     ...    ${invoice_address}    e-carrier    ${EMPTY}    ${EMPTY}    ${e_carriers_serial}\
#     ...    ${e_carriers_issuer}    ${gogoro-sess}    ${csrf_token} 
#     ${profile} =    Api My Profile Get    ${gogoro-sess}    ${csrf_token}
#     # Set Another User Variables
#     Verify Status Code As Expected    ${resp}    200
#     Verify Schema    ../../../MyGogoro_web/res/schema/api-my-profile.json       updateUserProfile    ${resp.json()}
#     Verify Response Contains Expected    ${resp.json()['gender']}      female


*** Keywords ***
Get User E Carrier Detail
    ${resp} =    Api My Profile Get    ${gogoro-sess}    ${csrf_token}
    Set Test Variable    ${e_carriers_serial}    ${resp.json()['invoiceConfig']['eCarriers'][0]['serial']}
    Set Test Variable    ${e_carriers_issuer}    ${resp.json()['invoiceConfig']['eCarriers'][0]['issuer']}

Set Another User Variables
    ${first_name} =    Generate Random String    5    [UPPER]
    ${last_name} =    Generate Random String    5    [UPPER]
    ${mobile} =    Generate Random String    8    [NUMBERS]
    ${date} =    Evaluate    time.strftime("%Y-%m-%d")    time
    Set Test Variable    ${gender}    female
    Set Test Variable    ${first_name}
    Set Test Variable    ${last_name}
    Set Test Variable    ${display_name}    ${last_name}${first_name}
    Set Test Variable    ${mobile}    09${mobile}
    Set Test Variable    ${id_number}    E123456789
    Set Test Variable    ${birthday}    ${date}
    Set Test Variable    ${contact_city}    桃園市
    Set Test Variable    ${contact_district}    龜山區
    Set Test Variable    ${contact_zipcode}    333
    Set Test Variable    ${contact_address}    頂湖路33號
    Set Test Variable    ${phone}    ${mobile}
    Set Test Variable    ${occupation}    5
    Set Test Variable    ${invoice_city}    桃園市
    Set Test Variable    ${invoice_district}    龜山區
    Set Test Variable    ${invoice_zipcode}    333
    Set Test Variable    ${invoice_address}    頂湖路33號

Set User Variables
    ${password} =    Encode Password Get    Gogoro123
    ${User}    Set Variable    ${User('${password.text}')}
    Set Test Variable    ${User}

Signin User After Signup
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Test Variable    ${gogoro-sess}
    Set Test Variable    ${csrf_token}

Signup User
    Set User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    password=${User.encode_password}\
    ...    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Test Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_Id}    1

TestSetupForUpdateUser
    Signin User After Signup
    Get User E Carrier Detail
    Set Another User Variables


    