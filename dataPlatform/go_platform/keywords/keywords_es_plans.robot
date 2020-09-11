*** Keywords ***
# -------- Gogoro Keywords --------
Get All Es Plans
    [Documentation]    List all es plans
    [Arguments]    ${status}    ${published}    ${valid_time_from}    ${valid_time_to}
    ${resp} =    Es Plans Get    ${None}    ${status}    ${published}    ${valid_time_from}    ${valid_time_to}
    [Return]    ${resp}

Get Es Plan Code Via Es Plan Name
    [Documentation]    Get the specific es plan code via plan name
    [Arguments]    ${plan_name}     #${carrier_type}=${EMPTY}
    ${resp} =    Es Plans Get Via Plan Name    ${plan_name}         #carrier_type_list=${carrier_type_list}
    log     ${plan_name}
    [Return]    ${resp.json()['data'][0]['legacy_plan_code']}
    
Get Es Plan Id Via Es Plan Code
    [Documentation]    Filter es plan data via es plan code
    [Arguments]    ${plan_code}    ${carrier_type}=${EMPTY}
    ${carrier_type_list} =    Convert To List    ${carrier_type}
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${resp} =    Es Plans Get    status=1    published=1    valid_time_from=0    valid_time_to=${current_timestamp}    carrier_type_list=${carrier_type_list}
    ${es_plan_id} =    Evaluate    list(filter((lambda i: 'legacy_plan_code' in i.keys() and "${plan_code}" == i["legacy_plan_code"]), ${resp.json()['data']}))[0]['plan_id']    re
    [Return]    ${es_plan_id}

Get Es Plan Id Via Es Plan Name
    [Documentation]    Get the specific es plan id via plan name
    [Arguments]    ${plan_name}
    ${resp} =    Es Plans Get Via Plan Name    ${plan_name}
    [Return]    ${resp.json()['data'][0]['plan_id']}

Get Latest Published Activate Es Plan Id
    [Documentation]    Get the latest published and activate es plan's id (published: 1, status: 1)
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${es_plan_resp} =    Get All Es Plans    1    1    0    ${current_timestamp}
    [Return]    ${es_plan_resp.json()['data'][0]['plan_id']}

# -------- Verify Keywords --------