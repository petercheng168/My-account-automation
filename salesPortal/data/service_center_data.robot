*** Settings ***
Documentation    Test suite of Sales_Portal setup service center test data
Resource    ../init.robot

Force Tags    SalesPortal
Test Timeout    3600

*** Variables ***
${TEST_EMAIL}       pasw007@yopmail.com            #input_email_here@gogoro.com

*** Test Cases ***
Create full contract data
    [Setup]    Test Setup For Creating Scooter Order And Update Bill Version
    ...    ${TEST_EMAIL}     licensing_location=自領牌     licensing_location_id=DMV_ZL
    Status From Wait Delivery Scooter To Delivery Scooter
    Confirm Pre-Delivery Scooter Checklist    self
    Confirm Delivery Scooter Checklist    self
    Sign Delivery Checklist
    Verify Delivery Success    確認交車成功
    [Teardown]    Close All Browsers

Create service center users
    :FOR    ${index}    IN RANGE    ${1}
    \    Run Keyword And Ignore Error    Create Service Center User    ${index}

Update incomplete user data
    Update Incomplete User Data    ${TEST_EMAIL}

*** Keywords ***
Assign Scooter From Scooters Infos
    [Arguments]    ${dms_order_no}
    Scooters Infos Update    ${dms_order_no}    ${scooter.scooter_vin}
    ...    ${driver.user_id}    ${owner.user_id}    ${owner.user_guid}    0
    ...    turn_light=1    brake_light=1    tpms=0    sport_mode=1

Create Service Center User
    [Arguments]    ${index}
    ${guid} =    Evaluate    str(uuid.uuid4())    uuid
    Set Test Variable    ${email}    sw.verify+test_${index}@gogoro.com
    ${resp} =    Users Post    company_code=1300    first_name=SWQA    gender=M
    ...    email=${email}    status=1    enable_e_carrier=0    last_name=QA
    ...    nick_name=Test    birthday=1999-11-11
    ...    contact_address=長安東路二段225號C棟11樓    contact_district=松山區
    ...    contact_city=臺北市    contact_zip=105
    ...    invoice_address=長安東路二段225號C棟11樓    invoice_district=松山區
    ...    invoice_city=臺北市    invoice_zip=105
    ...    country_code=TW    mobile_phone1=0911111111    profile_id=A116010273
    ...    password=c1SmbaR8oM1hzVW0AlwvKyO/drw8gIxePQLqQK2u1r/U5C/E9lYF4CthppfVPWA5PoLEHT1AczH6ztcoVAaWoQ==
    ...    gogoro_guid=${guid}    photo_url=http://google.com
    ...    eula_status=1    account=${CIPHER_GEN_ACCOUNT}
    Set Test Variable    ${user_id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_id}    1
    Log To Console    Index: ${index} User_ID: ${user_id} Email: ${email}

Login And Get Token
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Set Test Variable    ${token}    ${get_token}
    Login With Direct Login
    Click Button In Main Body    待處理訂單
    Verify Page URL    ${SALES_PORTAL_URL}/order/manage

Setup Scooter Variables
    [Arguments]    ${scooter_model}=GSBH2-000-CF
    Set Test Variable    ${scooter}    ${Scooters('${scooter_model}')}

Status From Wait Assign Scooter Date To Wait Delivery Plate
    [Documentation]    Assign scooter
    Status From Wait Assign Scooter To Wait Assign Scooter Date
    Assign Scooter From Scooters Infos    ${dms_order_no}
    Click Order State Button    7    待押交車

Status From Wait Delivery Plate To Wait Delivery Scooter
    Status From Wait Assign Scooter Date To Wait Delivery Plate
    Click Button With Assign Order Number    ${dms_order_no}
    Select Delivery Date
    Click Confirm Delivery Date Button
    Click Reservation Success Button
    Input Subsidy Bank Information
    Upload Documents In Waiting Delivery Scooter Date Page
    Complete Purchase Intention Flow
    Click All Checkbox In Waiting Delivery Scooter Date Page
    Click Send Review Button
    Verify Order In Correct State List    8    待送領牌    ${dms_order_no}

Status From Wait Delivery Scooter To Delivery Scooter
    Status From Wait Delivery Plate To Wait Delivery Scooter
    Confirm Sending Take Plate Request
    Verify Order In Correct State List    10    待交車    ${dms_order_no}

Test Setup For Creating Scooter Order And Update Bill Version
    [Arguments]    ${buyer_email}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}    ${licensing_location}=台北領牌中心    ${licensing_location_id}=DMV_TP    ${agency_fee}=2215
    Login And Get Token
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    Setup Scooter Variables
    ${dms_order_no} =    Create Scooter Order    ${buyer}    臺北市    2004    SUBFEE-00049    ${licensing_location}    ${licensing_location_id}    ${agency_fee}    ${token}    Owner=${owner}    Driver=${driver}
    Update Es-Contract Bill Version
    Set Test Variable    ${dms_order_no}
    Log To Console    ${scooter.scooter_vin}

Update Es-Contract Bill Version
    ${resp} =    Scooter Contracts Es Contracts Get
    ...    scooter_contract_id=${Order.order_id}
    ...    scooter_owner_id=${Order.owner_id}
    ...    account=${CIPHER_GSS_ACCOUNT}
    Es Contracts Update
    ...    es_contract_id=${resp.json()['data'][0]['es_contract_id']}
    ...    status=1    bill_version=1
    ...    account=${CIPHER_GEN_ACCOUNT}

Update Incomplete User Data
    [Arguments]    ${input_email}
    ${resp} =    Users Get Email    user_email=${input_email}
    ...    request_data_type=2    account=${CIPHER_GEN_ACCOUNT}
    ${user_id} =    Set Variable    ${resp.json()['data'][0]['user_id']}
    Users Update    user_id=${user_id}    mobile_phone1=0911111111
    ...    birthday=1989-07-24    profile_id=A197116607
    ...    contact_address=長安東路二段225號C棟11樓    contact_district=松山區
    ...    contact_city=臺北市    contact_zip=105
    ...    invoice_address=長安東路二段225號C棟11樓    invoice_district=松山區
    ...    invoice_city=臺北市    invoice_zip=105
    ...    password=c1SmbaR8oM1hzVW0AlwvKyO/drw8gIxePQLqQK2u1r/U5C/E9lYF4CthppfVPWA5PoLEHT1AczH6ztcoVAaWoQ==
    ...    country_code=TW    account=${CIPHER_GEN_ACCOUNT}

User Information Setup
    [Arguments]    ${buyer_email}    ${owner_email}    ${driver_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}
