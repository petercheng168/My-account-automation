*** Settings ***
Resource    variables_common.robot
Resource    variables_order.robot
Resource    variables_scooter_order.robot
Resource    variables_transfer_scooter.robot

*** Variables ***
${normalize_path}    ${PROJECT_ROOT}/salesPortal/res/car.png

*** Keywords ***
# -------- Sales Portal Elements --------
Change Sign Person Button
    [Documentation]    Change sign person by click button on the sign bar
    [Arguments]    ${id}
    JS Click Element    //div[@class="SignaturePad-padTab"]/button[${id}]

Check Transfer Order Process In Sign Up Page
    [Documentation]    Check that transfer order process in third step to sign up
    Wait Until Page Contains    合約簽署授權狀況    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Page Contains    請選擇店長    ${PAGE_CONTAINS_TIMEOUT}

Check Transfer Order Process In Upload Documents Page
    [Documentation]    Check that transfer order process in last step to upload documents
    Wait Until Element Is Visible    ${XPATH_CONTINUE_TRANSFER_BUTTON}    10s

Click Add Transfer Button
    [Documentation]    Click button to add new transfer scooter process
    Wait Until Element Is Visible    ${XPATH_ADD_NEW_TRANSFER_BUTTON_A}    10s
    JS Click Element    ${XPATH_ADD_NEW_TRANSFER_BUTTON_A}

Click Continue Button
    [Documentation]    Click button to continue
    Click Visible Element    ${XPATH_SELECT_TARIFF_PLAN_CONTINUE_BUTTON}    5s

Click Cancel Order Button
    [Documentation]    Click button to cancel order in any stage
    Click Visible Element    ${XPATH_CANCEL_TRANSFER_ORDER_BUTTUON}    5s

Click Cancel Order Confirm Button
    [Documentation]    Click button to confirm cancel order success
    [Arguments]    ${text}
    Click Visible Element    //span[text()="${text}"]/parent::button

Click Checkbox For Recycle Fee In Transfer Scooter Flow
    [Documentation]    Click checkbox for agreeing recycle fee
    Wait Until Element Is Enabled    ${XPATH_RECYCLE_FEE_TRANSFER_CHECKBOX}
    JS Click Element    ${XPATH_RECYCLE_FEE_TRANSFER_CHECKBOX}

Click Next Sign Up Documentation
    [Documentation]    Click button to sign with next documents
    Wait Until Element Is Enabled    ${XPATH_NEXT_SIGN_UP_BUTTON}    20s
    Click Visible Element    ${XPATH_NEXT_SIGN_UP_BUTTON}    20s
    Wait Until Keyword Succeeds    10s    50ms    Element Should Be Disabled    ${XPATH_NEXT_SIGN_UP_BUTTON}

Click Confirm Upload Button
    [Documentation]    Click button to confirm upload image
    Wait Until Element Is Enabled    ${XPATH_CONFIRM_UPLOAD_BUTTON}
    JS Click Element    ${XPATH_CONFIRM_UPLOAD_BUTTON}

Click Continue Button In Transfer Page
    [Documentation]    Click button to send all transfer scooter data
    Wait Until Element Is Visible    ${XPATH_TRANSFER_SCOOTER_DATA_TITLE_P}    30s
    Click Visible Element    ${XPATH_SEND_TRANSFER_SCOOTER_DATA_BUTTON}

Click Date Button
    [Documentation]    Click button in transfer scooter page to select plate_date
    Click Visible Element    ${XPATH_PLATE_DATE_INPUT}

Click Double Confirm Button
    [Documentation]    Click button to check new scooter owner data is correct
    Scroll View To Element    ${XPATH_DOUBLE_CONFIRM_BUTTON}
    JS Click Element    ${XPATH_DOUBLE_CONFIRM_BUTTON}

Click End Sign Button
    [Documentation]    Click button to end sign process
    Wait Until Element Is Enabled    ${XPATH_END_SIGN_UP_BUTTON}
    Click Visible Element    ${XPATH_END_SIGN_UP_BUTTON}

Click Es-Contract Button
    [Documentation]    Click button in transfer scooter page to get es-contract information
    Click Visible Element    ${XPATH_GET_ES_CONTRACT_BUTTON}

Click New Owner Confirm Button
    [Documentation]    Click button to send new scooter owner data
    Click Visible Element    ${XPATH_CONFIRM_SPAN_BUTTON}

