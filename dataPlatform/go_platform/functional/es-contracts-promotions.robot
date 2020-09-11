*** Settings ***
Documentation    API baseline of es-contract-promotions

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GP_API_ROOT}/LibEsAddons.py
Library           ${GP_API_ROOT}/LibEsContractsPromotions.py
Library           ${GP_API_ROOT}/LibEsPlans.py
Library           ${GP_API_ROOT}/LibOrders.py

Resource          ${DP_ROOT}/standard_library_init.robot
Resource          ../init.robot
Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_contracts.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_plans.robot

Force Tags      Es-Contract-Promotion
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${addon_code_30days}    SUBFEE-20002

*** Test Cases ***
es-contract-promotions - get - invalid - get es-contract-promotions with invalid required fields
    [Tags]    FET
    [Template]   Verify Es Contracts Promotions Get With Invalid Fields
    803010003    decode failed     es_contract_id='1'

es-contract-promotions - get - invalid - get es-contract-promotions with null required fields
    [Tags]    FET
    [Template]   Verify Es Contracts Promotions Get With Invalid Fields
    402010006    [getData.esContractId]]; default message [must not be null]     es_contract_id=${None}


#es-contract-promotions - get - valid - get es-contract-promotions with correct value
#    # TODO time_from time_to
#    ${resp_get} =   Es Contracts Promotions Get    ${EsContract.es_contract_id}
#
#    Verify Status Code As Expected        ${resp_get}    200
#    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    promotion_id
#    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    promotion_code
#    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    create_time
#    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    update_time
#    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    effective_terms

es-contract-promotions - get - valid - get es-contract-promotions with required fields
    ${resp_get} =   Es Contracts Promotions Get    ${EsContract.es_contract_id}

    Verify Status Code As Expected        ${resp_get}    200
    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    promotion_id
    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    promotion_code
    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    create_time
    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    update_time
    Dictionary Should Contain Key     ${resp_get.json()['data'][0]}    effective_terms

es-contract-promotions - update - invalid - update es-contract-promotions with invalid required fields
    [Tags]    FET
    [Template]   Verify Es Contracts Promotions Update With Invalid Fields
    803010003  decode failed                                                                          es_contract_id='1'        promotion_id=ygR0wXLG   start_date=123
    803010003  decode failed                                                                          es_contract_id=ygR0wXLG   promotion_id='1'        start_date=123
    402010006  [updateData[0].startDate],0]; default message [must be greater than or equal to 0]     es_contract_id=ygR0wXLG   promotion_id=ygR0wXLG   start_date=-1
    402010006  start_date, end_date [from] is larger than [to]                                        es_contract_id=ygR0wXLG   promotion_id=ygR0wXLG   start_date=123  end_date=122

es-contract-promotions - update - invalid - update es-contract-promotions with null required fields
    [Tags]    FET
    [Template]   Verify Es Contracts Promotions Update With Invalid Fields
    402010006  [updateData[0].esContractId]]; default message [must not be null]   es_contract_id=${None}    promotion_id=ygR0wXLG   start_date=123
    402010006  [updateData[0].promotionId]]; default message [must not be null]    es_contract_id=ygR0wXLG   promotion_id=${None}    start_date=123
    402010006  [updateData[0].startDate]]; default message [must not be null]      es_contract_id=ygR0wXLG   promotion_id=ygR0wXLG   start_date=${None}

es-contract-promotions - update - valid - update es-contract-promotions with correct value
    ${resp_get} =   Es Contracts Promotions Get    ${EsContract.es_contract_id}
    Dictionary Should Not Contain Key     ${resp_get.json()['data'][0]}    end_date

    ${resp_update} =  Es Contracts Promotions Update
    ...   es_contract_id=${EsContract.es_contract_id}
    ...   promotion_id=${resp_get.json()['data'][0]['promotion_id']}
    ...   start_date=${resp_get.json()['data'][0]['start_date']}
    ...   end_date=${end_date}

    ${resp_get} =   Es Contracts Promotions Get    ${EsContract.es_contract_id}

    Verify Status Code As Expected        ${resp_get}    200
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['end_date']}    ${end_date}

es-contract-promotions - update - valid - update es-contract-promotions with required fields
    ${resp_get} =   Es Contracts Promotions Get    ${EsContract.es_contract_id}

    ${resp_update} =  Es Contracts Promotions Update
    ...   es_contract_id=${EsContract.es_contract_id}
    ...   promotion_id=${resp_get.json()['data'][0]['promotion_id']}
    ...   start_date=${resp_get.json()['data'][0]['start_date']}
    ...   end_date=${None}

    ${resp_get} =   Es Contracts Promotions Get    ${EsContract.es_contract_id}

    Verify Status Code As Expected        ${resp_get}    200
    Dictionary Should Not Contain Key     ${resp_get.json()['data'][0]}    end_date

*** Keywords ***
Test Setup
    ${promotion_id} =    Get Promotion Id Via Promotion Name   綁定 3 年 $899 方案
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${es_plan_id} =    Get Es Plan Id Via Es Plan Name    綁定 3 年 $899 方案
    ${end_date}=    Get Current Date    increment=15 days        result_format=epoch    exclude_millis=yes
    ${end_date}=    Convert To Integer    ${end_date}

    Set Test Variable    ${User}    ${Users()}
    Set Test Variable    ${Order}    ${Orders('P0${order_number}')}
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}', '${addon_code_30days}', promotion_id='${promotion_id}')}
    Set Test Variable    ${end_date}

    ${User.user_id} =    Create User    ${User}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contract With Addon And Promotion    ${EsContract}    ${Order}    ${User}

Verify Es Contracts Promotions Update With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =   Es Contracts Promotions Update   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Es Contracts Promotions Get With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =   Es Contracts Promotions Get   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}