*** Keywords ***
# -------- Setup  Keywords --------
# -------- Gogoro Keywords --------
Deliver Scooter To User
    [Arguments]    ${User}    ${Scooter}    ${Order}    ${EsContract}
    ${User.user_id} =          Create User        ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}  ${Order.owner_id} =    Create Order
    ...    VEH_SALE_CR        ${Order.order_no}
    ...    I                  ${User.user_id}      30001
    ${EsContract.es_contract_id} =    Create Es Contracts
    ...    ${Order.order_id}     ${User.user_id}      1
    ...    ${Order.owner_id}     1                    ${Order.owner_id}
    ...    ${EsContract.es_plan_id}
    ...    ${EsContract.start_date}    1    1    2
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}
    Scooters Infos Update
    ...    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}
    ...    ${Order.owner_id}    ${User.gogoro_guid}
    ...    state=1
    ...    turn_light=1    brake_light=1
    ...    tpms=0          sport_mode=0
    ...    warranty_start=${Scooter.warranty_start}
    ...    warranty_end=${Scooter.warranty_end}

Update Scooter Contract To Delivery Approval Status
    [Documentation]    Update the scooter contract to delivery approval status (DA)
    ...                Order's order_id, owner_id shouldn't is None.
    [Arguments]    ${Order}    ${Scooter}    ${User}    ${sport_mode}=0
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    0    turn_light=1    brake_light=1    tpms=0    sport_mode=${sport_mode}
    Orders Update    ${Order.order_id}    VEH_SALE_CR    ${Order.order_no}    ${NONE}    ${User.user_id}    30004    1    delivery_place=ES313020
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    2    turn_light=1    brake_light=1    tpms=0    sport_mode=${sport_mode}
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    3    turn_light=1    brake_light=1    tpms=0    sport_mode=${sport_mode}
    Orders Update    ${Order.order_id}    VEH_SALE_CR    ${Order.order_no}    R     ${User.user_id}    50001    1    plate=${Scooter.plate}    plate_date=${Scooter.plate_date}
    Orders Update    ${Order.order_id}    VEH_SALE_CR    ${Order.order_no}    DA    ${User.user_id}    50001    1

# -------- Verify Keywords --------