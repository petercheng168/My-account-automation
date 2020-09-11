*** Keywords ***
# -------- MyGogoro Keywords --------
Save Scooter Information For Inactive
    [Documentation]    Save scooter information for inactive
    [Arguments]    ${plate}    ${scooter_vin}    ${file_name}    ${display_name}    ${last_six_sn}    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Subscription Inactive Vrc Put    ${plate}    ${scooter_vin}    ${file_name}\
    ...    ${display_name}    ${last_six_sn}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200

# -------- Verify Keywords --------