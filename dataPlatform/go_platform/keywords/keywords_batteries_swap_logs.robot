*** Keywords ***
# -------- Gogoro Keywords --------
Swap Scooter Batteries Via OBC
    [Arguments]    ${scooter_guid}    ${battery_guid_1}    ${battery_guid_2}    ${battery_guid_3}    ${battery_guid_4}    ${riding_distance}    ${total_distance}
    ${swap_id} =    Generate Random String    8    [NUMBERS]
    Batteries Swap Logs Post OBC    ${VM_GUID}    ${swap_id}    ${scooter_guid}
    ...    ${battery_guid_1}     ${battery_guid_2}    ${battery_guid_3}    ${battery_guid_4}
    ...    ${riding_distance}    ${total_distance}    ${exchange_time}

Swap Scooter Batteries Via VM
    [Arguments]    ${scooter_guid}    ${battery_guid_1}    ${battery_guid_2}    ${battery_guid_3}    ${battery_guid_4}    ${riding_distance}    ${total_distance}
    ${swap_id} =    Generate Random String    8    [NUMBERS]
    Batteries Swap Logs Post Vm    ${VM_GUID}    ${swap_id}    ${scooter_guid}
    ...    ${battery_guid_1}     ${battery_guid_2}    ${battery_guid_3}    ${battery_guid_4}
    ...    ${riding_distance}    ${total_distance}    ${exchange_time}