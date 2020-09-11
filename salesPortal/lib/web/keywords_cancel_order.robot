*** Keywords ***
-------- Sales Portal Elements --------
Click Cancel Button
    [Documentation]    Click cancel button to start cancel order process
    [Arguments]    ${dms_order_no}
    Click Visible Element    //button[text()="退購"]    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    //form/h1[text()="訂單退購"]
    Current Frame Should Contain    訂單編號
    Current Frame Should Contain    ${dms_order_no}

Press Confirm Button
    [Documentation]    After choosing cancel reason 
    Wait Until Page Contains    退購成功    10s
    JS Click Element    //button/span[text()="確 定"]

Push Purchase Button
    [Documentation]    Make the purchase done
    Wait Until Element Is Visible    //*[@id="root"]/div[3]/div/div/div/aside/div/div/div[3]/button[2]
    JS Click Element    //*[@id="root"]/div[3]/div/div/div/aside/div/div/div[3]/button[2]

Search With Order Number
    [Documentation]    Search to be canceled order
    [Arguments]    ${dms_order_no}
    Go To    ${SALES_PORTAL_URL}/order/manage
    Wait Until Element Is Visible    //*[@class="ant-input"]    10s
    Input Text    //*[@class="ant-input"]    ${dms_order_no}
    JS Click Element    //*[@class="anticon anticon-search ant-input-search-icon"]

-------- Sales Portal Keywords --------
Choose Cancel Reason of Accessories
    [Documentation]    Select a reason to cancel order
    [Arguments]    ${cancel_reason}
    Click Visible Element    //label[text()="${cancel_reason}"]    10s    5s
    Click Visible Element    //aside//form[1]/div/button[@type="submit"]    ${PAGE_CONTAINS_TIMEOUT}    5s

Choose Cancel Reason of Scooter
    [Documentation]    Select a reason to cancel order
    [Arguments]    ${cancel_reason}
    Click Visible Element    //label[text()="${cancel_reason}"]    10s    5s
    Click Visible Element    //aside//form[1]/div/button[@type="submit"]    ${PAGE_CONTAINS_TIMEOUT}    5s

-------- Verify Keywords --------
Verify New Create Order
    [Documentation]    Verify order in manage page
    [Arguments]    ${order_id}
    Wait Until Element Is Visible    //*[@class="container-wrap container-wrap_fullHigh"]//div[2]//div//div//ul//li[1]
    Element Should Contain    //*[@class="container-wrap container-wrap_fullHigh"]//div[2]//div//div//ul//li[1]    訂單編號
    Element Should Contain    //*[@class="container-wrap container-wrap_fullHigh"]//div[2]//div//div//ul//li[1]    ${order_id}
    Element Should Contain    //*[@class="container-wrap container-wrap_fullHigh"]//div[2]//div//div//ul//li[7]    訂單狀態
    Element Should Contain    //*[@class="container-wrap container-wrap_fullHigh"]//div[2]//div//div//ul//li[7]    待結帳
