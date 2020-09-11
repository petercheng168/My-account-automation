*** Settings ***
Documentation    Test suite for MyGogoro get current user information
Resource    ../../init.robot

Force Tags    MyGogoro    profile
Test Setup    Signin User After Signup
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Get current user profile
    ${resp} =    Api My Profile Get    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}    200
    Verify Schema    ../../../MyGogoro_web/res/schema/api-my-profile.json    getUserProfile    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['username']}    {'email': '${User.email}'}
    Verify Response Contains Expected    ${resp.json()['emails']}    [{'target': '${User.email}', 'isVerified': True, 'isPrimary': True}]
    Verify Response Contains Expected    ${resp.json()['lastName']}    ${User.last_name}
    Verify Response Contains Expected    ${resp.json()['displayName']}    ${User.display_name}
    Verify Response Contains Expected    ${resp.json()['gender']}    male
    Verify Response Contains Expected    ${resp.json()['birthday']}    ${User.birthday}
    Verify Response Contains Expected    ${resp.json()['occupation']}    ${User.occupation}
    Verify Response Contains Expected    ${resp.json()['mobile']}    ${User.mobile}
    Verify Response Contains Expected    ${resp.json()['mobiles']}    [{'target': '${User.mobile}', 'isPrimary': True}]
    Verify Response Contains Expected    ${resp.json()['country']}    TW
    Verify Response Contains Expected    ${resp.json()['contactAddress']}    {'city': '${User.contact_city}', 'district': '${User.contact_district}', 'zipCode': '${User.contact_zipcode}', 'address': '${User.contact_address}'}
    Verify Response Contains Expected    ${resp.json()['invoiceAddress']}    {'city': '${User.invoice_city}', 'district': '${User.invoice_district}', 'zipCode': '${User.invoice_zipcode}', 'address': '${User.invoice_address}'}

Update user profile
    [Setup]    TestSetupForUpdateUser
    ${resp} =    Api My Profile Patch    ${User.email}    ${first_name}    ${last_name}\
    ...    ${display_name}    ${id_number}    ${gender}    ${birthday}    ${occupation}\
    ...    ${mobile}    ${contact_city}    ${contact_district}    ${contact_zipcode}\
    ...    ${contact_address}    ${invoice_city}    ${invoice_district}    ${invoice_zipcode}\
    ...    ${invoice_address}    e-carrier    ${EMPTY}    ${EMPTY}    ${e_carriers_serial}\
    ...    ${e_carriers_issuer}    ${gogoro-sess}    ${csrf_token}
    ${profile} =    Api My Profile Get    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}    200
    Verify Schema    ../../../MyGogoro_web/res/schema/api-my-profile.json    updateUserProfile    ${resp.json()}
    Verify Response Contains Expected    ${profile.json()['username']}    {'email': '${User.email}'}
    Verify Response Contains Expected    ${profile.json()['emails']}    [{'target': '${User.email}', 'isVerified': True, 'isPrimary': True}]
    Verify Response Contains Expected    ${profile.json()['lastName']}    ${last_name}
    Verify Response Contains Expected    ${profile.json()['displayName']}    ${display_name}
    Verify Response Contains Expected    ${profile.json()['gender']}    female
    Verify Response Contains Expected    ${profile.json()['birthday']}    ${birthday}
    Verify Response Contains Expected    ${profile.json()['occupation']}    ${occupation}
    Verify Response Contains Expected    ${profile.json()['mobile']}    ${mobile}
    Verify Response Contains Expected    ${profile.json()['mobiles']}    [{'target': '${mobile}', 'isPrimary': True}]
    Verify Response Contains Expected    ${profile.json()['country']}    TW
    Verify Response Contains Expected    ${profile.json()['contactAddress']}    {'city': '${contact_city}', 'district': '${contact_district}', 'zipCode': '${contact_zipcode}', 'address': '${contact_address}'}
    Verify Response Contains Expected    ${profile.json()['invoiceAddress']}    {'city': '${invoice_city}', 'district': '${invoice_district}', 'zipCode': '${invoice_zipcode}', 'address': '${invoice_address}'}

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