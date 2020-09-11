*** Settings ***
Resource    variables_common.robot

*** Keywords ***
# -------- Sales Portal Elements --------
Click Button In Main Body
    [Documentation]    Click button in the main body which has six categories
    [Arguments]    ${input}
    Click Visible Element    //*[@id="root"]//h3[contains(.,"${input}")]    5s    2s

Click Menu Icon
    [Documentation]    Wait until menu icon is visible and click it
    Click Visible Element    ${XPATH_MENU_ICON_BUTTON}    3s    2s

Click Second Layer Item In Menu
    [Documentation]    Select the prospect item in menu
    [Arguments]    ${input}
    Click Visible Element    //a[@class="EntriesMenu_entry__1gver" and @href="/tw${input}"]    3s    2s

# -------- Sales Portal Keywords --------
Click First Layer Item In Menu
    [Documentation]    Click the item in menu which has seven categories
    [Arguments]    ${input}
    Click Menu Icon
    Click Visible Element    //a[@href="/tw${input}"]    3s    2s

# -------- Verify Keywords --------
