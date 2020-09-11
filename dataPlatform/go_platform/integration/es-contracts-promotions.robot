*** Settings ***
Documentation    Test suite of es-contracts promotions
Resource    ../init.robot

Force Tags    Es-Contracts
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-contracts-promotions - get - es_contract promotion is correct
    [Setup]    Update Promotions To Es Contracts
    ${resp} =    Es Contracts Promotions Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['promotion_id']}    ${EsContract.promotion_id}
    Verify Schema    es-contracts-promotions.json    esContractsPromotionsGet    ${resp.json()}

es-contracts-promotions - update - expired promotion end_date should successful
    [Tags]    Flex-Plan
    [Setup]    Test Setup For Expired Flex Plan
    ${update_resp} =    Es Contracts Promotions Update    ${EsContract.es_contract_id}    ${EsContract.promotion_id}    ${current_timestamp}    ${future_time}
    ${get_resp} =    Es Contracts Promotions Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected       ${update_resp}    200
    Verify Status Code As Expected       ${get_resp}       200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['end_date']}    ${future_time}
    Verify Schema    es-contracts-promotions.json    esContractsPromotionsGet    ${get_resp.json()}

*** Keywords ***
Setup Es Contract Variable
    ${es_plan_id} =      Get Latest Published Activate Es Plan Id
    ${promotion_id} =    Get Latest Published Activate Es Promotion Id
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}', promotion_id='${promotion_id}')}

Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${Order}      ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}    ${Scooters('1500', 'AZ2')}
    Set Test Variable    ${User}       ${Users()}

Suite Setup
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${future_time} =          Evaluate    int(time.time() + 10)    time
    Set Suite Variable    ${current_timestamp}
    Set Suite Variable    ${future_time}

Test Setup
    Setup Test Object Variable
    ${User.user_id} =          Create User    ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001

Test Setup For Expired Flex Plan
    Test Setup
    Set Test Variable    ${EsContract}    ${EsContracts()}
    ${EsContract.es_contract_id}    ${EsContract.promotion_id} =    Create Es Contract With Flex Plan    ${Order}    ${User}    start_date=${current_timestamp}    effective_date=${current_timestamp}    end_date=${current_timestamp}

Update Promotions To Es Contracts
    Test Setup
    Setup Es Contract Variable
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
    Es Contracts Update Promotions    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    1    1    ${EsContract.promotion_id}    ${current_timestamp}    ${future_time}    ${current_timestamp}
