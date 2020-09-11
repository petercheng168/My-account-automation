*** Settings ***
Documentation    Test suite of Sales_Portal Order Page With Modifying Flow
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Teardown    Test Teardown
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Change Tariff Plan - Before Payment
    [Tags]    CID:11285
    [Template]    Verify Change Tariff Plan - Before Payment
    ${S2 Cafe Racer}    ${scooter_model_S}    ${預選里程630}    $899 騎到飽方案
    ${Viva}    ${scooter_model_V}    ${單電池$299 自由省方案}    $499 騎到飽方案

Change Tariff Plan With Addon - Before Payment
    [Tags]    CID:11286
    [Template]    Verify Change Tariff Plan With Addon - Before Payment
    ${S2 Cafe Racer}    ${scooter_model_S}    ${預選里程630}    $899 騎到飽方案    30 天免費性能提升服務試用方案
    ${Viva}    ${scooter_model_V}    SUBFEE-00053    $499 騎到飽方案    30 天免費性能提升服務試用方案

Change To Flex Plan - Before Payment
    [Tags]    CID:11287
    Test Setup For Change Tariff Plan    ${Viva}    ${scooter_model_V}    ${$499 騎到飽方案}
    Click Order State Button    3    待結帳
    Search Order info With Order Number    ${dms_order_no}    資費方案
    Click Change Tariff Plan
    Change To Flex Plan
    Sign Up Es-Contract For Order Modify
    Verify Change To Flex Plan
    [Teardown]    Test Teardown

Modify order on waiting checkout the bill with different driver
    [Tags]    CID:5177
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Modify User Information Setup    driver_email=${SALES_PORTAL_DRIVER_EMAIL}
    Click Order State Button    3    待結帳
    Search Order With Order Number In Sales Portal    ${dms_order_no}    修改訂單
    Add Event And Project In Shopping List    Gogoro 全車系 限時免費 保固2+1年 購車送第3年延保    Gogoro 3系列全新改款送藍牙耳機與安全帽
    Step 2 Modify Order Information With Different Driver
    Click Checkbox For Car Insurance    true
    Click Apply Recycle Radio Button    是
    Click Continue Button In Scooter Order    3
    Fill Payment Type Information    1
    Click Skip Sign Button
    Verify Create Scooter Order Success    ${buyer}    ${buyer}    ${driver}    ${SALES_PORTAL_SCOOTER_MODEL}    TES補助款發票
    [Teardown]    Test Teardown

Modify order on waiting checkout the bill with different gender owner
    [Tags]    CID:5178
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Modify User Information Setup    ${SALES_PORTAL_FEMALE_BUYER_EMAIL}
    Click Order State Button    3    待結帳
    Search Order With Order Number In Sales Portal    ${dms_order_no}    修改訂單
    Add Event And Project In Shopping List    Gogoro 全車系 限時免費 保固2+1年 購車送第3年延保    Gogoro 3系列全新改款送藍牙耳機與安全帽
    Step 2 Modify Order Information With Different Owner
    Click Checkbox For Car Insurance    true
    Click Continue Button In Scooter Order    3
    Fill Payment Type Information    1
    Click Skip Sign Button
    Verify Create Scooter Order Success    ${buyer}    ${owner}    ${buyer}    ${SALES_PORTAL_SCOOTER_MODEL}    TES補助款發票
    [Teardown]    Test Teardown

Modify order on waiting checkout the bill with different owner
    [Tags]    CID:5179
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Modify User Information Setup    ${SALES_PORTAL_OWNER_EMAIL}
    Click Order State Button    3    待結帳
    Search Order With Order Number In Sales Portal    ${dms_order_no}    修改訂單
    Add Event And Project In Shopping List    Gogoro 全車系 限時免費 保固2+1年 購車送第3年延保    Gogoro 3系列全新改款送藍牙耳機與安全帽
    Step 2 Modify Order Information With Different Owner
    Click Checkbox For Car Insurance    true
    Click Continue Button In Scooter Order    3
    Fill Payment Type Information    1
    Click Skip Sign Button
    Verify Create Scooter Order Success    ${buyer}    ${owner}    ${buyer}    ${SALES_PORTAL_SCOOTER_MODEL}    TES補助款發票
    [Teardown]    Test Teardown

