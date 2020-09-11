*** Keywords ***
# -------- MyGogoro Keywords --------
Add Addon With Empty Payload
    [Documentation]    Add addon with empty payload
    [Arguments]    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Subscription Draft Addon Put    gogoro_sess=${gogoro-sess}    csrf_token=${csrf_token}
    Verify Status Code As Expected    ${resp}   201

Add Addon With Specific Addon Code
    [Documentation]    Add addon with addon code
    [Arguments]    ${addon_code}    ${gogoro-sess}    ${csrf_token}
    ${addon_data} =    Get Addon Data Via Addon Code    ${addon_code}
    ${resp} =    Api My Subscription Draft Addon Put    ${addon_data['addon_id']}    ${addon_code}    ${addon_data['price']}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   201
    [Return]    ${addon_data['addon_id']}

# -------- Verify Keywords --------