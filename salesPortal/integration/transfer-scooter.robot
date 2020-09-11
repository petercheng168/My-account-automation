*** Settings ***
Documentation    Test suite of Sales_Portal Transfer Scooter Page
...              The transfer orders are only saving in sales portal database
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Teardown    Go To    ${SALES_PORTAL_URL}/ownership/transfer
Test Timeout    600

*** Test Cases ***
Add transfer order
    [Tags]    CID:5197
    [Setup]    Add Transfer Order Draft    ${SALES_PORTAL_TRANSFER_NEW_OWNER_ACCOUNT}    ${SALES_PORTAL_TRANSFER_NEW_OWNER_PHONE}
    Select Tariff Plan
    Check Transfer Order Process In Sign Up Page
    Click Transfer Process Button    2    待簽約
    ${department_code} =    Get Department Code    emp_code=${NONE}    emp_email=${SALES_PORTAL_BILLING_ADMIN_ACCOUNT}    account=${CIPHER_GEN_ACCOUNT}
    ${employee_code} =    Get Employee Code    emp_email=${SALES_PORTAL_BILLING_ADMIN_ACCOUNT}
    Verify List Information    待簽約    ${SALES_PORTAL_TRANSFER_PLATE}    ${department_code}    ${employee_code}    ${SALES_PORTAL_TRANSFER_OLD_OWNER_NAME}    ${SALES_PORTAL_TRANSFER_NEW_OWNER_NAME}
    [Teardown]    Cancel Transfer Order

Add transfer order draft
    [Tags]    CID:5198
    [Setup]    Add Transfer Order Draft    ${SALES_PORTAL_TRANSFER_NEW_OWNER_ACCOUNT}    ${SALES_PORTAL_TRANSFER_NEW_OWNER_PHONE}
    Click Transfer Process Button    1    草稿
    ${department_code} =    Get Department Code    emp_code=${NONE}    emp_email=${SALES_PORTAL_BILLING_ADMIN_ACCOUNT}    account=${CIPHER_GEN_ACCOUNT}
    Verify List Information    草稿    ${SALES_PORTAL_TRANSFER_PLATE}    ${department_code}    ${SALES_BILLING_ACCOUNT}    ${SALES_PORTAL_TRANSFER_OLD_OWNER_NAME}    ${SALES_PORTAL_TRANSFER_NEW_OWNER_NAME}
    [Teardown]    Cancel Transfer Order Draft

Transfer scooter
    [Tags]    CID:5199
    [Setup]    Add Transfer Order Draft    ${SALES_PORTAL_TRANSFER_NEW_OWNER_ACCOUNT}    ${SALES_PORTAL_TRANSFER_NEW_OWNER_PHONE}
    Select Tariff Plan
    Check Transfer Order Process In Sign Up Page
    Select Transfer Scooter Manager
    Complete Sign Up Documents Flow
    Complete Upload Documents Flow
    Verify Email Exists    ${SALES_PORTAL_GMAIL_SENDER}    ${SALES_PORTAL_TRANSFER_OLD_OWNER_ACCOUNT}    ${GMAIL_PASSWORD}
    Verify Email Exists    ${SALES_PORTAL_GMAIL_SENDER}    ${SALES_PORTAL_TRANSFER_NEW_OWNER_ACCOUNT}    ${GMAIL_PASSWORD}
    [Teardown]    Transfer Scooter Back To Old Owner

*** Keywords ***
Add Transfer Order Draft
    [Arguments]    ${transferAccount}    ${transferPhone}
    Click Add Transfer Button
    Input Transfer Scooter Data    ${SALES_PORTAL_TRANSFER_VIN}    ${SALES_PORTAL_TRANSFER_PLATE}    ${SALES_PORTAL_TRANSFER_PROFILEID}
    Click Continue Button In Transfer Page
    Input New Scooter Owner Data    ${transferAccount}    ${transferPhone}
    Click New Owner Confirm Button
    Click Continue Button In Scooter Order    2
    Wait Until Element Is Visible    ${XPATH_BATTERY_TARIFF_PLAN_OPTIONS_UL}    ${PAGE_CONTAINS_TIMEOUT}

Cancel Transfer Order
    Click Transfer Process Button    2    待簽約
    Cancel Transfer Order Flow
    Reload Page

Cancel Transfer Order Draft
    Click Transfer Process Button    1    草稿
    Cancel Transfer Order Flow
    Reload Page

Cancel Transfer Order Flow
    Click Cancel Order Button
    Click Cancel Order Confirm Button    確 認
    Click Cancel Order Confirm Button    確 定

Complete Sign Up Documents Flow
    Click Start Sign Button
    Sign Up Flow    新車主訂購合約電池
    Sign Up Flow    新車主個資同意書
    Sales And Manager Sign Up

Complete Upload Documents Flow
    Wait Until Page Contains    新車主身分證正反面    ${PAGE_CONTAINS_TIMEOUT}
    Upload Two Documents In Transfer Scooter Page    新車主身分證正反面
    Click Send Button for Transfer

Input New Scooter Owner Data
    [Arguments]    ${gogoro_account}    ${phone}
    Input Text In Element    newOwnerEmail    ${gogoro_account}
    Input Text In Element    newOwnerPhone    ${phone}

Input Transfer Scooter Data
    [Arguments]    ${vin}    ${plate}    ${profile_id}
    Wait Until Element Is Visible    ${XPATH_INPUT_TRANSFER_DATA_H5}    3s
    Input Text In Element    vin    ${vin}
    Input Text In Element    plate    ${plate}
    Click Date Button
    Click Today Button
    Click Es-Contract Button

Select Transfer Scooter Manager
    ${result} =     Employees Get    email=${CIPHER_GEN_MANAGER_ACCOUNT}    account=${CIPHER_GEN_ACCOUNT}
    Set Test Variable    ${legal_last_name}    ${result.json()['data'][0]['legal_last_name']}
    Set Test Variable    ${legal_first_name}    ${result.json()['data'][0]['legal_first_name']}
    Click Visible Element    ${XPATH_SELECT_MANAGER_DIV}
    Click Visible Element    //li[contains(.,"${legal_last_name}${legal_first_name}")]

Suite Setup
    Login With Direct Login    account=${SALES_PORTAL_BILLING_ADMIN_ACCOUNT}    password=${SALES_BILLING_PASSWORD}
    Click Button In Main Body    過戶管理
    Verify Page URL    ${SALES_PORTAL_URL}/ownership/transfer

Transfer Scooter Back To Old Owner
    Go To    ${SALES_PORTAL_URL}/ownership/transfer
    Sleep    20s
    Add Transfer Order Draft    ${SALES_PORTAL_TRANSFER_OLD_OWNER_ACCOUNT}    ${SALES_PORTAL_TRANSFER_OLD_OWNER_PHONE}
    Select Tariff Plan
    Check Transfer Order Process In Sign Up Page
    Select Transfer Scooter Manager
    Complete Sign Up Documents Flow
    Complete Upload Documents Flow
    Verify Email Exists    ${SALES_PORTAL_GMAIL_SENDER}    ${SALES_PORTAL_TRANSFER_NEW_OWNER_ACCOUNT}    ${GMAIL_PASSWORD}
    Verify Email Exists    ${SALES_PORTAL_GMAIL_SENDER}    ${SALES_PORTAL_TRANSFER_OLD_OWNER_ACCOUNT}    ${GMAIL_PASSWORD}
