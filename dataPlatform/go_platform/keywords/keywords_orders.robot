*** Keywords ***
# -------- Gogoro Keywords --------
Create Order
    [Documentation]    Create order with customize order type
    [Arguments]    ${order_type}    ${order_number}    ${order_state}    ${user_id}    ${flow_status}
    ${resp} =    Orders Post    ${order_type}    ${order_number}    ${order_state}    ${user_id}    ${flow_status}
    [Return]    ${resp.json()['data'][0]['order_id']}    ${resp.json()['data'][0]['owner_id']}

Get Scooter Delivery Date
    [Documentation]    Get scooter's delivery date from scooter contract (r44)
    [Arguments]    ${order_id}
    ${order_resp} =    Orders Get    order_type=scooter    order_id=${order_id}
    [Return]    ${order_resp.json()['data'][0]['r44']}
    
# -------- Verify Keywords --------