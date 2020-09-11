*** Settings ***
Resource    variables_priority_setting.robot

*** Keywords ***
# --------   SP Elements   --------
Choose Allocation For Query Condition
    [Documentation]    Choose allocation for query condition
    [Arguments]    ${label_name}    ${allocation}
    Click Visible Element    ${XPATH_ORDER_CONDITION_INQUIRY_LABEL}\[contains(text(),"${label_name}")]/div//span[@class="ant-select-arrow"]    3s    2s
    Click Visible Element    ${XPATH_ORDER_CONDITION_INQUIRY_UL}\[contains(text(),"${allocation}")]    3s    2s

Click Condition Inquiry Button
    [Documentation]    Click condition inquiry button
    Click Visible Element    ${XPATH_ORDER_CONDITION_INQUIRY_BUTTON}    3s    2s

Click Filter Icon
    [Documentation]    Click filter icon
    Click Visible Element    ${XPATH_FILTER_ICON}    3s    2s

Get Error Order Number Inquiry Results
    [Documentation]    Get error order num inquiry result
    Wait Until Element Is Visible    ${XPATH_ERROR_ORDER_INQUIRY_RESULTS}    5s
    ${result} =    Get Text    ${XPATH_ERROR_ORDER_INQUIRY_RESULTS}
    [Return]    ${result}

Get Order Condition Inquiry Results
    [Documentation]    Get order condition inquiry  result
    [Arguments]    ${row}    ${input}
    Wait Until Element Is Visible    ${XPATH_ORDER_INQUIRY_RESULTS_TR}\[${row}]/td[contains(text(),"${input}")]    5s
    ${result} =    Get Text    ${XPATH_ORDER_INQUIRY_RESULTS_TR}\[${row}]/td[contains(text(),"${input}")]
    [Return]    ${result}

Get Order Number Inquiry Results
    [Documentation]    Get order num inquiry result
    [Arguments]    ${input}
    Wait Until Element Is Visible    ${XPATH_ORDER_INQUIRY_RESULTS_TR}/td[contains(text(),"${input}")]    5s
    ${result} =    Get Text    ${XPATH_ORDER_INQUIRY_RESULTS_TR}/td[contains(text(),"${input}")]
    [Return]    ${result}

# --------   SP Keywords   --------
Input Text For Order Number Inquiry
    [Documentation]    Input order number
    [Arguments]    ${input_num}
    Click Visible Element    ${XPATH_ORDER_NUMBER_INQUIRY_INPUT}    3s    2s
    Input Text    ${XPATH_ORDER_NUMBER_INQUIRY_INPUT}    ${input_num}
    Click Visible Element    ${XPATH_ORDER_NUMBER_INQUIRY_BUTTON}    3s    2s

Input Text For Query Condition
    [Documentation]    Input text query condition
    [Arguments]    ${label_name}    ${search_name}
    Click Visible Element    ${XPATH_ORDER_CONDITION_INQUIRY_LABEL}\[contains(text(),"${label_name}")]/div//span[@class="ant-select-arrow"]    3s    2s
    Input Text    ${XPATH_ORDER_CONDITION_INQUIRY_LABEL}\[contains(text(),"${label_name}")]/div//div//input    ${search_name}
    Press Keys    ${XPATH_ORDER_CONDITION_INQUIRY_LABEL}\[contains(text(),"${label_name}")]/div//div//input    ENTER

Query Condition Setting
    [Documentation]    Query condition setup
    [Arguments]    ${input_channel}    ${input_store}    ${allocation}=${None}
    Input Text For Query Condition    通路    ${input_channel}
    Input Text For Query Condition    門市    ${input_store}
    Run Keyword If    ${allocation} != ${None}    Choose allocation For Query Condition    配車設定    ${allocation}
    Click Condition Inquiry Button

# -------- Verify Keywords --------
Verify Error Order Number Inquiry Results
    [Documentation]    Error order number inquiry result
    ${error_order_message} =    Get Error Order Number Inquiry Results
    Should Be Equal As Strings    無任何項目    ${error_order_message}

Verify Order Condition Inquiry Results
    [Documentation]    Order condition inquiry result by number, channel, store
    [Arguments]    ${input_num}    ${input_channel}    ${input_store}
    ${order_num} =    Get Order Condition Inquiry Results    1    ${input_num}
    ${order_channel} =    Get Order Condition Inquiry Results    1    ${input_channel}
    ${order_store} =    Get Order Condition Inquiry Results    1    ${input_store}
    Should Be Equal As Strings    P2006P00236    ${order_num}
    Should Be Equal As Strings    Gogoro Taiwan Sales And Services    ${order_channel}
    Should Be Equal As Strings    土城裕民店    ${order_store}

Verify Order Number Inquiry Results
    [Documentation]    Order number inquiry result
    [Arguments]    ${input_num}    ${input_channel}    ${input_store}
    ${order_num} =    Get Order Number Inquiry Results    ${input_num}
    ${order_channel} =    Get Order Number Inquiry Results    ${input_channel}
    ${order_store} =    Get Order Number Inquiry Results    ${input_store}
    Should Be Equal As Strings    P2006P00236    ${order_num}
    Should Be Equal As Strings    Gogoro Taiwan Sales And Services    ${order_channel}
    Should Be Equal As Strings    土城裕民店    ${order_store}
