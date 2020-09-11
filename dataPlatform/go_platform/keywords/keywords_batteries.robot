*** Keywords ***
# -------- Gogoro Keywords --------
Create Batteries
    [Documentation]    Create Battery
    [Arguments]    ${Battery}
    ${resp} =    Batteries Post    ${Battery.battery_guid}    ${Battery.battery_sn}    ${Battery.charge_cycles}\
    ...    ${Battery.state}    ${Battery.manufacture_date}    ${Battery.pn}
    [Return]    ${resp.json()['data'][0]['scooter_id']}
