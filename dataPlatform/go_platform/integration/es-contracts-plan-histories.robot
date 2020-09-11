*** Settings ***
Documentation    Test suite of es-contracts/plan-histories
Resource    ../init.robot

Force Tags    Es-Contracts    Es-Contracts-Plan-Histories
Suite Setup    Suite Setup
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${105_plan_code}    SUBFEE-00040
${899_plan_code}    SUBFEE-40036

*** Test Cases ***
es-contracts-plan-histories - get - add addon to draft es_contract should not update plan history
    [Tags]    bug_581    solution_behavior
    [Setup]    Test Setup    ${105_plan_code}
    ${old_resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}
    Es Contracts Update Addons    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    2    1    ${EsContract.addon_id}    ${current_timestamp}    ${future_time}    ${current_timestamp}    1    0
    ${new_resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    sort_order=2
    Verify Status Code As Expected          ${new_resp}                                             200
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_start']}             ${new_resp.json()['data'][0]['plan_start']}
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_end']}               ${new_resp.json()['data'][0]['plan_end']}
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_effective_date']}    ${new_resp.json()['data'][0]['plan_effective_date']}
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${new_resp.json()}

es-contracts-plan-histories - get - add promotion to draft es_contract should not update plan history
    [Tags]    bug_581    solution_behavior
    [Setup]    Test Setup    ${105_plan_code}
    ${old_resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}
    Es Contracts Update Promotions    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    2    1    ${EsContract.promotion_id}    ${current_timestamp}    ${future_time}    ${current_timestamp}
    ${new_resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    sort_order=2
    Verify Status Code As Expected          ${new_resp}                                             200
    Verify Response Data Length Expected    ${new_resp.json()['data']}                              1
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_start']}             ${new_resp.json()['data'][0]['plan_start']}
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_end']}               ${new_resp.json()['data'][0]['plan_end']}
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_effective_date']}    ${new_resp.json()['data'][0]['plan_effective_date']}
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${new_resp.json()}

es-contracts-plan-histories - get - change plan to activate es_contract should insert data to plan history
    [Tags]    bug_581    solution_behavior
    [Setup]    Test Setup    ${899_plan_code}    es_contract_status=1
    Es Contracts Update Plan     ${EsContract.es_contract_id}    ${105_es_plan_id}    plan_end=0    plan_effective_date=${None}    status=2
    ${resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    sort_order=2
    Verify Es Contract Plan Histories As Expected    ${resp}    ${EsContract}    ${105_es_plan_id}
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${resp.json()}

es-contracts-plan-histories - get - change plan to draft es_contract should not update plan history
    [Tags]    bug_581    solution_behavior
    [Setup]    Test Setup    ${899_plan_code}
    ${old_resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}
    Es Contracts Update Plan     ${EsContract.es_contract_id}    ${105_es_plan_id}    plan_end=0    plan_effective_date=${None}    status=2
    ${new_resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    sort_order=2
    Verify Status Code As Expected          ${new_resp}                                             200
    Verify Response Data Length Expected    ${new_resp.json()['data']}                              1
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_start']}             ${new_resp.json()['data'][0]['plan_start']}
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_end']}               ${new_resp.json()['data'][0]['plan_end']}
    Verify Response Contains Expected       ${old_resp.json()['data'][0]['plan_effective_date']}    ${new_resp.json()['data'][0]['plan_effective_date']}
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${new_resp.json()}

es-contracts-plan-histories - get - get bundle es_contract
    [Setup]    Test Setup    ${899_plan_code}
    ${resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected                   ${resp}    200
    Verify Es Contract Plan Histories As Expected    ${resp}    ${EsContract}    ${EsContract.es_plan_id}
    Verify Response Contains Expected                ${resp.json()['data'][0]['include_free_regular_maintenance']}    0
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${resp.json()}

es-contracts-plan-histories - get - get non bundle es_contract
    [Setup]    Test Setup    ${105_plan_code}
    ${resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected                   ${resp}    200
    Verify Es Contract Plan Histories As Expected    ${resp}    ${EsContract}    ${EsContract.es_plan_id}
    Verify Response Contains Expected                ${resp.json()['data'][0]['include_free_regular_maintenance']}    0
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${resp.json()}

es-contracts-plan-histories - get - get plan history with ascending order
    [Setup]    Test Setup    ${899_plan_code}
    Es Contracts Update Plan     ${EsContract.es_contract_id}    ${105_es_plan_id}    plan_end=0    plan_effective_date=${EsContract.effective_date}    status=1
    ${resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    sort_order=${1}
    Verify Status Code As Expected                   ${resp}    200
    Verify Es Contract Plan Histories As Expected    ${resp}    ${EsContract}
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${resp.json()}

es-contracts-plan-histories - get - get plan history with descending order
    [Setup]    Test Setup    ${899_plan_code}
    Es Contracts Update Plan     ${EsContract.es_contract_id}    ${105_es_plan_id}    plan_end=0    plan_effective_date=${EsContract.effective_date}    status=1
    ${resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    sort_order=${2}
    Verify Status Code As Expected                   ${resp}    200
    Verify Es Contract Plan Histories As Expected    ${resp}    ${EsContract}    ${105_es_plan_id}
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${resp.json()}

es-contracts-plan-histories - get - get plan history with limit is -1
    [Tags]    FET
    [Setup]    Test Setup    ${899_plan_code}
    ${resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    limit=${-1}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${402010006}    must be greater than or equal to 0

es-contracts-plan-histories - get - get plan history with limit > 200
    [Setup]    Test Setup    ${899_plan_code}
    ${resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    limit=${limit}
    Verify Status Code As Expected                   ${resp}    200
    Verify Es Contract Plan Histories As Expected    ${resp}    ${EsContract}
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${resp.json()}

es-contracts-plan-histories - get - get plan history with offset is 1
    [Setup]    Test Setup    ${899_plan_code}
    ${resp} =    Es Contracts Plan Histories Get    ${EsContract.es_contract_id}    offset=${1}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data']}    []
    Verify Schema    es-contracts-plan-histories.json   esContractsPlanHistories    ${resp.json()}

*** Keywords ***
Setup Es Contract Variable
    [Arguments]    ${plan_code}
    ${es_plan_id} =      Get Es Plan Id Via Es Plan Code    ${plan_code}
    ${es_addons_id} =    Get Latest Published Activate Es Addon Id
    ${promotion_id} =    Get Latest Published Activate Es Promotion Id
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}', addon_id='${es_addons_id}', promotion_id='${promotion_id}')}

Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${Order}    ${Orders('P0${order_number}')}
    Set Test Variable    ${User}    ${Users()}

Suite Setup
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${future_time} =          Evaluate    int(time.time() + 10)    time
    ${105_es_plan_id} =    Get Es Plan Id Via Es Plan Code    SUBFEE-00040
    Set Suite Variable    ${current_timestamp}
    Set Suite Variable    ${future_time}
    Set Suite Variable    ${105_es_plan_id}

Test Setup
    [Arguments]    ${plan_code}    ${es_contract_status}=2
    Setup Test Object Variable
    Setup Es Contract Variable    ${plan_code}
    ${limit} =    Generate Random String    4    [NUMBERS]
    Set Test Variable    ${limit}
    ${User.user_id} =    Create User    ${User}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.effective_date}    1    1    ${es_contract_status}