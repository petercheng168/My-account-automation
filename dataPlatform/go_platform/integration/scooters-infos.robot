*** Settings ***
Documentation    Test suite of scooter deliveries
Resource    ../init.robot

Force Tags    Scooters    Scooter-Deliveries    Integration
Suite Setup    Setup Es Contract Variable
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${addon_code_recycle_fee}    SUBFEE-00003

*** Test Cases ***
scooters-infos - update - delivery scooter with recycle fee that addon end_date should be cycle end_date
    [Template]    Verify Recycle Fee Addon End Date Should Be Corrected
    5
    10
    15
    20
    25
    31

scooters-infos - update - scooters infos api should could get this es-contract's status history
    Delivery New Scooter
    Verify Es Contracts Histories With EsContract Id    es_contract_id=${EsContract.es_contract_id}    contract_owner_id=${None}

*** Keywords ***
# -------- Setup  Keywords --------
Setup Es Contract Variable
    [Arguments]    ${cycle_end_day}=${31}
    ${es_plan_id} =      Get Es Plan Id Via Es Plan Name        綁定 3 年 $899 方案
    ${promotion_id} =    Get Promotion Id Via Promotion Name    綁定 3 年 $899 方案
    ${30days_addon_code} =    Set Variable    SUBFEE-20002
    Set Suite Variable    ${EsContract}    ${EsContracts('${es_plan_id}', '${30days_addon_code}', promotion_id='${promotion_id}', cycle_end_day=${cycle_end_day})}

Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${Order}      ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}    ${Scooters('1500', 'AZ2')}
    Set Test Variable    ${User}       ${Users()}

Setup GSS Scooter
    Setup Test Object Variable
    ${User.user_id} =    Create User        ${User}
    ${scooter_id} =      Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contract With Addon And Promotion    ${EsContract}    ${Order}    ${User}

# -------- Gogoro Keywords --------
Delivery New Scooter
    Setup GSS Scooter
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}    sport_mode=1
    Scooters Infos Update
    ...    ${Order.order_no}    ${Scooter.vin}
    ...    ${User.user_id}      ${Order.owner_id}    ${User.gogoro_guid}
    ...    state=1              turn_light=1         brake_light=1
    ...    tpms=0               sport_mode=1
    ...    warranty_start=${Scooter.warranty_start}
    ...    warranty_end=${Scooter.warranty_end}

# -------- Verify Keywords --------
Verify Es Contracts Histories With EsContract Id
    [Arguments]    ${es_contract_id}    ${contract_owner_id}
    ${resp} =    Es Contracts Histories Get    es_contract_id=${es_contract_id}    contract_owner_id=${contract_owner_id}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${resp.json()["data"][0]["es_contract_id"]}       ${EsContract.es_contract_id}
    Verify Response Contains Expected    ${resp.json()["data"][0]["bill_to_user_id"]}      ${Order.owner_id}
    Verify Response Contains Expected    ${resp.json()["data"][0]["contract_owner_id"]}    ${Order.owner_id}
    Verify Response Contains Expected    ${resp.json()["data"][0]["contract_type"]}        ${1}
    Verify Response Contains Expected    ${resp.json()["data"][0]["status"]}               ${1}
    Verify Schema                        es-contracts-histories.json    esContractsHistories    ${resp.json()}

Verify Recycle Fee Addon End Date Should Be Corrected
    [Arguments]    ${cycle_end_day}
    Setup Es Contract Variable    ${cycle_end_day}
    Delivery New Scooter
    ${next_cycle_end_date} =    Get Next Cycle End Date    ${cycle_end_day}
    Verify Es Contract Addon End Date As Expected
    ...    es_contract_id=${EsContract.es_contract_id}
    ...    addon_code=${addon_code_recycle_fee}
    ...    expected=${next_cycle_end_date}