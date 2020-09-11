*** Variables ***
${invoice_status_update_time}    6s

*** Keywords ***
# --------   SP Elements   --------
Click Invoice Button
    [Documentation]    Click button to display invoice detail
    Click Visible Element    //button[@class="OrderDetail-padLink" and text()="發票資訊"]    5s

# --------   SP Keywords   --------
Search Order info With Order Number
    [Documentation]    Search order info with order number
    [Arguments]    ${dms_order_no}    ${input_info}
    Reload Page
    Search Order    訂單編號    ${dms_order_no}
    Wait Until Element Is Visible    //a[text()="${input_info}"]    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    //a[text()="${input_info}"]
    Run Keyword And Ignore Error    JS Click Element    //a[text()="${input_info}"]

# -------- Verify Keywords --------
Verify Add Accessories Invoice Information
    [Documentation]    Check add accessories invoice information is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           101800    待開立
    Verify Invoice Item Exist    配件及文件費發票    2190      待開立
    Verify Invoice Item Exist    代辦費收據         1915      待開立
    Verify Invoice Item Exist    TES補助款發票      7000      取消
    Verify Invoice Item Exist    尾款發票           101800    取消
    Verify Invoice Item Exist    配件及文件費發票    700       取消
    Verify Invoice Item Exist    代辦費收據         1915      取消

Verify Change Payment Type Invoice Information    
    [Documentation]    Check change scooter invoice information is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           101800    待開立
    Verify Invoice Item Exist    配件及文件費發票    700       待開立
    Verify Invoice Item Exist    代辦費收據         1915      待開立
    Verify Invoice Item Exist    TES補助款發票      7000      取消
    Verify Invoice Item Exist    尾款發票           101800    取消
    Verify Invoice Item Exist    配件及文件費發票    700       取消
    Verify Invoice Item Exist    代辦費收據         1915      取消

Verify Change Scooter Invoice Information
    [Documentation]    Check change scooter invoice information is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           47980     待開立
    Verify Invoice Item Exist    配件及文件費發票    700       待開立
    Verify Invoice Item Exist    代辦費收據         1385      待開立
    Verify Invoice Item Exist    TES補助款發票      7000      取消
    Verify Invoice Item Exist    尾款發票           101800    取消
    Verify Invoice Item Exist    配件及文件費發票    700       取消
    Verify Invoice Item Exist    代辦費收據         1915      取消

Verify Change Scooter Owner Invoice Information
    [Documentation]    Check change scooter owner invoice information is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           101800    待開立
    Verify Invoice Item Exist    配件及文件費發票    700       待開立
    Verify Invoice Item Exist    代辦費收據         1915      待開立
    Verify Invoice Item Exist    TES補助款發票      7000      取消
    Verify Invoice Item Exist    尾款發票           101800    取消
    Verify Invoice Item Exist    配件及文件費發票    700       取消
    Verify Invoice Item Exist    代辦費收據         1915      取消

Verify Change Take Plate Location Invoice Information
    [Documentation]    Check change take plate location invoice information is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           101800    待開立
    Verify Invoice Item Exist    配件及文件費發票    700       待開立
    Verify Invoice Item Exist    代辦費收據         2080      待開立
    Verify Invoice Item Exist    TES補助款發票      7000      取消
    Verify Invoice Item Exist    尾款發票           101800    取消
    Verify Invoice Item Exist    配件及文件費發票    700       取消
    Verify Invoice Item Exist    代辦費收據         1915      取消

Verify Change Take Plate Method Invoice Information
    [Documentation]    Check change scooter invoice information is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           101800    待開立
    Verify Invoice Item Exist    配件及文件費發票    400       待開立
    Verify Invoice Item Exist    TES補助款發票      7000      取消
    Verify Invoice Item Exist    尾款發票           101800    取消
    Verify Invoice Item Exist    配件及文件費發票    700       取消
    Verify Invoice Item Exist    代辦費收據         1915      取消

