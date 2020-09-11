*** Keywords ***
Encode Password
    [Documentation]    Encode password
    [Arguments]    ${password}
    ${resp} =    Encode Password Get    ${password}
    [Return]    ${resp.text}