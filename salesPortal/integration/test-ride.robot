*** Settings ***
Documentation    Test suite of Sales_Portal Test Riding Page With Calendar 
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Teardown    Reload Page
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Fill out test riding investigation
    [Tags]    Manually
    [Template]    Log
    Given an investigation after test riding
    And answer all the question
    When we finish it, click finish Button
    Then we can close a test riding process on calendar or list

Fill out quotation
    [Tags]    CID:5183
    [Setup]    Quotation Setup
    Click Button To Close Popup Window By Message    已完成試乘資料建立，準備開始試乘。
    Wait Until Calendar Finish Loading
    Click User On Calendar    ${name}
    Click Dont Change Business
    Click Quotation Button
    Select Scooter In Quotation Page
    Select Accessory In Quotation Page
    Click Quote Button
    Input Personal Information In Quotation Page
    Click Checkbox In Quotation Page
    Send Quotation Result
    Click Confirm Sending Email Button On Popup Window
    Switch Window Tab    0
    Click Finish Button After Quotation Done
    Click Finish Button After Test Riding Done
    Verify Email Exists    ${SALES_PORTAL_GMAIL_SENDER}    ${GMAIL_ACCOUNT}    ${GMAIL_PASSWORD}

Make test ride booking with date and time
    [Tags]    CID:5184
    [Setup]    Setup Test Data
    Click Start Reservation Button
    Input Test Riding Information    ${phone}    ${name}    ${SALES_PORTAL_MANAGER_ACCOUNT}    臺北市    松山區    Gogoro S2    EMD-8398
    Click Search Button In Phone Number Field
    Upload Non-Driven License Image
    Select Date And Time    下午場
    Select Checkbox For Agreement
    Click Button With Name    下一步
    Verify Popup Window Message    預約完成

Make test ride reservation
    [Tags]    CID:5185
    [Setup]    Setup Test Data    
    Input Test Riding Information    ${phone}    ${name}    ${SALES_PORTAL_MANAGER_ACCOUNT}    臺北市    松山區    Gogoro S2    EMD-8398
    Click Search Button In Phone Number Field    
    Upload Non-Driven License Image
    Click Next Step Button
    Click Confirm Button On Reservation Window
    Click Confirm Sign Button After Image Loaded
    Click Sign Button
    Sign Up With A Dot
    Verify Popup Window Message    已完成試乘資料建立，準備開始試乘。
    [Teardown]    Close Window And Skip Quotation

Search with exist phone number
    [Tags]    CID:5186
    [Setup]    Quotation Setup
    Click Button To Close Popup Window By Message    已完成試乘資料建立，準備開始試乘。
    Input Test Riding Information    ${phone}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Click Search Button In Phone Number Field
    Verify User Information From Search Button    ${name}    ${SALES_PORTAL_MANAGER_ACCOUNT}    臺北市    松山區
    [Teardown]    Skip Quotation

Search with phone number not in database
    [Tags]    CID:5187
    Input Test Riding Information    0934343434    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Click Search Button In Phone Number Field
    Verify Popup Window Message    此號碼尚無資料
    [Teardown]    Close Popup Window And Refresh

Search with wrong format phone number
    [Tags]    CID:5188
    Input Test Riding Information    0000000000    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Click Next Step Button
    Verify Error Hint Without Giving Input    2    請輸入正確手機號碼格式 

Search without phone number
    [Tags]    CID:5189
    Input Test Riding Information    ${EMPTY}    SWQA    ${SALES_PORTAL_MANAGER_ACCOUNT}    臺北市    中山區    Gogoro S2    EMD-8398
    Click Next Step Button
    Verify Error Hint Without Giving Input    2    請輸入手機號碼

Send information without city and area
    [Tags]    CID:5190
    Input Test Riding Information    0945454545    SWQA    ${SALES_PORTAL_MANAGER_ACCOUNT}    ${EMPTY}    ${EMPTY}    Gogoro S2    EMD-8398
    Click Next Step Button
    Verify Error Hint Without Giving City And Area    請選擇縣市    請選擇地區

