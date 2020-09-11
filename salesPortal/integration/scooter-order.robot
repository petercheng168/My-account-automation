*** Settings ***
Documentation    Test suite of Sales_Portal Make Scooter Order Page
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Timeout    1200

*** Variables ***
${scooter_list_1}    Gogoro 1 系列
${scooter_list_2}    Gogoro 2 系列
${scooter_list_3}    Gogoro 3 系列
${scooter_list_S}    S Performance
${scooter_list_V}    Gogoro VIVA

*** Test Cases ***
Create scooter order
    [Tags]    CID:6616
    [Template]    Verify Create Scooter Order
    Create scooter order with cash                                   ${buyer.email}           ${buyer.email}           ${buyer.email}           ${scooter_list_S}    Gogoro S2 Café Racer (MY19)    1    深焙棕      1    1    1    TES補助款發票    $899 騎到飽方案
    Create scooter order with cash and female buyer                  ${female_buyer.email}    ${female_buyer.email}    ${female_buyer.email}    ${scooter_list_V}    Gogoro VIVA                    4    石榴紅      1    1    1    TES補助款發票    $499 騎到飽方案
    Create scooter order with cash                                   ${buyer.email}           ${buyer.email}           ${buyer.email}           ${scooter_list_S}    Gogoro S3                      1    石墨灰      1    1    1    TES補助款發票    $1199 騎到飽方案
    Create scooter order with cash but different driver              ${buyer.email}           ${buyer.email}           ${driver.email}          ${scooter_list_1}    Gogoro 1 Plus (MY19)           1    灰         2    1    1    TES補助款發票    $999 騎到飽方案
    Create scooter order with cash but different owner               ${buyer.email}           ${owner.email}           ${buyer.email}           ${scooter_list_2}    Gogoro 2 Delight (MY19)        1    粉紅突襲    3    1    1    TES補助款發票    $1199 騎到飽方案
    Create scooter order with cash but different owner and driver    ${buyer.email}           ${owner.email}           ${driver.email}          ${scooter_list_3}    New Gogoro 3                   2    漿果紅      4    1    1    TES補助款發票    預選里程方案 630
    Create scooter order with credit card                            ${buyer.email}           ${buyer.email}           ${buyer.email}           ${scooter_list_3}    Gogoro 3 Plus                  2    楓糖摩卡    1    1    3    尾款發票    預選里程方案 315
    Create scooter order with credit card and female buyer           ${female_buyer.email}    ${female_buyer.email}    ${female_buyer.email}    ${scooter_list_3}    Gogoro 3 Plus                  2    楓糖摩卡    1    1    3    尾款發票    商用資費方案
    Create scooter order with loan                                   ${buyer.email}           ${buyer.email}           ${buyer.email}           ${scooter_list_3}    Gogoro 3 Plus                  1    檸檬雪酪    1    1    2    尾款發票    $299 自由省方案
    Create scooter order with loan and female buyer                  ${female_buyer.email}    ${female_buyer.email}    ${female_buyer.email}    ${scooter_list_V}    Gogoro VIVA                    2    海鹽白      1    1    2    尾款發票    $449 騎到飽方案
    Create latest model scooter order                                ${buyer.email}           ${buyer.email}           ${buyer.email}           ${scooter_list_V}    Gogoro VIVA                    3    橄欖灰      1    1    1    TES補助款發票    $399 騎到飽方案

Deliver scooter location
    [Tags]    CID:6631
    [Template]    Verify Deliver Scooter Location
    北    交車中心       板橋廣權交車中心     $1199 騎到飽方案
    北    服務中心       新莊中正服務中心     $999 騎到飽方案
    中    交車中心       台中站前交車中心     $899 騎到飽方案
    中    服務中心       大里德芳服務中心     $299 自由省方案
    中    Gogoro門市    台中中港門市         $1199 騎到飽方案
    南    交車中心       高雄中正交車中心      $999 騎到飽方案
    南    服務中心       永康中山南服務中心    $899 騎到飽方案
    南    Gogoro門市    左營博愛店           $1199 騎到飽方案

Get scooter order quotation
    [Tags]    CID:6651
    [Setup]    Login Sales Portal
    Check Scrollbar Loading State
    Click Show Quotation Button
    Fill Customer Information In Quotation Page    ${name}    ${email}    ${phone}
    Click Checkbox For Agreement Quotation
    Click Send Quotation Email Button
    Switch Window Tab    1
    Check Quotation PDF Loading State
    Verify Default Subsidy City    基隆市汰購二行程
    Verify Email Exists    ${SALES_PORTAL_GMAIL_SENDER}    ${email}    ${GMAIL_PASSWORD}
    [Teardown]    Test Teardown

Go to gogoro default scooter page
    [Tags]    CID:6649
    [Setup]    Login Sales Portal
    Check Scrollbar Loading State
    Click Hyperlink On Scooter Homepage    了解更多
    Switch Window Tab    1
    Verify Page URL    https://www.gogoro.com/tw/smartscooter/viva/
    [Teardown]    Test Teardown

