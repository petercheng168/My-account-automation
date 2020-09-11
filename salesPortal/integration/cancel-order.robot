*** Settings ***
Documentation    Test suite of Sales_Portal Order Page of Cancel order
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Teardown    Reload Page
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Cancel accessory order then check order status
    [Tags]    CID:6899
    [Template]    Verify Cancel Accessory Order
    直營調撥授權
    貨故
    專案退回
    出貨失敗
    顧關零件

Cancel scooter order then check order status
    [Tags]    CID:6890
    [Template]    Verify Cancel Scooter Order
    同廠牌競價
    他廠牌競價
    家人反對
    貸款未核准
    價格太貴
    配備不齊全
    交車時間過長
    原廠停產
    其他原因
    無效訂單

*** Keywords ***
Create An Accessory Order
    Click Accessories Beginning Button
    Add Accessory To Shopping Cart To Create An Order    杯架
    Choose Buyer Information With Company Invoice
    ${dms_order_no} =    Check Order Success Page
    Set Test Variable    ${dms_order_no}

Find Order And Do The Cancel Process - Accessory
    [Arguments]    ${dms_order_no}    ${cancel_reason}
    Search With Order Number    ${dms_order_no}
    Click Cancel Button    ${dms_order_no}
    Choose Cancel Reason of Accessories    ${cancel_reason}
    Press Confirm Button

Find Order And Do The Cancel Process - Scooter
    [Arguments]    ${dms_order_no}    ${cancel_reason}
    Search With Order Number    ${dms_order_no}
    Click Cancel Button    ${dms_order_no}
    Choose Cancel Reason of Scooter    ${cancel_reason}
    Press Confirm Button

Suite Setup
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Set Suite Variable    ${token}    ${get_token}
    Login With Direct Login
    Click Button In Main Body    待處理訂單
    Verify Page URL    ${SALES_PORTAL_URL}/order/manage

Test Setup For Creating Scooter Order
    [Arguments]    ${buyer_email}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}    ${agency_fee}=2215
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    ${dms_order_no} =    Create Scooter Order    ${buyer}    臺北市    2004    SUBFEE-00049    台北領牌中心    DMV_TP    ${agency_fee}    ${token}    Owner=${owner}    Driver=${driver}
    Set Test Variable    ${dms_order_no}

User Information Setup
    [Arguments]    ${buyer_email}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}

Verify Cancel Accessory Order
    [Arguments]    ${cancel_reason}
    Create An Accessory Order
    Find Order And Do The Cancel Process - Accessory    ${dms_order_no}    ${cancel_reason}
    Search With Order Number    ${dms_order_no}
    Verify Order Information    訂單狀態    已退購

Verify Cancel Scooter Order
    [Arguments]    ${cancel_reason}
    Test Setup For Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}
    Find Order And Do The Cancel Process - Scooter    ${dms_order_no}    ${cancel_reason}
    Search With Order Number    ${dms_order_no}
    Verify Order Information    訂單狀態    已退購