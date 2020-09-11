*** Settings ***
Documentation    Test suite of Sales_Portal Homepage 
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Login With Direct Login
Suite Teardown    Close All Browsers
Test Teardown    Go To    ${SALES_PORTAL_URL}/home
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Main button url
    [Tags]    CID:6905
    [Template]    Verify Main Button URL
    試乘參觀      /testride/2
    潛客管理      /prospect/index
    智慧雙輪      /scooter
    待處理訂單    /order/manage
    精品配件      /store

Multiple layer menu url
    [Tags]    CID:6915
    [Template]    Verify Multiple Layer Menu URL
    試乘參觀    進店試乘        /testride    /2
    試乘參觀    參觀不試乘      /testride    /1
    潛客管理    總覽           /prospect    /index
    潛客管理    清單查詢        /prospect    /customer-search
    潛客管理    週曆檢視        /prospect    /customer-calendar
    潛客管理    報價單         /prospect    /quotations
    潛客管理    待聯繫         /prospect    /pending-contact
    潛客管理    罐頭訊息       /prospect    /template-message
    潛客管理    常用篩選       /prospect    /prospect
    潛客管理    自動寄發設定    /prospect    /automation-settings
    潛客管理    預約試乘設定    /prospect    /reservation
    潛客管理    快速建立       /prospect    /quick-create

Single layer menu url
    [Tags]    CID:6911
    [Template]    Verify Single Layer Menu URL
    智慧雙輪      /scooter
    待處理訂單    /order/manage
    精品配件      /store
    訂單移轉      /order/handover

*** Keywords ***
Verify Main Button URL
    [Arguments]    ${name}    ${url}
    Click Button In Main Body    ${name}
    Verify Page URL    ${SALES_PORTAL_URL}${url}
    [Teardown]    Go To    ${SALES_PORTAL_URL}/home

Verify Multiple Layer Menu URL
    [Arguments]    ${first_name}    ${second_name}    ${first_url}    ${second_url}
    Click First Layer Item In Menu    ${first_url}
    Click Second Layer Item In Menu    ${first_url}${second_url}
    Verify Page URL    ${SALES_PORTAL_URL}${first_url}${second_url}

Verify Single Layer Menu URL
    [Arguments]    ${name}    ${url}
    Click First Layer Item In Menu    ${url}
    Verify Page URL    ${SALES_PORTAL_URL}${url}
