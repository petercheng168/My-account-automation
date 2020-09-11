*** Keywords ***
# -------- MyGogoro Elements -------- #
Click Button Type Button
    [Documentation]    Click button type button
    [Arguments]    ${text}
    Sleep    0.5s
    Wait Until Element Is Enabled    //button[@type="button"][contains(.,"${text}")]
    Click Element    //button[@type="button"][contains(.,"${text}")]

Click Rounded Button
    [Documentation]    Click rounded button
    [Arguments]    ${text}
    Sleep    0.5s
    Wait Until Element Is Enabled    //*[contains(@class,'RoundedButton__ThemedButton-iaiki0-0')][contains(.,"${text}")]
    Click Element     //*[contains(@class,'RoundedButton__ThemedButton-iaiki0-0')][contains(.,"${text}")]

Click Submit Type Button
    [Documentation]    Click submit type button
    [Arguments]    ${text}
    Sleep    0.5s
    Wait Until Element Is Enabled    //button[@type="submit"][contains(.,"${text}")]
    Click Element    //button[@type="submit"][contains(.,"${text}")]
    
# -------- MyGogoro Keywords --------
# -------- Verify Keywords --------