Send information without email
    [Tags]    CID:5191
    Input Test Riding Information    0945454545    SWQA    ${EMPTY}    臺北市    中山區    Gogoro S2    EMD-8398
    Click Next Step Button
    Verify Error Hint Without Giving email    6    請輸入正確 Email 格式

Send information without model and plate
    [Tags]    CID:5192
    Input Test Riding Information    0945454545    SWQA    ${SALES_PORTAL_MANAGER_ACCOUNT}    臺北市    中山區    ${EMPTY}    ${EMPTY}
    Click Next Step Button
    Verify Error Hint Without Giving Input    7    請選擇車款
    Verify Error Hint Without Giving Input    8    請選擇車牌

Send information without name
    [Tags]    CID:5193
    Input Test Riding Information    0945454545    ${EMPTY}    ${SALES_PORTAL_MANAGER_ACCOUNT}    臺北市    中山區    Gogoro S2    EMD-8398
    Click Next Step Button
    Verify Error Hint Without Giving Input    3    請輸入姓名

Send information without phone number
    [Tags]    CID:5194
    Input Test Riding Information    ${EMPTY}    SWQA    ${SALES_PORTAL_MANAGER_ACCOUNT}    臺北市    中山區    Gogoro S2    EMD-8398 
    Click Next Step Button
    Verify Error Hint Without Giving Input    2    請輸入手機號碼

Upload image
    [Tags]    Manually
    [Template]    Log
    Given an image to fetch OCR Data
    And the image should be a driven-license
    When it is driven-license, it will pass without error message
    Then we can keep going with test riding scenario by clicking Next Button

*** Keywords ***
Click Dont Change Business
    ${status} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${XPATH_DONT_CHANGE_BUSINESS_BUTTON}    5s
    Run Keyword If    '${status}' == 'True'    Click Visible Element    ${XPATH_DONT_CHANGE_BUSINESS_BUTTON}    5s

Close Popup Window And Refresh
    Click Button To Close Popup Window By Message    此號碼尚無資料
    Reload Page

Close Window And Skip Quotation
    Click Button To Close Popup Window By Message    已完成試乘資料建立，準備開始試乘。
    Skip Quotation

Input Personal Information In Quotation Page
    ${department_name} =    Get Account Information
    Input Text In Element    customerName    ${name}
    Input Text In Element    customerPhone    ${phone}
    Input Text In Element    customerEmail    ${SALES_PORTAL_MANAGER_ACCOUNT}
    Scroll View To Element    //*[@id="customerEmail"]
    Select City From Quotation Page List    ${department_name}

Quotation Setup
    Setup Test Data
    Input Test Riding Information    ${phone}    ${name}    ${SALES_PORTAL_MANAGER_ACCOUNT}    臺北市    松山區    Gogoro S2    EMD-8398
    Click Search Button In Phone Number Field    
    Upload Non-Driven License Image
    Click Next Step Button
    Click Confirm Button On Reservation Window
    Click Confirm Sign Button After Image Loaded
    Click Sign Button
    Sign Up With A Dot
    Verify Popup Window Message    已完成試乘資料建立，準備開始試乘。

Setup Test Data
    ${name} =    Generate Random String    4    [NUMBERS]
    ${phone} =    Generate Random String    8    [NUMBERS]
    Set Suite Variable    ${name}    SWQA-${name}
    Set Suite Variable    ${phone}    09${phone}

Skip Quotation
    Wait Until Calendar Finish Loading
    Click User On Calendar    ${name}
    Click Quotation Button
    Click Finish Button After Quotation Done
    Click Finish Button After Test Riding Done
    Reload Page

Suite Setup
    Login With Direct Login
    Click Button In Main Body    試乘參觀
    Verify Page URL    ${SALES_PORTAL_URL}/testride/2
