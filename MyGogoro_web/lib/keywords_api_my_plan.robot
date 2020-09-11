*** Keywords ***
# -------- MyGogoro Keywords --------
Get Public Plan Detail
    [Documentation]    Get public plan detail via plan_code
    [Arguments]    ${plan_code}    ${gogoro-sess}    ${csrf_token}
    ${resp}    ${plan} =    Api My Plan Get    ${plan_code}    ${gogoro-sess}
    Verify Status Code As Expected    ${resp}    200
    [Return]    ${plan}

# -------- Verify Keywords --------