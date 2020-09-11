*** Keywords ***
# -------- MyGogoro Keywords --------
# -------- Verify Keywords --------
Verify Subscription Invoice Config Is Correct
    [Documentation]    Verify scooter subscription invoice config is correct
    [Arguments]    ${type}    ${scooter_Id}    ${invoice_format}    ${title}    ${vatNumber}    ${includeVat}    ${gogoro-sess}    ${csrf_token}    ${donate_to}=${NONE}
    ${resp} =    Api My Scooter ScooterId Subscription Get    ${scooter_Id}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Run Keyword If    '${type}' == 'Donation'    Verify Response Contains Expected    ${resp.json()['invoiceConfig']}    {'format': '${invoice_format}', 'title': '${title}', 'vatNumber': '${vatNumber}', 'includeVat': ${includeVat}, 'eCarrierConfig': {'donateTo': '${donate_to}'}}
    ...    ELSE    Verify Response Contains Expected    ${resp.json()['invoiceConfig']}    {'format': '${invoice_format}', 'title': '${title}', 'vatNumber': '${vatNumber}', 'includeVat': ${includeVat}}