*** Settings ***
Documentation    API baseline of es-plans

Variables       ../../../env.py
Variables       ${PROJECT_ROOT}/setting.py    dev

Library         ${GP_API_ROOT}/LibEsBillScootersEsBills.py
Library         ${GP_LIB_ROOT}/LibJSONSchema.py

Resource        ${DP_ROOT}/standard_library_init.robot

Resource        ${PROJECT_ROOT}/lib/keywords_common.robot
Resource        ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource        ${GP_KEYWORD_ROOT}/keywords_es_plans.robot

Force Tags      Es-Bills
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${es_bill_id}                             1LpKErbm
${scooter_id_1}                           VLoE0vZN
${scooter_id_2}                           3RGkwAVR
${es_contract_id}                         6mQqBBam
${bill_period}                            2019-12
${payment_status}                         0
${bill_status}                            4
@{bill_status_list}                       ${bill_status}
@{invalid_bill_status_list}               9
@{invalid_with_valid_bill_status_list}    9    4
${invalid_bill_period}                    2019-22-1
&{invalid_dict}                           err=test

*** Test Cases ***
es-bill-scooters-es-bills - get - invalid - get with invalid fields
    [Tags]    FET
    [Template]    Verify Es Bill Scooters Es Bills With Invalid Fields
    402010001    JSON parse error                                 bill_status_list=""
    402010001    JSON parse error                                 bill_status_list=&{invalid_dict}
    402010006    must be less than or equal to 500                limit=501
    402010006    get_data.order is invalid                        order=3
    402010006    must match \"^\\d{4}-\\d{2}\"]                   bill_period=2019-22-1
    604040002    bill_status_list contains invalid bill_status    bill_status_list=${invalid_bill_status_list}
    604040002    bill_status_list contains invalid bill_status    bill_status_list=${invalid_with_valid_bill_status_list}
    803010003    decode failed                                    scooter_id=0
    803010003    decode failed                                    es_contract_id=0

es-bill-scooters-es-bills - get - valid - get es_bill with specific bill
	[Template]    Verify Es Bill Scooters Es Bills With Specific Bill
    scooter_id=${scooter_id_1}
    scooter_id=${scooter_id_2}
    es_contract_id=${es_contract_id}
    scooter_id=${scooter_id_1}          bill_period=${bill_period}
    scooter_id=${scooter_id_1}          payment_status=${payment_status}
    scooter_id=${scooter_id_1}          bill_status_list=${bill_status_list}

es-bill-scooters-es-bills - get - valid - get es_bill with valid fields
    ${resp} =    Es Bill Scooters Es Bills Get
    Verify Status Code As Expected    ${resp}    200
    Verify Schema    es-bill-scooters-es-bills.json    esBillScootersEsBillsGet    ${resp.json()}

*** Keywords ***
# -------- Setup  Keywords --------
# -------- Gogoro Keywords --------
# -------- Verify Keywords --------
Verify Es Bill Scooters Es Bills With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Es Bill Scooters Es Bills Get    &{fields}
    Verify Status Code As Expected      ${resp}    200
    Verify GoPlatform Error Message     ${resp}    ${additional_code}    ${err_msg}

Verify Es Bill Scooters Es Bills With Specific Bill
    [Arguments]    &{fields}
    ${resp} =    Es Bill Scooters Es Bills Get    &{fields}
    ${data} =    Set Variable    ${resp.json()['data'][0]}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${data['es_bill_id']}        ${es_bill_id}
    Verify Response Contains Expected    ${data['bill_period']}       ${bill_period}
    Verify Response Contains Expected    ${data['payment_status']}    ${payment_status}
    Verify Response Contains Expected    ${data['bill_status']}       ${bill_status}
    Verify Schema    es-bill-scooters-es-bills.json    esBillScootersEsBillsGet    ${resp.json()}