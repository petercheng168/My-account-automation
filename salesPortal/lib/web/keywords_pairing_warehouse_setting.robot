*** Settings ***
Resource    variables_pairing_warehouse_setting.robot

*** Keywords ***
# --------   SP Elements   --------
Click Filter Of Area
    [Documentation]    Click checkbox for first scooter model
    Click Visible Element    ${XPATH_FILTER_OF_AREA_DROPDOWN_MENU}    5s

Click Filter Of Belong
    [Documentation]    Click checkbox for first scooter model
    Click Visible Element    ${XPATH_FILTER_OF_BELONG_DROPDOWN_MENU}    5s
    
Click Filter Of Warehouse
    [Documentation]    Click checkbox for first scooter model
    Click Visible Element    ${XPATH_FILTER_OF_WAREHOUSE_DROPDOWN_MENU}    5s

Get Assign Store
    [Documentation]    get assign store name
    [Arguments]    ${store}
    Wait Until Element Is Visible    ${XPATH_WAREHOUSE_PAGE_TR}
    ${result}    Get Text    ${XPATH_WAREHOUSE_PAGE_TR}/td[contains(.,"${store}")]
    [Return]    ${result}

Input Text For Store Name
    [Documentation]    Input text for store name to search result
    [Arguments]    ${store}
    Click Visible Element    ${XPATH_STORE_NAME_INPUT_BOX}    5s
    Input Text    ${XPATH_STORE_NAME_INPUT_BOX}    ${store}

Remove Pairing Area
    [Documentation]    Remove pairing area
    Click Visible Element    ${XPATH_FILTER_OF_AREA_DROPDOWN_MENU}    5s
    Click Visible Element    ${XPATH_FILTER_OF_AREA_CLEAR_BUTTON}    5s

Remove Pairing Belong
    [Documentation]    Remove pairing belong
    Click Visible Element    ${XPATH_FILTER_OF_BELONG_DROPDOWN_MENU}    5s
    Click Visible Element    ${XPATH_FILTER_OF_BELONG_CLEAR_BUTTON}    5s

Remove Text For Store Name
    [Documentation]    Remove text for store name
    Click Visible Element    ${XPATH_STORE_NAME_INPUT_BOX}    5s
    Press Keys    ${XPATH_STORE_NAME_INPUT_BOX}    ESC

# --------   SP Keywords   --------
Select Pairing Area
    [Documentation]    Choose pairing area
    [Arguments]    ${area}
    Click Filter Of Area
    Click Visible Element  ${XPATH_AREA_OF_ORIENTATION_LI}\[contains(text(),"${area}")]    5s

Select Pairing Belong
    [Documentation]    Choose pairing belong
    [Arguments]    ${belong}
    Click Filter Of Belong
    Click Visible Element    ${XPATH_AREA_OF_BELONG_LI}\[contains(text(),"${belong}")]    5s

Select Pairing Warehouse
    [Documentation]    Choose pairing warehouse
    [Arguments]    ${warehouse}
    Click Filter Of Warehouse
    Click Visible Element  ${XPATH_AREA_OF_WAREHOUSE_LI}\[contains(text(),"${warehouse}")]    5s

# -------- Verify Keywords --------
Verify Store Filter
    [Documentation]    Check assign store whether to correctly display
    [Arguments]    ${store}
    ${store_name} =    Get Assign Store    ${store}
    Should Be Equal As Strings    ${store}    ${store_name}
