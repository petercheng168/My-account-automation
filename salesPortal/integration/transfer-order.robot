*** Settings ***
Documentation    Test suite of Sales_Portal Transfer Order Page
Resource    ../init.robot

Force Tags    SalesPortal
Suite Teardown    Close All Browsers
Suite Setup    Suite Setup
Test Teardown    Test Teardown
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${admin_emp_code}    QA00001
${manager_emp_code}    QA00002
${user_emp_code}    QA00003
${another_manager_emp_code}    10000464T

*** Test Cases ***
Transfer order by admin under different department - check with admin and manager role
    [Tags]    CID:5200
    [Setup]    Test Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${admin_emp_code}    ${another_manager_emp_code}
    Transfer Specific Order    ${dms_order_no}
    Select Department By Admin    ${department_name}
    Select Sales    ${another_manager_emp_code}
    Click Confirm Transfer Button
    Verify Popup Window message    全數移轉成功
    Verify Role Can Find The Transfer Order    ${dms_order_no}    ${another_manager_emp_code}    ${department_name}
    Verify Different Department Manager Cannot See The Order    ${dms_order_no}
    [Teardown]    Test Teardown After Click Confirm Button

Transfer order by admin under same department - check with admin role
    [Tags]    CID:5201
    [Setup]    Test Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${admin_emp_code}    ${manager_emp_code}
    Transfer Specific Order    ${dms_order_no}
    Select Department By Admin    ${department_name}
    Select Sales    ${manager_emp_code}
    Click Confirm Transfer Button
    Verify Popup Window message    全數移轉成功
    Verify Role Can Find The Transfer Order    ${dms_order_no}    ${manager_emp_code}    ${department_name}

Transfer order by manager - check with manager role
    [Tags]    CID:5202
    [Setup]    Test Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${manager_emp_code}    ${user_emp_code}
    Transfer Specific Order    ${dms_order_no}
    Select Sales    ${user_emp_code}
    Click Confirm Transfer Button
    Verify Popup Window message    全數移轉成功
    Verify Role Can Find The Transfer Order    ${dms_order_no}    ${user_emp_code}    ${department_name}

Transfer order by manager - check with user role
    [Tags]    CID:5203
    [Setup]    Test Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${manager_emp_code}    ${user_emp_code}
    Transfer Specific Order    ${dms_order_no}
    Select Sales    ${user_emp_code}
    Click Confirm Transfer Button
    Change User In Order Page    ${user_emp_code}
    Verify Order In Correct State List    1    待簽約    ${dms_order_no}

Transfer order by manager then delivery scooter by user
    [Tags]    CID:5204
    [Setup]    Transfer Order To User
    Complete Promise Delivery Date Flow
    Approve Sending Take Plate Request
    Confirm Pre-Delivery Scooter Checklist    self
    Confirm Delivery Scooter Checklist    self
    Sign Delivery Checklist
    Verify Delivery Success    確認交車成功

Transfer order with user role
    [Tags]    CID:5205
    Login With Direct Login    ${user_emp_code}
    Verify Transfer Order Not Exist

*** Keywords ***
Approve Sending Take Plate Request
    Change User In Order Page    ${manager_emp_code}
    Click Order State Button    8    待送領牌
    Confirm Sending Take Plate Request
    Change User In Order Page    ${user_emp_code}
    Verify Order In Correct State List    10    待交車    ${dms_order_no}

Assign Scooter From Scooters Infos
    [Arguments]    ${dms_order_no}
    Scooters Infos Update    ${dms_order_no}    ${scooter.scooter_vin}
    ...    ${driver.user_id}    ${owner.user_id}    ${owner.user_guid}    0
    ...    turn_light=1    brake_light=1    tpms=0    sport_mode=1

Change User In Order Page
    [Arguments]    ${emp_code}
    Login With Direct Login    ${emp_code}
    Click Button In Main Body    待處理訂單
    Verify Page URL    ${SALES_PORTAL_URL}/order/manage

Creating Scooter Order
    [Arguments]    ${buyer_email}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}    ${licensing_location}=台北領牌中心    ${licensing_location_id}=DMV_TP    ${agency_fee}=2215
    Setup User Information    ${buyer_email}    ${owner_email}    ${driver_email}
    ${dms_order_no} =    Create Scooter Order    ${buyer}    新北市    1906    SUBFEE-00049    ${licensing_location}    ${licensing_location_id}    ${agency_fee}    ${token}    Owner=${owner}    Driver=${driver}
    Set Test Variable    ${dms_order_no}

Complete Promise Delivery Date Flow
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

Setup Scooter Variables
    [Arguments]    ${scooter_model}=GSBH2-000-CF
    Set Test Variable    ${scooter}    ${Scooters('${scooter_model}')}
    Scooters Post    company_code=${scooter.company_code}    country_code=${scooter.country}
    ...    scooter_vin=${scooter.scooter_vin}    scooter_guid=${scooter.scooter_guid}
    ...    matnr=${scooter.matnr}    atmel_key=${scooter.atmel_key}    state=${scooter.state}
    ...    es_state=${scooter.es_state}    ecu_status=${scooter.ecu_status}
    ...    status=${scooter.keyfobs_status}    manufacture_date=${scooter.manufacture_date}
    ...    keyfobs_id=${scooter.keyfobs_id}

Setup User Information
    [Arguments]    ${buyer_email}    ${owner_email}    ${driver_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}

Suite Setup
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Set Suite Variable    ${token}    ${get_token}

Test Setup
    [Arguments]    ${buyer_email}    ${emp_code}    ${select_emp_code}
    Creating Scooter Order    ${buyer_email}
    Change Role In Transfer Page    ${emp_code}
    ${department_name} =    Get Account Information    ${select_emp_code}
    Set Test Variable    ${department_name}

Test Teardown
    Click Logout Button
    Close All Browsers

Test Teardown After Click Confirm Button
    Click Visible Element    ${XPATH_OK_SPAN_BUTTON}
    Test Teardown

Transfer Order To User
    Creating Scooter Order    ${SALES_PORTAL_BUYER_EMAIL}    licensing_location=自領牌    licensing_location_id=DMV_ZL
    Change Role In Transfer Page    ${manager_emp_code}
    Transfer Specific Order    ${dms_order_no}
    Select Sales    ${user_emp_code}
    Click Confirm Transfer Button
    Change User In Order Page    ${user_emp_code}
    Setup Scooter Variables
    Update Invoice Status To Already Paid    ${dms_order_no}    3    ${token}
    Assign Scooter From Scooters Infos    ${dms_order_no}
    Click Order State Button    7    待押交車
