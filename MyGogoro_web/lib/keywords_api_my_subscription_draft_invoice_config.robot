*** Keywords ***
# -------- MyGogoro Keywords --------
Set Invoice Config
    [Documentation]    Set invoice config
    [Arguments]    ${invoice_format}    ${title}    ${vatNumber}    ${includeVat}    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Subscription Draft Invoice Config Put    ${invoice_format}    ${title}\
    ...    ${vatNumber}    ${includeVat}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   201

# -------- Verify Keywords --------