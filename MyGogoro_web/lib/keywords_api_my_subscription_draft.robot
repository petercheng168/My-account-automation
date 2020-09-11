*** Keywords ***
# -------- MyGogoro Keywords --------
Save Draft Subscription
    [Documentation]    Save draft subscription
    [Arguments]    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Subscription Draft Post    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   201
    [Return]    ${resp}

# -------- Verify Keywords --------