Click Save Sign Button
    [Documentation]    Click button to save sign result
    Scroll View To Element    ${XPATH_SAVE_SIGN_UP_BUTTON}
    Wait Until Element Is Visible    ${XPATH_SAVE_SIGN_UP_BUTTON}    10s
    Run Keyword And Ignore Error    Wait Until Keyword Succeeds    1s    100ms    Click Element    ${XPATH_SAVE_SIGN_UP_BUTTON}

Click Send Button for Transfer
    [Documentation]    Click button to send 2 transfer email (old owner & new owner)
    Click Visible Element    ${XPATH_CONTINUE_TRANSFER_BUTTON}

Click Sign Canvas
    [Documentation]    Click sign canvas to make a sign
    Scroll View To Element    ${XPATH_CANVAS_VIEW_P}
    Click Visible Element    ${XPATH_CANVAS}    3s    retry_second=5s

Click Start Sign Button
    [Documentation]    Click button to start sign process
    Click Visible Element    ${XPATH_START_SIGN_UP_BUTTON}
    Wait Until Page Contains    買方簽名    ${PAGE_CONTAINS_TIMEOUT}

Click Today Button
    [Documentation]    Click button in calendar to choose today as plate_date
    Click Visible Element    ${XPATH_CALENDAR_TODAY_BUTTON_A}

Select First Item From The List
    [Documentation]    Select first item from transfer scooter list
    Click Visible Element    //*[@id="root"]/div[2]/main/div/div/div[3]/div[2]/ul[2]/li[1]/a

# -------- Sales Portal Keywords --------
Click Transfer Process Button
    [Documentation]    Click transfer process button to decide which status page list to show
    [Arguments]    ${number}    ${input}
    Go To    ${SALES_PORTAL_URL}/ownership/transfer
    Click Visible Element    //*[@id="root"]/div[2]/main/div/div/div[3]/div[1]/button[${number}][contains(.,"${input}")]

Get Department Code
    [Documentation]    API to get department name by employee's account
    [Arguments]    ${emp_code}=${SALES_ACCOUNT}    ${emp_email}=${NONE}    ${account}=${CIPHER_GSS_ACCOUNT}
    ${company_code} =     Employees Get    emp_code=${emp_code}    email=${emp_email}    account=${account}
    ${result} =    Departments Get    departments_id=${company_code.json()['data'][0]['department_id']}    account=${account}
    [Return]    ${result.json()['data'][0]['department_code']}

Get Employee Code
    [Documentation]    API to get employee code by employee's email
    [Arguments]    ${emp_email}
    ${result} =    Employees Get    emp_code=${NONE}    email=${emp_email}    account=${CIPHER_GEN_ACCOUNT}
    [Return]    ${result.json()['data'][0]['emp_code']}

Get Franchise Store Manager Name
    [Documentation]    API to get franchise store manager name for signing
    [Arguments]    ${emp_code}
    ${company_code} =     Employees Get
    ...    emp_code=${emp_code}
    ...    cipher_app=sales_portal    cipher_resource=sales_portal
    ...    account=${emp_code}        cipher_pwd=123
    ...    go_client=sales_portal
    Set Test Variable    ${legal_last_name}    ${company_code.json()['data'][0]['legal_last_name']}
    Set Test Variable    ${legal_first_name}    ${company_code.json()['data'][0]['legal_first_name']}
    [Return]    ${legal_last_name}${legal_first_name}

Get Store Manager Name
    [Documentation]    API to get manager name for signing
    ${company_code} =     Employees Get    emp_code=${SALES_ACCOUNT}    account=${CIPHER_GSS_ACCOUNT}
    Set Test Variable    ${legal_last_name}    ${company_code.json()['data'][0]['legal_last_name']}
    Set Test Variable    ${legal_first_name}    ${company_code.json()['data'][0]['legal_first_name']}
    [Return]    ${legal_last_name}${legal_first_name}

Sales And Manager Sign Up
    [Documentation]    Sales and manager sign up flow
    JS Click Element    ${XPATH_SIGN_UP_BUTTON}
    Sign Up
    ${result} =     Run Keyword And Ignore Error    Wait Until Page Contains    簽名不可為空    1s
    Run Keyword If    'PASS' in ${result}
    ...    Run Keywords
    ...    Click Visible Element    ${XPATH_OK_SPAN_BUTTON}
    ...    AND
    ...    Sign Up
    Sign Up    2
    ${result} =     Run Keyword And Ignore Error    Wait Until Page Contains    簽名不可為空    1s
    Run Keyword If    'PASS' in ${result}
    ...    Run Keywords
    ...    Click Visible Element    ${XPATH_OK_SPAN_BUTTON}
    ...    AND
    ...    Sign Up    2
    Click End Sign Button

