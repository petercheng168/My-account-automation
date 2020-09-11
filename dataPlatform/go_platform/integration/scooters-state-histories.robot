*** Settings ***
Documentation    Test suite of scooters/state-histories
Resource    ../init.robot

Force Tags    Scooters    State-Histories
Suite Setup    Setup Es Contract Variable
Test Setup    Setup Scooter Contract To Delivery Status
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
scooters-state-histories - get - delivery scooter with new plate, new plate_date
    [Setup]    Delivery Scooter
    ${resp} =    Scooters State Histories Get    ${Scooter.scooter_id}    state_type=4    sort_order=2
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['scooter_id']}    ${Scooter.scooter_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['plate']}    ${expected_plate}
    Verify Schema    scooters-state-histories.json    scootersStateHistoriesGetPlate    ${resp.json()}

scooters-state-histories - get - transfer scooter with new plate, new plate_date
    [Setup]    Transfer Scooter To New User
    ${resp} =    Scooters State Histories Get    ${Scooter.scooter_id}    state_type=4    sort_order=2
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['scooter_id']}    ${Scooter.scooter_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['plate']}    ${expected_trans_plate}
    Verify Schema    scooters-state-histories.json    scootersStateHistoriesGetPlate    ${resp.json()}

scooters-state-histories - get - update scooter data
    [Template]    Verify Scooter History After Update Scooter Data
    payment_state    1                    2    scootersStateHistoriesGetPaymentState
    plate            ${expected_plate}    4    scootersStateHistoriesGetPlate
    state            11                   1    scootersStateHistoriesGetState

*** Keywords ***
Delivery Scooter
    Setup Scooter Contract To Delivery Status
    ${plate_date} =    Evaluate    int(time.time())    time
    Scooter Deliveries Update    ${Order.order_id}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}    new_plate=${expected_plate}    new_plate_date=${plate_date}

Setup Es Contract Variable
    ${es_plan_id} =    Get Es Plan Id Via Es Plan Name    綁定 3 年 $899 方案
    Set Suite Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}

Setup Scooter Contract To Delivery Status
    Setup Test Object Variable
    ${User.user_id} =          Create User    ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}    sport_mode=0
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    1    turn_light=1    brake_light=1    tpms=0    sport_mode=0    warranty_start=${Scooter.warranty_start}    warranty_end=${Scooter.warranty_end}

Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${now_timestamp} =    Evaluate    int(time.time())    time
    ${plate_number} =    Generate Random String    4    [NUMBERS]
    Set Test Variable    ${now_timestamp}
    Set Test Variable    ${expected_plate}    SWQA-${plate_number}
    Set Test Variable    ${Order}      ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}    ${Scooters('1500', 'AZ2')}
    Set Test Variable    ${User}       ${Users()}

Transfer Scooter To New User
    ${sing_date} =    Evaluate    time.strftime("%Y-%m-%d")    time
    ${NewUser} =    Set Variable    ${Users()}
    ${NewUser.user_id} =    Create User    ${NewUser}
    ${plate_number} =    Generate Random String    4    [NUMBERS]
    Set Test Variable    ${expected_trans_plate}    SWQA-${plate_number}
    Delivery Scooter
    ${plate_date} =    Evaluate    int(time.time())    time
    Scooter Transfers Update    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${expected_plate}    ${expected_trans_plate}    ${NewUser.user_id}    ${NewUser.user_id}    ${sing_date}    new_plate_date=${plate_date}

Verify Scooter History After Update Scooter Data
    [Arguments]    ${field}    ${update_value}    ${state_type}    ${schema}
    Scooters Update    ${Scooter.scooter_id}    ${field}=${update_value}
    ${resp} =    Scooters State Histories Get    ${Scooter.scooter_id}    state_type=${state_type}    sort_order=2
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['scooter_id']}    ${Scooter.scooter_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['${field}']}    ${update_value}
    Verify Schema    scooters-state-histories.json    ${schema}    ${resp.json()}