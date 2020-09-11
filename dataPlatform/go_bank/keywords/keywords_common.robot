*** Keywords ***
# -------- Gogoro Keywords --------
# -------- Verify Keywords --------
Verify GoBank Error Message
    [Arguments]    ${resp}    ${error_code}    ${err_msg}
    Verify Response Contains Expected    ${resp.json()['code']}       ${error_code}
    Should Contain                       ${resp.json()['message']}    ${err_msg}