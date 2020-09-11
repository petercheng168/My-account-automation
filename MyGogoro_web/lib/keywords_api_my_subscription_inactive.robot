*** Keywords ***
# -------- MyGogoro Keywords --------
Activate Es Contract
    [Documentation]    Activate Es-Contract
    [Arguments]    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Subscription Inactive Post    ${gogoro-sess}    ${csrf_token}
    # Verify Status Code As Expected    ${resp}   201

# -------- Verify Keywords --------