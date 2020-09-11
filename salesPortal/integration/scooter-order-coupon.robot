*** Settings ***
Documentation    Test suite of Sales_Portal Using Coupon
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Timeout    1200

*** Variables ***
${illegal_format_coupon}    error format coupon code
${illegal_format_phone_num}    1234567890
${empty_coupon}    ${EMPTY}
${empty_phone_num}    ${EMPTY}
${scooter_list_S}    S Performance

*** Test Cases ***
Select telecom coupon
    [Tags]    CID:6640
    [Template]    Verify Telecom Coupon Display
    S Performance    Gogoro S2 Café Racer (MY19)    1    深焙棕    超5G潮綠能- 折價9100    台灣大哥大   -$9,100
    S Performance    Gogoro S2 Café Racer (MY19)    1    深焙棕    超級騎機-折價 3100      遠傳電信    -$3,100

Select telecom coupon - CHT
    [Tags]    CID:11278    disable_feature
    Check Scrollbar Loading State
    Click Checkout Button
    Check Scooter Stock And Type    Gogoro S3    石墨灰
    Fill Gogoro Account As Buyer    ${SALES_PORTAL_BUYER_EMAIL}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Click Restart Button
    Select Telecom Coupon Flow    中華電信   CHT電信折扣9,000 (999*24)    X1A2422222    0988058853
    Verify Telecom Coupon And Discount Price    CHT電信折扣9,000 (999*24)    -$9,000
    [Teardown]    Test Teardown For Coupon

Select telecom coupon for CHT with illegal phone number
    [Tags]    CID:11279
    Check Scrollbar Loading State
    Click Checkout Button
    Check Scooter Stock And Type    ${scooter_model_S}    深焙棕
    Fill Gogoro Account As Buyer    ${SALES_PORTAL_BUYER_EMAIL}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Click Restart Button
    Select Telecom Coupon Flow    中華電信    CHT電信折扣9,000 (999*24)    X1A2411111    ${illegal_format_phone_num}
    Verify Telecom Coupon With Error Input    ${XPATH_CHT_PHONE_NUM_ERROR_TEXT}    電話號碼格式錯誤，請重新輸入
    [Teardown]    Test Teardown For Coupon

Select telecom coupon for CHT without phone number
    [Tags]    CID:11280
    Check Scrollbar Loading State
    Click Checkout Button
    Check Scooter Stock And Type    ${scooter_model_S}    深焙棕
    Fill Gogoro Account As Buyer    ${SALES_PORTAL_BUYER_EMAIL}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Click Restart Button
    Select Telecom Coupon Flow    中華電信    CHT電信折扣9,000 (999*24)    X1A2411111    ${empty_phone_num}
    Verify Telecom Coupon With Error Input    ${XPATH_CHT_PHONE_NUM_ERROR_TEXT}    請輸入折價券電話號碼
    [Teardown]    Test Teardown For Coupon

Select telecom coupon with illegal format coupon
    [Tags]    CID:11281
    Check Scrollbar Loading State
    Click Checkout Button
    Check Scooter Stock And Type    ${scooter_model_S}    深焙棕
    Fill Gogoro Account As Buyer    ${SALES_PORTAL_BUYER_EMAIL}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Click Restart Button
    Select Telecom Coupon Flow    台灣大哥大    超5G潮綠能- 折價9100    ${illegal_format_coupon}    ${empty_phone_num}
    Verify Telecom Coupon With Error Input    ${XPATH_SCOOTER_COUPON_CODE_ERROR_TEXT}    折價券格式錯誤，請重新輸入
    [Teardown]    Test Teardown For Coupon

Select telecom coupon without coupon code
    [Tags]    CID:11282
    Check Scrollbar Loading State
    Click Checkout Button
    Check Scooter Stock And Type    ${scooter_model_S}    深焙棕
    Fill Gogoro Account As Buyer    ${SALES_PORTAL_BUYER_EMAIL}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Click Restart Button
    Select Telecom Coupon Flow    台灣大哥大    超5G潮綠能- 折價9100    ${empty_coupon}    ${empty_phone_num}
    Verify Telecom Coupon With Error Input    ${XPATH_SCOOTER_COUPON_CODE_ERROR_TEXT}    請輸入折價券序號
    [Teardown]    Test Teardown For Coupon

*** Keywords ***
Login Sales Portal
    Login With Direct Login
    Click Button In Main Body    智慧雙輪
    Verify Page URL    ${SALES_PORTAL_URL}/scooter

Suite Setup
    Login Sales Portal
    Set Suite Variable    ${buyer}    ${Roles('${SALES_PORTAL_BUYER_EMAIL}')}

Telecom Coupon Setup
    [Arguments]    ${coupon_name}
    ${get_token} =    Get SP Token    QA00001    ${SALES_PASSWORD}
    Set Suite Variable    ${token}    ${get_token}
    Generate Random EVT Number
    Generate Discount Coupon    ${coupon_name}

Test Setup For Select telecom coupon
    [Arguments]    ${SALES_PORTAL_BUYER_EMAIL}    ${coupon_name}
    Login Sales Portal
    Telecom Coupon Setup    ${coupon_name}

Test Teardown For Coupon
    Click Logout Button
    Close Window
    Login With Direct Login
    Click Button In Main Body    智慧雙輪
    Verify Page URL    ${SALES_PORTAL_URL}/scooter

Verify Telecom Coupon Display
    [Arguments]    ${scooter_list_S}    ${scooter_model_S}    ${scooter_color_num}
    ...    ${scooter_color}    ${coupon}    ${telecom}    ${discount_amount}
    Test Setup For Select telecom coupon    ${SALES_PORTAL_BUYER_EMAIL}    ${coupon}
    Check Scrollbar Loading State
    Select Scooter Type And Model And Color    ${scooter_list_S}    ${scooter_model_S}    ${scooter_color_num}
    Click Checkout Button
    Check Scooter Stock And Type    ${scooter_model_S}    ${scooter_color}
    Fill Gogoro Account As Buyer    ${SALES_PORTAL_BUYER_EMAIL}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Click Restart Button
    Select Telecom Coupon Flow    ${telecom}   ${coupon}    ${coupon_code}    ${EMPTY}
    Verify Telecom Coupon And Discount Price    ${coupon}    ${discount_amount}
    [Teardown]    Test Teardown For Coupon
