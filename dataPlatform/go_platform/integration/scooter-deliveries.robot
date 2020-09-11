*** Settings ***
Documentation    Test suite of scooter deliveries
Resource    ../init.robot

Force Tags      Scooters    Scooter-Deliveries    Integration
Suite Setup     Setup Es Contract Variable
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${addon_code_30days}          SUBFEE-20002
${addon_code_free_249}        SUBFEE-00002
${addon_code_recycle_fee}     SUBFEE-00003

*** Test Cases ***
scooter-deliveries - update - GDK - with 30 trial addon - addon effective date should exist
    [Tags]    Bug-Issue
    [Setup]    Setup Yamaha Scooter
    ${resp} =    Scooter Deliveries Update    ${None}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}    ${EsContract.es_contract_id}
    Verify Status Code As Expected                               ${resp}                         200
    Verify Es Contract Status As Expected                        ${EsContract.es_contract_id}    1
    Verify Es Addon Effective Date Should Be Greater Than        ${EsContract.es_contract_id}    SUBFEE-20002    ${timestamp_cur}
    Verify Es Plan Effective Date Should Be Greater Than         ${EsContract.es_contract_id}    ${timestamp_cur}
    Verify Es Promotion Effective Date Should Be Greater Than    ${EsContract.es_contract_id}    ${timestamp_cur}

scooter-deliveries - update - GDK - with sport mode - addon effective date should exist
    [Setup]    Setup Yamaha Scooter    ${addon_code_free_249}
    ${resp} =    Scooter Deliveries Update    ${None}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}    ${EsContract.es_contract_id}
    Verify Status Code As Expected                               ${resp}                         200
    Verify Es Contract Status As Expected                        ${EsContract.es_contract_id}    1
    Verify Es Addon Effective Date Should Be Greater Than        ${EsContract.es_contract_id}    SUBFEE-00002    ${timestamp_cur}
    Verify Es Plan Effective Date Should Be Greater Than         ${EsContract.es_contract_id}    ${timestamp_cur}
    Verify Es Promotion Effective Date Should Be Greater Than    ${EsContract.es_contract_id}    ${timestamp_cur}

scooter-deliveries - update - GDK - delivery scooter should could get this es-contract's status history
    [Setup]    Setup Yamaha Scooter
    ${resp} =    Scooter Deliveries Update    ${None}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}    ${EsContract.es_contract_id}
    Verify Status Code As Expected                             ${resp}                         200
    Verify Es Contracts Histories With EsContract Id    es_contract_id=${EsContract.es_contract_id}    contract_owner_id=${None}

scooter-deliveries - update - GDK - delivery scooter with recycle fee that addon end_date should be cycle end_date
    [Template]    Verify Recycle Fee Addon End Date Should Be Corrected
    GDK    5
    GDK    10
    GDK    15
    GDK    20
    GDK    25
    GDK    31

scooter-deliveries - update - GSS - with 30 trial addon - addon effective date should be delivery date
    [Tags]    Bug-Issue
    [Setup]    Setup GSS Scooter Contract To Delivery Status
    ${resp} =    Scooter Deliveries Update    ${Order.order_id}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}
    ${delivery_date} =    Get Scooter Delivery Date    ${Order.order_id}
    Should Be Greater Than                                     ${delivery_date}                ${timestamp_cur}
    Verify Status Code As Expected                             ${resp}                         200
    Verify Es Contract Status As Expected                      ${EsContract.es_contract_id}    1
    Verify Es Contract Addon Effective Date As Expected        ${EsContract.es_contract_id}    ${EsContract.addon_code}    ${delivery_date}
    Verify Es Contract Plan Effective Date As Expected         ${EsContract.es_contract_id}    ${delivery_date}
    Verify Es Contract Promotion Effective Date As Expected    ${EsContract.es_contract_id}    ${delivery_date}