Go to model compare page
    [Tags]    CID:6650
    [Setup]    Login Sales Portal
    Check Scrollbar Loading State
    Click Hyperlink On Scooter Homepage    款式比較
    Switch Window Tab    1
    Verify Page URL    https://www.gogoro.com/tw/smartscooter/specs/?models=gogoro-viva-plus
    [Teardown]    Test Teardown

*** Keywords ***
Credit Card Setup
    Set Suite Variable    ${card}    ${CreditCards()}

Fill Order Information
    [Arguments]    ${order_type}
    Run Keyword If    '${order_type}' == '1'    Step 2 Order Information
    ...    ELSE IF    '${order_type}' == '2'    Step 2 Order Information With Different Driver
    ...    ELSE IF    '${order_type}' == '3'    Step 2 Order Information With Different Owner
    ...    ELSE IF    '${order_type}' == '4'    Step 2 Order Information With Different Owner And Driver

Login Sales Portal
    Login With Direct Login
    Click Button In Main Body    智慧雙輪
    Verify Page URL    ${SALES_PORTAL_URL}/scooter

Select Scooter Flow
    [Arguments]    ${scooter_type}    ${scooter_model}    ${scooter_color_no}    ${scooter_color}
    Check Scrollbar Loading State
    Select Scooter Type And Model And Color    ${scooter_type}    ${scooter_model}    ${scooter_color_no}
    Click Checkout Button
    Check Scooter Stock And Type    ${scooter_model}    ${scooter_color}

Suite Setup
    ${name} =    Generate Random String    4    [NUMBERS]
    ${phone} =    Generate Random String    8    [NUMBERS]
    Credit Card Setup
    Set Suite Variable    ${name}    SWQA-${name}
    Set Suite Variable    ${phone}    09${phone}
    Set Suite Variable    ${email}    sw.verify+${phone}@gogoro.com
    Set Suite Variable    ${buyer}    ${Roles('${SALES_PORTAL_BUYER_EMAIL}')}
    Set Suite Variable    ${owner}    ${Roles('${SALES_PORTAL_OWNER_EMAIL}')}
    Set Suite Variable    ${driver}    ${Roles('${SALES_PORTAL_DRIVER_EMAIL}')}
    Set Suite Variable    ${female_buyer}    ${Roles('${SALES_PORTAL_FEMALE_BUYER_EMAIL}')}

Test Setup
    [Arguments]    ${buyer_email}    ${owner_email}    ${driver_email}
    Login Sales Portal
    Maximize Browser Window
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}

Test Teardown
    Close Window
    Switch Window Tab    0
    Reload Page
    Click Logout Button
    Close All Browsers

Test Teardown For Create Scooter Order
    Click Logout Button
    Close All Browsers

User Information Setup
    [Arguments]    ${buyer_email}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}

Verify Create Scooter Order
    [Arguments]    ${case_name}    ${buyer_email}    ${owner_email}    ${driver_email}
    ...    ${scooter_type}    ${scooter_model}    ${scooter_color_no}
    ...    ${scooter_color}    ${order_information_type}    ${subsidy_type}
    ...    ${payment_type}    ${invoice_type}    ${plan}
    ...    ${first_event}=Gogoro 全車系 限時免費 保固2+1年 購車送第3年延保
    ...    ${second_event}=Gogoro 3系列全新改款送藍牙耳機與安全帽
    Test Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    Select Scooter Flow    ${scooter_type}    ${scooter_model}    ${scooter_color_no}    ${scooter_color}
    Fill Gogoro Account As Buyer    ${buyer_email}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Add Event And Project In Shopping List    ${first_event}    ${second_event}
    Fill Order Information    ${order_information_type}
    Run Keyword If    '${ENV}' == 'swqa'    Select Deliver Information Flow    北    Gogoro門市    光華八德店
    Fill Subsidy Information For Get Scooter Plate    ${subsidy_type}
    Fill Payment Type Information    ${payment_type}
    Select Plan And Addon    ${plan}
    Click Skip Sign Button
    Verify Create Scooter Order Success    ${buyer}    ${owner}    ${driver}    ${scooter_model}    ${invoice_type}
    [Teardown]    Test Teardown For Create Scooter Order

Verify Deliver Scooter Location
    [Arguments]    ${deliver_area}    ${deliver_type}    ${deliver_store}    ${plan}
    Test Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}
    Select Scooter Flow    ${scooter_list_S}    ${scooter_model_S}    1    深焙棕
    Fill Gogoro Account As Buyer    ${SALES_PORTAL_BUYER_EMAIL}    ${buyer.part_phone}
    Click Button To Send out Gogoro Account
    Add Event And Project In Shopping List    Gogoro 全車系 限時免費 保固2+1年 購車送第3年延保    Gogoro 3系列全新改款送藍牙耳機與安全帽
    Fill Order Information    1
    Select Deliver Information Flow    ${deliver_area}    ${deliver_type}    ${deliver_store}
    Fill Subsidy Information For Get Scooter Plate    1
    Fill Payment Type Information    1
    Select Plan And Addon    ${plan}
    Click Skip Sign Button
    Verify Create Scooter Order Success With Assign Deliver Store    ${buyer}    ${owner}    ${driver}    ${scooter_model_S}    TES補助款發票    ${deliver_store}
    [Teardown]    Test Teardown For Create Scooter Order
