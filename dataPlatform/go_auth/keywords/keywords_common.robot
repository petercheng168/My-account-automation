*** Keywords ***
# -------- Gogoro Keywords --------
# -------- Verify Keywords --------
Verify GoAuth Error Message
    [Arguments]    ${resp}    ${error_code}    ${err_msg}
    Verify Response Contains Expected    ${resp.json()['code']}               -1
    Verify Response Contains Expected    ${resp.json()['additional_code']}    ${error_code}
    Should Contain                       ${resp.json()['message']}            ${err_msg}