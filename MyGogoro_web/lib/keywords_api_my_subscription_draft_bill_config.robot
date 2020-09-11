*** Keywords ***
# -------- MyGogoro Keywords --------
Set Bill Config
    [Documentation]    Set bill config
    [Arguments]    ${isConsolidated}    ${bill_format}    ${includeRidingDetails}    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Subscription Draft Bill Config Put    ${isConsolidated}    ${bill_format}    ${includeRidingDetails}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   201

# -------- Verify Keywords --------