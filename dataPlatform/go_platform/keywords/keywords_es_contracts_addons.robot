*** Keywords ***
# -------- Gogoro Keywords --------
Get Addon Data Via Addon Code
    [Documentation]    Get addon data via addon code
    [Arguments]    ${addon_code}
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${resp} =    Es Addons Get    ${None}    ${None}    1    1    0    ${current_timestamp}
    ${addon_data} =    Evaluate    list(filter((lambda i: 'addon_code' in i.keys() and "${addon_code}" == i["addon_code"]), ${resp.json()['data']}))[0]    re
    [Return]    ${addon_data}

Get Addon Id Via Addon Code
    [Documentation]    Get addon data via addon code
    [Arguments]    ${addon_code}
    ${addon_data} =   Get Addon Data Via Addon Code    ${addon_code}
    [Return]     ${addon_data['addon_id']}

Get Latest Published Activate Es Addon Id
    [Documentation]    Get the latest published and activate es promotion's id (published: 1, status: 1)
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${resp} =    Es Addons Get    ${None}    1    1    0    ${current_timestamp}
    [Return]    ${resp.json()['data'][0]['addon_id']}

# -------- Verify Keywords --------
Verify Es Addon Effective Date Should Be Greater Than
    [Documentation]    Verify the es contract expected result addon end date should be greater than expected
    [Arguments]    ${es_contract_id}    ${addon_code}    ${expected}
    ${resp} =    Es Contracts Addons Get    ${es_contract_id}
    ${addon_data} =    Evaluate    list(filter((lambda i: 'addon_code' in i.keys() and "${addon_code}" == i["addon_code"]), ${resp.json()['data']}))[0]    re
    Should Be Greater Than    ${addon_data['effective_date']}    ${expected}

Verify Es Contract Addon Effective Date As Expected
    [Documentation]    Verify the es contract addon effetive date is expected or not
    [Arguments]    ${es_contract_id}    ${addon_code}    ${expected}
    ${resp} =    Es Contracts Addons Get    ${es_contract_id}
    ${addon_data} =    Evaluate    list(filter((lambda i: 'addon_code' in i.keys() and "${addon_code}" == i["addon_code"]), ${resp.json()['data']}))[0]    re
    Should Be Equal As Strings    ${addon_data['effective_date']}    ${expected}

Verify Es Contract Addon End Date As Expected
    [Documentation]    Verify the es contract addon end date is expected or not
    [Arguments]    ${es_contract_id}    ${addon_code}    ${expected}    ${time_from}=${None}
    ${resp} =    Es Contracts Addons Get    ${es_contract_id}    ${time_from}
    ${addon_data} =    Evaluate    list(filter((lambda i: 'addon_code' in i.keys() and "${addon_code}" == i["addon_code"]), ${resp.json()['data']}))[0]    re
    Should Be Equal As Strings    ${addon_data['end_date']}    ${expected}

Verify Es Contract Addon Key Should Not Exist
    [Documentation]    Verify the es contract addon's specific key should not found
    [Arguments]    ${es_contract_id}    ${key}
    ${resp} =    Es Contracts Addons Get    ${es_contract_id}
    Dictionary Should Not Contain Key    ${resp.json()['data'][0]}    ${key}