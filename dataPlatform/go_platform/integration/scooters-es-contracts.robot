*** Settings ***
Documentation    Test suite of scooters es contracts
Resource    ../init.robot

Force Tags    Scooters
Suite Setup    Deliver Scooter To User
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
scooters-es-contracts - get - get general data should contain plan type
    [Template]    Verify Scooters Es Contracts Get General Response
    ${Scooter.scooter_id}    ${None}             ${None}          ${None}
    ${None}                  ${Scooter.plate}    ${None}          ${None}
    ${None}                  ${None}             ${Scooter.vin}   ${None}
    ${None}                  ${None}             ${None}          ${Scooter.guid}

scooters-es-contracts - get - get detail data should without plan type
    [Template]    Verify Scooters Es Contracts Get Detail Response
    ${Scooter.plate}    ${None}
    ${None}             ${Scooter.vin}

*** Keywords ***
Deliver Scooter To User
    Setup Es Contract Variable
    Setup Test Object Variable    1500    AZ2
    ${User.user_id} =    Create User    ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    1    turn_light=1    brake_light=1    tpms=0    sport_mode=0    warranty_start=${Scooter.warranty_start}    warranty_end=${Scooter.warranty_end}

Setup Es Contract Variable
    ${es_plan_id} =    Get Latest Published Activate Es Plan Id
    Set Suite Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}

Setup Test Object Variable
    [Arguments]    ${brand_company_code}    ${model_code}
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${password} =    Encode Password Get    Gogoro123
    Set Suite Variable    ${Order}      ${Orders('P0${order_number}')}
    Set Suite Variable    ${Scooter}    ${Scooters('${brand_company_code}', '${model_code}')}
    Set Suite Variable    ${User}       ${Users('${password.text}')}

Verify Scooters Es Contracts Get Detail Response
    [Arguments]    ${scooter_plate}   ${scooter_vin}
    ${resp} =    Scooters Es Contracts Get    ${None}   ${None}   ${None}   ${None}   ${scooter_plate}   ${scooter_vin}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['es_contract_id']}    ${EsContract.es_contract_id}
    Verify Schema    scooters-es-contracts.json    scooterEsContractsGetDetail    ${resp.json()}

Verify Scooters Es Contracts Get General Response
    [Arguments]    ${scooter_ids}    ${scooter_plates}    ${scooter_vins}    ${scooter_guids}
    ${resp} =    Scooters Es Contracts Get    ${scooter_ids}    ${scooter_plates}    ${scooter_vins}    ${scooter_guids}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['scooter_id']}    ${Scooter.scooter_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['es_contract_id']}    ${EsContract.es_contract_id}
    Verify Schema    scooters-es-contracts.json    scooterEsContractsGetGeneral    ${resp.json()}