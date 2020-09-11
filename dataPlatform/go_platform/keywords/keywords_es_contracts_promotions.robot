*** Keywords ***
# -------- Gogoro Keywords --------

# -------- Verify Keywords --------
Verify Es Promotion Effective Date Should Be Greater Than
    [Documentation]    Verify the es contract promotion effetive date should be greater than expected
    [Arguments]    ${es_contract_id}    ${expected}
    ${resp} =    Es Contracts Promotions Get    ${es_contract_id}
    Should Be Greater Than    ${resp.json()['data'][0]['effective_date']}    ${expected}

Verify Es Contract Promotion Effective Date As Expected
    [Documentation]    Verify the es contract promotion effetive date is expected or not
    [Arguments]    ${es_contract_id}    ${expected}
    ${resp} =    Es Contracts Promotions Get    ${es_contract_id}
    Should Be Equal As Strings    ${resp.json()['data'][0]['effective_date']}    ${expected}