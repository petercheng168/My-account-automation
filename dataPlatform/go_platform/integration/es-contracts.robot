*** Settings ***
Documentation    Test suite of es-contracts addons
Resource    ../init.robot

Force Tags    Es-Contracts
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-contract - search - search es_contract via user_id
    [Setup]    Test Setup
    ${resp} =    Es Contracts Search    ${User.user_id}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['es_contract_id']}    ${EsContract.es_contract_id}
    Verify Schema    es-contract.json    esContractsSearch    ${resp.json()}

es-contract - update - update addons to draft es contracts
    [Setup]    Test Setup
    ${resp} =    Es Contracts Update Addons    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    2    1    ${EsContract.addon_id}    ${current_timestamp}    ${future_time}    ${current_timestamp}    1    0
    Verify Status Code As Expected    ${resp}    200

es-contract - update - update expired es_contract promotions end_date should be failed
    [Tags]    FET    Flex-Plan
    [Setup]    Test Setup For Expired Es Contract Promotion
    ${resp} =    Es Contracts Update Promotions    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    1    3    ${EsContract.promotion_id}    ${current_timestamp}    ${future_time}    ${future_time}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    604040002    Unable to UPDATE the promotion from the ES Contact because it is not exist or expired already

*** Keywords ***
Setup Es Contract Variable
    ${es_plan_id} =    Get Latest Published Activate Es Plan Id
    ${es_addons_id} =    Get Latest Published Activate Es Addon Id
    ${promotion_id} =    Get Latest Published Activate Es Promotion Id
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}', addon_id='${es_addons_id}', promotion_id='${promotion_id}')}

Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${Order}    ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}    ${Scooters('1500', 'AZ2')}
    Set Test Variable    ${User}    ${Users()}
    Setup Es Contract Variable

Suite Setup
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${future_time} =    Evaluate    int(time.time() + 10)    time
    Set Suite Variable    ${current_timestamp}
    Set Suite Variable    ${future_time}

Test Setup
    Setup Test Object Variable
    ${User.user_id} =          Create User    ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}   1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2

Test Setup For Expired Es Contract Promotion
    Test Setup
    Es Contracts Update Promotions    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    1    1    ${EsContract.promotion_id}    ${current_timestamp}    ${current_timestamp}    ${current_timestamp}