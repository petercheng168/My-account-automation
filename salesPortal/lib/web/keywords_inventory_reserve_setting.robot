*** Settings ***
Resource    variables_inventory_reserve_setting.robot

*** Keywords ***
# --------   SP Elements   --------
Click Assign Scooter Model Checkbox
    [Documentation]    Click checkbox for first scooter model
    [Arguments]    ${row}
    Click Visible Element    ${XPATH_INVENTORY_RESERVE_SETTING_TBODY}/tr[${row}]//input[@type="checkbox"]    3s

Click Quantity Setting
    [Documentation]    Click quantity setting button
    Click Visible Element    ${XPATH_QUANTITY_SETTING_BUTTON}    3s

Click Quantity Setting Confirm
    [Documentation]    Click quantity setting confirm button
    Click Visible Element    ${XPATH_QUANTITY_SETTING_CONFIRM_BUTTON}    3s

Get Assign Row SKU Search Result 
    [Documentation]    Get SKU search result for first row
    [Arguments]    ${row}    ${category}
    Wait Until Element Is Visible    ${XPATH_SKU_SEARCH_RESULT_CHOOSE_CATEGORY}/tr[${row}]/td[${category}]
    ${result} =    Get Text    ${XPATH_SKU_SEARCH_RESULT_CHOOSE_CATEGORY}/tr[${row}]/td[${category}]
    [Return]    ${result}

Get Scooter Model Inventory Reserve Number
    [Documentation]    Get scooter model reserve number
    [Arguments]    ${row}
    Wait Until Element Is Not Visible    ${XPATH_QUANTITY_SETTING_BOX_SUCCESS_DISPLAY}    5s
    Sleep    0.5s
    Wait Until Element Is Visible    ${XPATH_INVENTORY_RESERVE_SETTING_TBODY}/tr[${row}]/td[5]    5s
    ${num} =    Get Text    ${XPATH_INVENTORY_RESERVE_SETTING_TBODY}/tr[${row}]/td[5]
    [Return]    ${num}

# --------   SP Keywords   --------
Change Inventory Reserve Number
    [Documentation]    Change Inventory Reverse Number
    [Arguments]    ${row}    ${reserve_input_num}
    Click Assign Scooter Model Checkbox    ${row}
    Click Quantity Setting
    Input Reserve Number    quantity    ${reserve_input_num}
    Click Quantity Setting Confirm

Input Code For SKU Searchbox
    [Documentation]    Input code for SKU search
    [Arguments]    ${sku_input}
    Click Visible Element  ${XPATH_SKU_SEARCH_INPUT}  3s
    Input Text    ${XPATH_SKU_SEARCH_INPUT}    ${sku_input}

Input Reserve Number
    [Documentation]    Input reserve num
    [Arguments]    ${element}    ${reserve_input_num}
    Wait Until Element Is Visible    ${XPATH_QUANTITY_SETTING_BOX_SUCCESS_DISPLAY}    5s
    Click Visible Element    ${XPATH_INPUT_RESERVE_QUANTITY_NUMBER_BOX}    3s
    Input Text In Element By Name    ${element}    ${reserve_input_num}

# -------- Verify Keywords --------
Verify Assign Row Of Scooter Model Inventory Reserve Number
    [Documentation]    Check assign scooter model's inventory reserve num whether to change
    [Arguments]    ${row}    ${reserve_input_num}
    ${current_num} =    Get Scooter Model Inventory Reserve Number    ${row}
    Should Be Equal As Strings    ${current_num}    ${reserve_input_num}

Verify Color Of Assign Row By SKU Search Result
    [Documentation]    Search SKU result for assign row
    [Arguments]    ${row}    ${category}
    ${color} =    Get Assign Row SKU Search Result    ${row}   ${category}
    Should Be Equal As Strings    紅    ${color}

Verify SKU Of Assign Row By SKU Search Result
    [Documentation]    Search SKU result for assign row
    [Arguments]    ${row}    ${category}
    ${SKU_code} =    Get Assign Row SKU Search Result    ${row}   ${category}
    Should Be Equal As Strings    GSBCK-000-RD    ${SKU_code}
