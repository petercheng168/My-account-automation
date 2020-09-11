*** Keywords ***
# -------- MyGogoro Keywords --------
Save Plan To Subscription
    [Documentation]    Save plan to subscription
    [Arguments]    ${plan_Id}    ${sku}    ${locked_length}    ${charge_type}    ${charge_base}    ${charge_unit}    ${go_rewards}    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Subscription Draft Plan Put    ${plan_Id}\
    ...    ${sku}    ${locked_length}    ${charge_type}    ${charge_base}\
    ...    ${charge_unit}    ${go_rewards}    gogoro_sess=${gogoro-sess}    csrf_token=${csrf_token}
    Verify Status Code As Expected    ${resp}   201

# -------- Verify Keywords --------