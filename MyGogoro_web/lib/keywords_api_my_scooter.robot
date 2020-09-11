*** Keywords ***
# -------- MyGogoro Keywords --------
Save Scooter Detail To Redis With Getting All Scooter
    [Documentation]    Get all scooter and save the scooter information to redis for other APIs be able to get scooter detail
    [Arguments]    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Scooter Get    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200

# -------- Verify Keywords --------
Verify User Contains Scooter
    [Documentation]    Verify user contains scooters via api/my/scooter
    [Arguments]    ${scooter_Id}    ${scooter_guid}    ${scooter_plate}    ${scooter_vin}    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Scooter Get    ${gogoro-sess}    ${csrf_token}
    ${value} =    Evaluate    list(filter((lambda i: re.search("${scooter_Id}", i['id'])), ${resp.json()['items']}))    re
    Should Be Equal As Strings    ${value[0]}    {'id': '${scooter_Id}', 'guid': '${scooter_guid}', 'plate': '${scooter_plate}', 'vin': '${scooter_vin}', 'paymentStatus': 'normal', 'batteryCount': 2}
    Log     ${resp.json()} 