Modify order on waiting checkout the bill with different owner and driver
    [Tags]    CID:5180
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Modify User Information Setup    ${SALES_PORTAL_OWNER_EMAIL}    ${SALES_PORTAL_DRIVER_EMAIL}
    Click Order State Button    3    待結帳
    Search Order With Order Number In Sales Portal    ${dms_order_no}    修改訂單
    Add Event And Project In Shopping List    Gogoro 全車系 限時免費 保固2+1年 購車送第3年延保    Gogoro 3系列全新改款送藍牙耳機與安全帽
    Step 2 Modify Order Information With Different Owner And Driver
    Click Checkbox For Car Insurance    true
    Click Continue Button In Scooter Order    3
    Fill Payment Type Information    1
    Click Skip Sign Button
    Verify Create Scooter Order Success    ${buyer}    ${owner}    ${driver}    ${SALES_PORTAL_SCOOTER_MODEL}    TES補助款發票
    [Teardown]    Test Teardown

Modify order on waiting checkout the bill with different payment type
    [Tags]    CID:5181
    [Setup]    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Click Order State Button    3    待結帳
    Search Order With Order Number In Sales Portal    ${dms_order_no}    修改訂單
    Add Event And Project In Shopping List    Gogoro 全車系 限時免費 保固2+1年 購車送第3年延保    Gogoro 3系列全新改款送藍牙耳機與安全帽
    Click Continue Button In Scooter Order    2
    Click Checkbox For Car Insurance    true
    Click Apply Recycle Radio Button    是
    Click Continue Button In Scooter Order    3
    Fill Payment Type Information    2
    Click Skip Sign Button
    Verify Create Scooter Order Success    ${buyer}    ${buyer}    ${buyer}    ${SALES_PORTAL_SCOOTER_MODEL}    尾款發票
    [Teardown]    Test Teardown

Modify order on waiting sign state
    [Tags]    Manually
    [Documentation]    Modify scooter contract on 待簽約 state
    [Template]    Log
    Given an order without plan
    And order's flow status is 待簽約
    When we modify the order on sales portal
    Then the order's information should be modified

*** Keywords ***
Modify User Information Setup
    [Arguments]    ${owner_email}=${SALES_PORTAL_BUYER_EMAIL}    ${driver_email}=${SALES_PORTAL_BUYER_EMAIL}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}

Suite Setup
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Set Suite Variable    ${token}    ${get_token}
    Login With Direct Login
    Click Button In Main Body    待處理訂單
    Maximize Browser Window
    Verify Page URL    ${SALES_PORTAL_URL}/order/manage

Test Setup For Creating Scooter Order
    [Arguments]    ${buyer_email}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}    ${agency_fee}=2215
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    ${dms_order_no} =    Create Scooter Order    ${buyer}    臺北市    2004    SUBFEE-00040    台北領牌中心    DMV_TP    ${agency_fee}    ${token}    Owner=${owner}    Driver=${driver}
    Set Test Variable    ${dms_order_no}

Test Setup For Change Tariff Plan
    [Arguments]    ${scooter_model}    ${product_name}    ${legacy_plan_code}
    User Information Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}
    ${dms_order_no} =    Create Scooter Order    ${buyer}    臺北市    2004    ${legacy_plan_code}    台北領牌中心    DMV_TP    2215    ${token}    Owner=${owner}    Driver=${driver}    scooter_model=${scooter_model}    product_name=${product_name}
    Set Test Variable    ${dms_order_no}

Test Teardown
    Go To    ${SALES_PORTAL_URL}/order/manage
    Reload Page

User Information Setup
    [Arguments]    ${buyer_email}    ${owner_email}    ${driver_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}

Verify Change Tariff Plan - Before Payment
    [Arguments]    ${scooter_model}    ${product_name}    ${default_tariff_plan}    ${change_tariff_plan}
    Test Setup For Change Tariff Plan    ${scooter_model}    ${product_name}    ${default_tariff_plan}
    Click Order State Button    3    待結帳
    Search Order info With Order Number    ${dms_order_no}    資費方案
    Click Change Tariff Plan
    Change Tariff Plan    ${change_tariff_plan}
    Sign Up Es-Contract For Order Modify
    Verify Change Tariff Plan     ${change_tariff_plan}
    [Teardown]    Test Teardown

Verify Change Tariff Plan With Addon - Before Payment
    [Arguments]    ${scooter_model}    ${product_name}    ${default_tariff_plan}    ${change_tariff_plan}    ${input_addon}
    Test Setup For Change Tariff Plan    ${scooter_model}    ${product_name}    ${default_tariff_plan}
    Click Order State Button    3    待結帳
    Search Order info With Order Number    ${dms_order_no}    資費方案
    Click Change Tariff Plan
    Change Tariff Plan With Addon    ${change_tariff_plan}
    Sign Up Es-Contract For Order Modify
    Verify Change Tariff Plan With Addon     ${change_tariff_plan}    ${input_addon}
    [Teardown]    Test Teardown

