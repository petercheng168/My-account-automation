*** Keywords ***
# -------- Gogoro Keywords --------
Get Scooters By CS Portal
    [Documentation]    Scooters Maintenances Get By Assembled Date From And To
    [Arguments]    ${assembled_date_from}    ${assembled_date_to}
    ${resp} =    Scooters Maintenances Get Via Assembled Date
    ...    assembled_date_from=${assembled_date_from}
    ...    assembled_date_to=${assembled_date_to}
    ...    account=${CIPHER_CS_PORTAL_ACCOUNT}
    ...    go_client=${GO_CLIENT_HEADER_CS_PORTAL}
    [Return]    ${resp}