Select Manager
    [Documentation]    Select store manager
    [Arguments]    ${emp_code}
    Scroll Page    0    0
    Sleep    3s
    Click Visible Element    ${XPATH_SELECT_MANAGER_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    ${manager} =    Run Keyword If    '${emp_code}' == '${SALES_ACCOUNT}'    Get Store Manager Name
    ...    ELSE IF    '${emp_code}' != '${SALES_ACCOUNT}'    Get Franchise Store Manager Name    ${emp_code}
    Click Visible Element    //li[contains(.,"${manager}")]

Sign Up
    [Documentation]    Sign up
    [Arguments]    ${person}=1
    Change Sign Person Button    ${person}
    Click Sign Canvas
    Click Save Sign Button

Sign Up Flow
    [Documentation]   Complete Sign Up Flow
    [Arguments]    ${text}
    Scroll View To Element    ${XPATH_SIGN_UP_BUTTON}
    Click Visible Element    ${XPATH_SIGN_UP_BUTTON}    10s    5s
    Sign Up
    ${result} =     Run Keyword And Ignore Error    Wait Until Page Contains    簽名不可為空    1s
    Run Keyword If    'PASS' in ${result}
    ...    Run Keywords
    ...    Click Visible Element    ${XPATH_OK_SPAN_BUTTON}
    ...    AND
    ...    Sign Up
    ...    ELSE    Click Next Sign Up Documentation

Select Tariff Plan
    [Documentation]    Select tariff plan
    [Arguments]    ${plan}=預選里程方案 630
    Select Es-Plan    ${plan}
    Click Checkbox For Recycle Fee In Transfer Scooter Flow
    JS Click Element    ${XPATH_BUYER_AGREEMENT_CHECKBOX}
    Click Continue Button

Upload Document In Transfer Scooter Page
    [Documentation]    Upload file, with different button xpath
    [Arguments]    ${input}
    JS Click Element    //li[@class="Attach-opItem"][contains(.,"${input}")]/div/button[text()="上傳"]
    Choose File    ${XPATH_UPLOAD_INPUT}    ${normalize_path}
    Click Confirm Upload Button
    Click Button To Close Popup Window By Message    檔案種類：${input}

Upload Two Documents In Transfer Scooter Page
    [Documentation]    Upload two documents in transfer scooter page, with different button xpath
    [Arguments]    ${input_1}
    JS Click Element    //li[@class="Attach-opItem"][contains(.,"${input_1}")]/div/button[1]
    Choose File    (${XPATH_UPLOAD_INPUT})[1]    ${normalize_path}
    Choose File    (${XPATH_UPLOAD_INPUT})[2]    ${normalize_path}
    Scroll Page    0   1000
    Click Confirm Upload Button
    Click Button To Close Popup Window By Message    檔案種類：${input_1}

# -------- Verify Keywords --------
Verify List Information
    [Documentation]    Verify that list with an order had correct information we just created
    [Arguments]    ${input_status}    ${input_plate}    ${input_department}    ${input_sales}    ${input_oldOwner}    ${input_newOwner}
    Wait Until Element Is Visible    ${XPATH_ORDERTABLE_UL}
    ${status} =        Get Text      ${XPATH_ORDERTABLE_UL}\[contains(.,"${input_plate}")]/li[4]
    ${plate} =         Get Text      ${XPATH_ORDERTABLE_UL}\[contains(.,"${input_plate}")]/li[5]
    ${department} =    Get Text      ${XPATH_ORDERTABLE_UL}\[contains(.,"${input_plate}")]/li[6]
    ${sales} =         Get Text      ${XPATH_ORDERTABLE_UL}\[contains(.,"${input_plate}")]/li[7]
    ${oldOwner} =      Get Text      ${XPATH_ORDERTABLE_UL}\[contains(.,"${input_plate}")]/li[8]
    ${newOwner} =      Get Text      ${XPATH_ORDERTABLE_UL}\[contains(.,"${input_plate}")]/li[9]
    Should Be Equal As Strings       ${status}        ${input_status}
    Should Be Equal As Strings       ${plate}         ${input_plate}
    Should Be Equal As Strings       ${department}    ${input_department}
    Should Be Equal As Strings       ${sales}         ${input_sales}
    Should Be Equal As Strings       ${oldOwner}      ${input_oldOwner}
    Should Be Equal As Strings       ${newOwner}      ${input_newOwner}