Verify Create Legal Entity Order In Franchise
    [Documentation]    Check create legal entity order in franchise that invoice is correct
    [Arguments]    ${dms_order_no}
    Go To    ${SALES_PORTAL_URL}/order/manage
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      己開立
    Verify Invoice Item Exist    尾款發票           101800    己開立
    Verify Invoice Item Exist    配件及文件費發票    400       己開立
    Verify Invoice Item Exist    代辦費收據         2215      己開立

Verify Create Legal Entity Order With Payment Type
    [Documentation]    Check create legal entity order with payment type that invoice is correct
    [Arguments]    ${dms_order_no}    ${payment_type}
    Go To    ${SALES_PORTAL_URL}/order/manage
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      己開立
    Verify Invoice Item Exist    尾款發票           101800    己開立
    Verify Invoice Item Exist    配件及文件費發票    400       己開立
    Verify Invoice Item Exist    代辦及文件費發票    300       己開立
    Verify Invoice Item Exist    代辦費收據         1915      己開立

Verify Create Scooter From Channel
    [Documentation]    Check create scooter order from channel that invoice is correct
    [Arguments]    ${dms_order_no}    ${invoice_number}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    配件及文件費發票    700       己開立
    Verify Invoice Item Exist    代辦費收據         1915      己開立

Verify Create Scooter In Franchise From Channel
    [Documentation]    Check create scooter order in franchise from channel that invoice is correct
    [Arguments]    ${dms_order_no}    ${invoice_number}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    配件及文件費發票    400       己開立
    Verify Invoice Item Exist    代辦費收據         2215      己開立

Verify Create Scooter In Franchise With Cash
    [Documentation]    Check create scooter order in franchise with cash that invoice is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           101800    待開立
    Verify Invoice Item Exist    配件及文件費發票    400       待開立
    Verify Invoice Item Exist    代辦費收據         2215      待開立

Verify Create Scooter In Franchise With Loan
    [Documentation]    Check create scooter order in franchise with loan that invoice is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           100800    待開立
    Verify Invoice Item Exist    頭期款發票         1000      待開立
    Verify Invoice Item Exist    配件及文件費發票    400       待開立
    Verify Invoice Item Exist    代辦費收據         2215      待開立

Verify Create Scooter With Any Payment Type
    [Documentation]    Check create scooter order with credit card that invoice is correct, sleep 5s for waiting server update
    [Arguments]    ${dms_order_no}    ${payment_type}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    配件及文件費發票    700       待開立
    Verify Invoice Item Exist    代辦費收據         1915      待開立
    Run Keyword If    '${payment_type}' != 'loan'    Verify Invoice Item Exist    尾款發票      101800    待開立
    Run Keyword If    '${payment_type}' == 'loan'    Verify Invoice Item Exist    頭期款發票    1000      待開立
    Run Keyword If    '${payment_type}' == 'loan'    Verify Invoice Item Exist    尾款發票      100800      待開立

Verify Invoice Item Exist
    [Documentation]
    [Arguments]    ${invoice_type}    ${amount}    ${status}
    Wait Until Element Is Visible    //h2[@class="OrderDetail-tableTitle" and text()="發票資訊"]    5s
    Page Should Contain Element    //tr[contains(.,"${invoice_type}") and contains(.,"${amount}") and contains(.,"${status}")]

Verify Remove Down Payment Invoice Information
    [Documentation]    Check remove down payment invoice information is correct
    [Arguments]    ${dms_order_no}
    Sleep    ${invoice_status_update_time}
    Search Order info With Order Number    ${dms_order_no}    發票資訊
    Verify Invoice Item Exist    TES補助款發票      7000      待開立
    Verify Invoice Item Exist    尾款發票           101800    待開立
    Verify Invoice Item Exist    配件及文件費發票    700       待開立
    Verify Invoice Item Exist    代辦費收據         1915      待開立
    Verify Invoice Item Exist    TES補助款發票      7000      取消
    Verify Invoice Item Exist    頭期款發票         1000      取消
    Verify Invoice Item Exist    尾款發票           100800    取消
    Verify Invoice Item Exist    配件及文件費發票    700       取消
    Verify Invoice Item Exist    代辦費收據         1915      取消
