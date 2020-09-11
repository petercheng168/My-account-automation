*** Keywords ***
# -------- Sales Portal Keywords --------
Get All Scooter Pairing Result
    [Documentation]    Get full scooter pairing result
    [Arguments]    ${start_date}    ${end_date}
    ...    ${company_id}    ${pairing_id}
    ...    ${offset}    ${limit}    ${token}
    ${resp} =    Get Scooter Pair Result Master Post    
    ...    start_date=${start_date}    end_date=${end_date}
    ...    offset=${offset}    limit=${limit}
    ...    company_id=${company_id}    pairing_id=${pairing_id}
    ...    token=${token}
    [Return]    ${resp.json()}

Get Scooter Pairing Result Detail
    [Documentation]    Give condition to get scooter pairing result detail
    [Arguments]    ${dms_order_no}    ${start_date}
    ...    ${end_date}    ${company_id}    ${department_id}
    ...    ${allocation_failure_reason}    ${offset}
    ...    ${limit}    ${token}
    ${resp} =    Get Scooter Pair Result Detail Post
    ...    ${dms_order_no}    ${start_date}    
    ...    ${end_date}   ${company_id}    ${department_id}
    ...    ${allocation_failure_reason}    ${offset}
    ...    ${limit}    ${token}
    [Return]    ${resp.json()}
