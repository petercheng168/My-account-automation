*** Keywords ***
# -------- Gogoro Keywords --------
Create Scooters
    [Documentation]    Create scooter
    [Arguments]    ${Scooter}
    ${resp} =    Scooters Post    ${Scooter.company_code}    TW    ${Scooter.vin}    ${Scooter.guid}    ${Scooter.matnr}
    ...    ${Scooter.atmel_key}    ${Scooter.state}    ${Scooter.es_state}    ${Scooter.ecu_status}
    ...    ${Scooter.keyfobs_status}    keyfobs_id=${Scooter.keyfobs_id}
    [Return]    ${resp.json()['data'][0]['scooter_id']}

Get Scooter Info
    [Documentation]    Get scooter information via scooter id
    [Arguments]    ${scooter_id}    ${fields_type}
    ${resp} =    Scooters Get    ${scooter_id}    ${fields_type}
    [Return]    ${resp}

# -------- Verify Keywords --------
Verify Scooter Is Existing
    [Documentation]    Verify the scooter has been created
    [Arguments]    ${scooter_id}    ${fields_type}
    ${resp} =    Scooters Get    ${scooter_id}    ${fields_type}
    Verify Response Contains Expected    ${resp.json()['data'][0]['scooter_id']}    ${scooter_id}

Verify Scooter Payment State As Expected
    [Documentation]    Verify the scooter's payment is correct
    [Arguments]    ${scooter_id}    ${expected_state}
    ${resp} =    Scooters Get    ${scooter_id}    general
    Verify Status Code As Expected       ${resp}        200
    Verify Response Contains Expected    ${resp.json()['data'][0]['payment_state']}    ${expected_state}

Verify Scooter Payment State Should Be Updated
    [Documentation]    Verify the scooter's payment should be updated within 10s by billing job
    [Arguments]    ${scooter_id}    ${expected_state}
    Wait Until Keyword Succeeds    30s    2s    Verify Scooter Payment State As Expected    ${scooter_id}    ${expected_state}