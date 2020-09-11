*** Settings ***
Documentation    Test suite of orders
Resource    ../init.robot

Force Tags    Orders
Suite Setup    Suite Setup
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
orders - get - get order with scooter type
    ${resp} =     Orders Get    order_type=scooter    order_id=${Order.order_id}
    Verify Status Code As Expected       ${resp}                                              200
    Verify Response Contains Expected    ${resp.json()['data'][0]['order_id']}                ${Order.order_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['sold_by_company_name']}    Gogoro Energy Network
    Verify Response Contains Expected    ${resp.json()['data'][0]['gogoro_user_id']}          ${User.user_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['r04']}                     VEH_SALE_CR
    Verify Response Contains Expected    ${resp.json()['data'][0]['r05']}                     ${Order.order_no}
    Verify Response Contains Expected    ${resp.json()['data'][0]['flow_status']}             30001

orders - post - create order with loan information
    [Setup]    Setup Order Variable
    ${post_resp} =    Orders Post    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001    loan_app_date=${random_loan}    loan_approval_date=${random_loan}
    ${get_resp} =     Orders Get    order_type=scooter    order_id=${post_resp.json()['data'][0]['order_id']}
    Verify Status Code As Expected       ${post_resp}                                   200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['r31']['n09']}    ${random_loan}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['r31']['n10']}    ${random_loan}
    Verify Schema    orders.json    ordersResponse    ${post_resp.json()}

orders - update - update order loan information
    ${update_resp} =     Orders Update    ${Order.order_id}    VEH_SALE_CR    ${Order.order_no}    ${NONE}    ${User.user_id}    30004    1    loan_app_date=${random_loan}    loan_approval_date=${random_loan}
    ${get_resp} =        Orders Get    order_type=scooter    order_id=${Order.order_id}
    Verify Status Code As Expected       ${update_resp}                                 200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['r31']['n09']}    ${random_loan}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['r31']['n10']}    ${random_loan}
    Verify Schema    orders.json    ordersResponse    ${update_resp.json()}

*** Keywords ***
Setup Order Variable
    ${random_loan} =     Generate Random String    8    [NUMBERS]
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${random_loan}
    Set Test Variable    ${Order}    ${Orders('P0${order_number}')}

Suite Setup
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Suite Variable    ${User}     ${Users()}
    Set Suite Variable    ${Order}    ${Orders('P0${order_number}')}
    ${User.user_id} =    Create User    ${User}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001

Test Setup
    ${random_loan} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${random_loan}