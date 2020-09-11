*** Settings ***
Resource    variables_common.robot
Resource    variables_transfer_order.robot

*** Keywords ***
-------- Sales Portal Elements --------
Click Confirm Transfer Button
    [Documentation]    Click button to send transfer order result
    Click Element    ${XPATH_SEND_BUTTON_SPAN}

Click Transfer Order Button
    [Documentation]    Click button to start select transfer order flow
    Wait Until Element Is Enabled    ${XPATH_TRANSFER_ORDER_BUTTON}
    Click Visible Element    ${XPATH_TRANSFER_ORDER_BUTTON}

Click Order Number For detail
    [Documentation]    Click order number to check order detail
    [Arguments]    ${dms_order_no}
    Wait Until Element Is Enabled    //a[@class="OrderTable-info"and contains(.,"${dms_order_no}")]
    Wait Until Keyword Succeeds    ${PAGE_CONTAINS_TIMEOUT}    500ms    Click Element    //a[@class="OrderTable-info"and contains(.,"${dms_order_no}")]

Select Specific Order Checkbox
    [Documentation]    Select order's checkbox with given dms_order_no
    [Arguments]    ${dms_order_no}
    Wait Until Element Is Enabled    //ul[contains(.,"${dms_order_no}")]//input
    Wait Until Keyword Succeeds    ${PAGE_CONTAINS_TIMEOUT}    500ms    Click Element    //ul[contains(.,"${dms_order_no}")]//span[@class="ant-checkbox-inner"]

-------- Sales Portal Keywords --------
Change Role In Transfer Page
    [Documentation]    Login as given emp_code and go to transfer order page
    [Arguments]    ${emp_code}
    Login With Direct Login    ${emp_code}
    Click First Layer Item In Menu    /order/handover
    Verify Page URL    ${SALES_PORTAL_URL}/order/handover

Select Department By Admin
    [Documentation]    Select department only for admin role
    [Arguments]    ${department}
    Wait Until Page Contains    請選擇門市
    ${attr} =    Get Element Attribute    ${XPATH_DEPARTMENT_ATTRIBUTE_DIV}    aria-controls
    Click Element    ${XPATH_DEPARTMENT_DIV}
    JS Click Element    //*[@id="${attr}"]/ul/li[contains(.,"${department}")]

Select Sales
    [Documentation]    Select sales for admin and manager role
    [Arguments]    ${sales}
    Wait Until Page Contains    請選擇業務
    ${attr} =    Get Element Attribute    ${XPATH_SALES_ATTRIBUTE_DIV}    aria-controls
    Click Element    ${XPATH_SALES_DIV}
    Wait Until Page Contains Element   //*[@id="${attr}"]/ul/li[2]    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    //*[@id="${attr}"]/ul/li[contains(.,"${sales}")]

Transfer Specific Order
    [Documentation]    Transfer order by dms_order_no
    [Arguments]    ${dms_order_no}
    Search Order    訂單編號    ${dms_order_no}
    Select Specific Order Checkbox    ${dms_order_no}
    Click Transfer Order Button

-------- Verify Keywords --------
Verify Different Department Manager Cannot See The Order
    [Documentation]    Verify after transferring the order that different department manager cannot see the order
    [Arguments]    ${dms_order_no}
    Click Logout Button
    Change Role In Transfer Page    ${manager_emp_code}
    Search Order    訂單編號    ${dms_order_no}
    Wait Until Page Contains    無符合條件訂單    ${PAGE_CONTAINS_TIMEOUT}
    Page Should Contain    無符合條件訂單

Verify Role Can Find The Transfer Order
    [Documentation]    Verify the role can find the transfer order with order number
    [Arguments]    ${dms_order_no}    ${emp_code}    ${department}
    Click Visible Element    ${XPATH_OK_SPAN_BUTTON}
    Search Order    訂單編號    ${dms_order_no}
    Click Order Number For detail    ${dms_order_no}
    ${resp} =    Employees Get    emp_code=${emp_code}    account=${CIPHER_GSS_ACCOUNT}
    Verify Page URL    ${SALES_PORTAL_URL}/order/${dms_order_no}
    Verify Order Information    訂單編號    ${dms_order_no}
    Verify Order Information    負責業務    ${resp.json()['data'][0]['first_name']}${resp.json()['data'][0]['last_name']}
    Verify Order Information    訂單門市    ${department}

Verify Transfer Order Not Exist
    [Documentation]    Verify that transfer order function not exist on menu
    Wait Until Page Does Not Contain Element    ${XPATH_TRANSFER_ORDER_MENU_BUTTON}    5s
    Page Should Not Contain Element    ${XPATH_TRANSFER_ORDER_MENU_BUTTON}
