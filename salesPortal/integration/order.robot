*** Settings ***
Documentation    Test suite of Sales_Portal Order Page Including Accessories And Scooters
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Teardown    Test Teardown
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Assign scooter
    [Tags]    CID:5165
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Status From Wait Assign Scooter To Wait Assign Scooter Date
    Assign Scooter From Scooters Infos    ${dms_order_no}
    Verify Order In Correct State List    7    待押交車    ${dms_order_no}

Assign scooter with different owner and driver
    [Tags]    CID:5166
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_OWNER_EMAIL}    ${SALES_PORTAL_DRIVER_EMAIL}
    Status From Wait Assign Scooter To Wait Assign Scooter Date
    Assign Scooter From Scooters Infos    ${dms_order_no}
    Verify Order In Correct State List    7    待押交車    ${dms_order_no}

Create invoice
    [Tags]    Manually
    [Documentation]    待結帳
    [Template]    Log
    Given an order without paying
    And order's flow status is 待結帳
    When we use the POS to get receipts
    Then the order's flow status become 待配車

Checkout the bill
    [Tags]    CID:5167
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Update Order From Waiting Checkout To Waiting Assign Scooter    ${dms_order_no}
    Verify Order In Correct State List    6    待配車    ${dms_order_no}

Checkout the bill with different owner and driver
    [Tags]    CID:5168
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_OWNER_EMAIL}    ${SALES_PORTAL_DRIVER_EMAIL}
    Update Order From Waiting Checkout To Waiting Assign Scooter    ${dms_order_no}
    Verify Order In Correct State List    6    待配車    ${dms_order_no}

Delivery scooter plate
    [Tags]    CID:5169
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
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

Delivery scooter plate with different owner and driver
    [Tags]    CID:5170
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_OWNER_EMAIL}    ${SALES_PORTAL_DRIVER_EMAIL}
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

Make an application to take plate
    [Tags]    CID:5171
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Status From Wait Delivery Plate To Wait Delivery Scooter
    Confirm Sending Take Plate Request
    Verify Order In Correct State List    10    待交車    ${dms_order_no}

Make an application to take plate with different owner and driver
    [Tags]    CID:5172
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_OWNER_EMAIL}    ${SALES_PORTAL_DRIVER_EMAIL}
    Status From Wait Delivery Plate To Wait Delivery Scooter
    Confirm Sending Take Plate Request
    Verify Order In Correct State List    10    待交車    ${dms_order_no}

Take plate by gogoro then delivery scooter
    [Tags]    CID:5173
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Status From Wait Delivery Scooter To Delivery Scooter
    Go Support Process
    Switch Window Tab    0
    Confirm Pre-Delivery Scooter Checklist
    Confirm Delivery Scooter Checklist
    Sign Delivery Checklist
    Verify Delivery Success    確認交車成功

Take plate by gogoro then delivery scooter with different owner and driver
    [Tags]    CID:5174
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_OWNER_EMAIL}    ${SALES_PORTAL_DRIVER_EMAIL}
    Status From Wait Delivery Scooter To Delivery Scooter
    Go Support Process
    Switch Window Tab    0
    Confirm Pre-Delivery Scooter Checklist
    Confirm Delivery Scooter Checklist
    Sign Delivery Checklist
    Verify Delivery Success    確認交車成功

Take plate by self then delivery scooter
    [Tags]    CID:5175
    # [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}     licensing_location=自領牌     licensing_location_id=DMV_ZL
    [Setup]    Test Setup For Creating Scooter Order    pasw007@yopmail.com     licensing_location=自領牌     licensing_location_id=DMV_ZL
    Status From Wait Delivery Scooter To Delivery Scooter
    Confirm Pre-Delivery Scooter Checklist    self
    Confirm Delivery Scooter Checklist    self
    Sign Delivery Checklist
    Verify Delivery Success    確認交車成功

Take plate by self then delivery scooter with different owner and driver
    [Tags]    CID:5176
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_OWNER_EMAIL}    ${SALES_PORTAL_DRIVER_EMAIL}     licensing_location=自領牌     licensing_location_id=DMV_ZL
    Status From Wait Delivery Scooter To Delivery Scooter
    Confirm Pre-Delivery Scooter Checklist    self
    Confirm Delivery Scooter Checklist    self
    Sign Delivery Checklist
    Verify Delivery Success    確認交車成功

*** Keywords ***
Assign Scooter From Scooters Infos
    [Arguments]    ${dms_order_no}
    Sync Assign Scooter Information To DMS    ${dms_order_no}    ${scooter.scooter_vin}    ${scooter.matnr}
    Scooters Infos Update    ${dms_order_no}    ${scooter.scooter_vin}
    ...    ${driver.user_id}    ${owner.user_id}    ${owner.user_guid}    0
    ...    turn_light=1    brake_light=1    tpms=0    sport_mode=1

Go Support Process
    Login Go Support
    Click Take Plate Flow Confirmation Button
    Search Order With Order Number    ${dms_order_no}
    Receive Order Case
    Upload Process In Go Support
    Confirm Scooter License Data

Setup Scooter Variables
    [Arguments]    ${scooter_model}=GSBH2-000-CF
    Set Test Variable    ${scooter}    ${Scooters('${scooter_model}')}

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

Suite Setup
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Set Suite Variable    ${token}    ${get_token}
    Login With Direct Login
    Click Button In Main Body    待處理訂單
    Verify Page URL    ${SALES_PORTAL_URL}/order/manage

Test Setup For Creating Scooter Order
    [Arguments]    ${buyer_email}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}    ${licensing_location}=台北領牌中心    ${licensing_location_id}=DMV_TP    ${agency_fee}=2215
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    Setup Scooter Variables
    ${dms_order_no} =    Create Scooter Order    ${buyer}    臺北市    2004    SUBFEE-00049    ${licensing_location}    ${licensing_location_id}    ${agency_fee}    ${token}    Owner=${owner}    Driver=${driver}
    Set Test Variable    ${dms_order_no}

Test Teardown
    Go To    ${SALES_PORTAL_URL}/order/manage
    Reload Page

User Information Setup
    [Arguments]    ${buyer_email}    ${owner_email}    ${driver_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}
