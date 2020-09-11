*** Keywords ***
# -------- MyGogoro Keywords --------
Sign In MyGogoro Account To Return New Cookie
    [Documentation]    Sign-in MyGogoro account and return new gogoro-sess cookie
    [Arguments]    ${email}    ${password}
    ${gogoro_sess}    ${csrf_token} =    Account Signin Post    ${email}    ${password}    auth=return_gogoro_sess
    [Return]    ${gogoro_sess}    ${csrf_token}

# -------- Verify Keywords --------
Verify New Cookie Be Able To Use
    [Documentation]    Sign-in MyGogoro account and verify the cookie has been return
    [Arguments]    ${email}    ${password}
    ${resp} =    Account Signin Post    ${email}    ${password}
    Should Be Equal As Strings    ${resp.status_code}    200