scooter-deliveries - update - GSS - with sport mode - addon effective date should be delivery date
    [Setup]    Setup GSS Scooter Contract To Delivery Status    ${addon_code_free_249}
    ${resp} =    Scooter Deliveries Update    ${Order.order_id}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}
    ${delivery_date} =    Get Scooter Delivery Date    ${Order.order_id}
    Should Be Greater Than                                     ${delivery_date}                ${timestamp_cur}
    Verify Status Code As Expected                             ${resp}                         200
    Verify Es Contract Status As Expected                      ${EsContract.es_contract_id}    1
    Verify Es Contract Addon Effective Date As Expected        ${EsContract.es_contract_id}    ${EsContract.addon_code}    ${delivery_date}
    Verify Es Contract Plan Effective Date As Expected         ${EsContract.es_contract_id}    ${delivery_date}
    Verify Es Contract Promotion Effective Date As Expected    ${EsContract.es_contract_id}    ${delivery_date}

scooter-deliveries - update - GSS - delivery scooter with recycle fee that addon end_date should be cycle end_date
    [Template]    Verify Recycle Fee Addon End Date Should Be Corrected
    GSS    5
    GSS    10
    GSS    15
    GSS    20
    GSS    25
    GSS    31

scooter-deliveries - update - GSS - delivery scooter should could get this es-contract's status history
    [Setup]    Setup GSS Scooter Contract To Delivery Status
    ${resp} =    Scooter Deliveries Update    ${Order.order_id}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}
    Verify Status Code As Expected    ${resp}    200
    Verify Es Contracts Histories With EsContract Id    es_contract_id=${EsContract.es_contract_id}    contract_owner_id=${None}

*** Keywords ***
# -------- Setup  Keywords --------
Setup Es Contract Variable
    [Arguments]    ${cycle_end_day}=${31}
    ${es_plan_id} =      Get Es Plan Id Via Es Plan Name       綁定 3 年 $899 方案
    ${promotion_id} =    Get Promotion Id Via Promotion Name   綁定 3 年 $899 方案
    Set Suite Variable    ${cycle_end_day}
    Set Suite Variable    ${es_plan_id}
    Set Suite Variable    ${promotion_id}

Setup GSS Scooter Contract To Delivery Status
    [Arguments]    ${addon_code}=${addon_code_30days}
    Setup Test Object Variable    1500    AZ2    ${addon_code}
    ${User.user_id} =    Create User        ${User}
    ${scooter_id} =      Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contract With Addon And Promotion    ${EsContract}    ${Order}    ${User}
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}    sport_mode=1

Setup Test Object Variable
    [Arguments]    ${brand_company_code}    ${model_code}    ${addon_code}
    ${timestamp_cur} =    Evaluate    int(time.time())   time
    ${order_number} =     Generate Random String    8    [NUMBERS]
    Set Test Variable    ${timestamp_cur}
    Set Test Variable    ${Order}         ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}       ${Scooters('${brand_company_code}', '${model_code}')}
    Set Test Variable    ${User}          ${Users()}
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}', '${addon_code}', promotion_id='${promotion_id}', cycle_end_day=${cycle_end_day})}

Setup Yamaha Scooter
    [Arguments]    ${addon_code}=${addon_code_30days}
    Setup Test Object Variable    B22318608    BUS    ${addon_code}
    ${User.user_id} =        Create User            ${User}
    ${contract_user_id} =    Create Contract User   ${User}
    ${scooter_id} =          Create Scooters        ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Set Variable    ${None}    ${contract_user_id}
    ${EsContract.es_contract_id} =    Create Es Contract With Addon And Promotion    ${EsContract}    ${Order}    ${User}
    Es Contracts Update Scooters    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    2    1    ${scooter_id}
    GDK Scooters Update Plate       ${Scooter.vin}    ${Scooter.plate}    ${Scooter.plate_date}

# -------- Gogoro Keywords --------
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
    [Arguments]    ${brand_company}    ${cycle_end_day}
    Setup Es Contract Variable    cycle_end_day=${cycle_end_day}
    ${next_cycle_end_date} =    Get Next Cycle End Date    ${cycle_end_day}
    Run Keyword If    '${brand_company}'=='GSS'
    ...    Setup GSS Scooter Contract To Delivery Status
    ...    ELSE
    ...    Setup Yamaha Scooter
    ${resp} =    Scooter Deliveries Update    ${Order.order_id}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}    ${EsContract.es_contract_id}
    Verify Status Code As Expected                   ${resp}    200
    Verify Es Contract Addon End Date As Expected    es_contract_id=${EsContract.es_contract_id}    addon_code=${addon_code_recycle_fee}    expected=${next_cycle_end_date}