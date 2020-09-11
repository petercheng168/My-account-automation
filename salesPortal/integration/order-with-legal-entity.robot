*** Settings ***
Documentation    Test suite of scooter order with legal entity
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Teardown    Return To Scooter Page
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Change legal entity order to redeem status
    [Tags]    CID:5206
    [Setup]    Setup Legal Entity Order    1
    Update Order From Waiting Checkout To Waiting Redemption    ${dms_order_no}
    Search With Order Number    ${dms_order_no}
    Verify Order In Correct State List    5    待受贈者    ${dms_order_no}

Change tariff plan by owner is legal
    [Tags]    CID:11284
    [Setup]    Test Setup For Create Scooter Order With Owner Assign To Legal
    Search Order info With Order Number    ${dms_order_no}    資費方案
    Click Change Tariff Plan
    Change Tariff Plan    $999 騎到飽方案
    Click Skip Legal Sign Button
    Verify Change Tariff Plan     $999 騎到飽方案

Check documentation fee
    [Tags]    CID:5207
    [Setup]    Start Legal Entity Order Flow
    Fill Legal Entity Order Shopping List
    Fill Legal Entity Order Buyer Information
    Fill Legal Entity Order Subsidy Information
    Verify Order Payment Information

Check legal entity page information
    [Tags]    CID:5208
    Check Scrollbar Loading State
    Click Button To Start Legal Entity Order
    Verify Order With Legal Entity Begin Status

Check payment data with gogoro user pay
    [Tags]    CID:5210
    [Setup]    Setup Legal Entity Order    2
    Update Order From Waiting Checkout To Waiting Redemption    ${dms_order_no}
    Customer Starts Redeem Process    ${dms_order_no}
    Customer Changes Scooter Color    深焙棕
    Click Confirm Subsidy Hint Button
    Get Plate And Subsidy Information    gogoro
    Verify Payment Data With Gogoro User Pay

Check payment data with legal_entity pay
    [Tags]    CID:5211
    [Setup]    Setup Legal Entity Order    1
    Update Order From Waiting Checkout To Waiting Redemption    ${dms_order_no}
    Customer Starts Redeem Process    ${dms_order_no}
    Customer Changes Scooter Color    深焙棕
    Click Confirm Subsidy Hint Button
    Get Plate And Subsidy Information    self
    Verify Payment Data With Legal Entity Pay

Create legal entity order
    [Tags]    CID:5209
    [Setup]    Start Legal Entity Order Flow
    Fill Legal Entity Order Shopping List
    Fill Legal Entity Order Buyer Information
    Fill Legal Entity Order Subsidy Information
    Click Continue Button In Scooter Order    4
    Upload Legal Entity Document    Gogoro補助放棄切結書(僅放棄地方)(法人用印)    ${XPATH_LEGAL_GIVEUP_SUBSIDY_UPLOAD_INPUT}
    Upload Legal Entity Document    訂購合約(法人用印)    ${XPATH_LEGAL_CREATE_ORDER_INPUT}
    Click Finish Sign Up Button
    Verify Order Success Page

Create scooter order - owner assign to legal
    [Tags]    CID:11283
    [Setup]    Test Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}
    Click Checkout Button
    Fill Gogoro Account As Buyer    ${SALES_PORTAL_BUYER_EMAIL}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Add Event And Project In Shopping List    Gogoro 全車系 限時免費 保固2+1年 購車送第3年延保    Gogoro 3系列全新改款送藍牙耳機與安全帽
    Click Checkbox For Scooter Order Risk
    Fill Owner Of Legal Information    53433060    龍美窗簾    0916831111    臺北市    中正區    中正路123號
    Run Keyword If    '${ENV}' == 'swqa'    Select Deliver Information Flow    北    Gogoro門市    光華八德店
    Fill Subsidy Information For Get Scooter Plate    1
    Fill Payment Type Information    1
    Select Plan And Addon    $499 騎到飽方案
    Click Skip Legal Sign Button
    Verify Create Scooter Order - Owner Assign To Legal    龍美窗簾    0916831111    53433060    臺北市中正區中正路123號

Customer redeems legal entity order (gogoro plate)
    [Tags]    CID:5212
    [Setup]    Setup Legal Entity Order    2
    Update Order From Waiting Checkout To Waiting Redemption    ${dms_order_no}
    Customer Starts Redeem Process    ${dms_order_no}
    Customer Changes Scooter Color    深焙棕
    Click Confirm Subsidy Hint Button
    Get Plate And Subsidy Information    gogoro
    Click Continue Button In Scooter Order    4
    Select Plan And Addon    預選里程方案 630
    Sign Up Es-Contract
    Search With Order Number    ${dms_order_no}
    Verify Order Status After Signing ES-contract    法人贈車    訂單成立    待結帳

Customer redeems legal entity order (self plate)
    [Tags]    CID:5213
    [Setup]    Setup Legal Entity Order    1
    Update Order From Waiting Checkout To Waiting Redemption    ${dms_order_no}
    Customer Starts Redeem Process    ${dms_order_no}
    Customer Changes Scooter Color    深焙棕
    Click Confirm Subsidy Hint Button
    Get Plate And Subsidy Information    self
    Click Continue Button In Scooter Order    4
    Select Plan And Addon    預選里程方案 630
    Sign Up Es-Contract
    Search With Order Number    ${dms_order_no}
    Verify Order Status After Signing ES-contract    法人贈車    訂單成立    待結帳

*** Keywords ***
Return To Order Page
    Go To    ${SALES_PORTAL_URL}/order/manage
    Reload Page

Return To Scooter Page
    Go To    ${SALES_PORTAL_URL}/home
    Click Button In Main Body    智慧雙輪

Select Scooter Flow With Legal
    [Arguments]    ${scooter_type}    ${scooter_model}    ${scooter_color_no}    ${scooter_color}
    Check Scrollbar Loading State
    Select Scooter Type And Model And Color    ${scooter_type}    ${scooter_model}    ${scooter_color_no}
    Click Checkout Button
    Check Scooter Stock And Type    ${scooter_model}    ${scooter_color}

Setup Legal Entity Order
    [Arguments]    ${document_payer}
    ${dms_order_no} =    Create Legal Entity Order    自領牌    DMV_ZL    ${document_payer}    ${token}
    Set Test Variable    ${dms_order_no}

Start Legal Entity Order Flow
    Check Scrollbar Loading State
    Click Button To Start Legal Entity Order
    Verify Order With Legal Entity Begin Status

Suite Setup
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Set Suite Variable    ${token}    ${get_token}
    Login With Direct Login
    Click Button In Main Body    智慧雙輪

Test Setup
    [Arguments]    ${buyer_email}    ${owner_email}    ${driver_email}
    Login With Direct Login
    Click Button In Main Body    智慧雙輪
    Verify Page URL    ${SALES_PORTAL_URL}/scooter
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}

Test Setup For Create Scooter Order With Owner Assign To Legal
    Go To    ${SALES_PORTAL_URL}/order/manage
    User Information Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_LEGAL_ENTITY_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}
    ${dms_order_no} =    Create Scooter Order    ${buyer}    臺北市    2004    SUBFEE-00036    台北領牌中心    DMV_TP    2215    ${token}    ${owner}    ${driver}    GSPE2-000-GP    Gogoro S3
    Set Test Variable    ${dms_order_no}

User Information Setup
    [Arguments]    ${buyer_email}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}
