*** Settings ***
Documentation    Test suite of es contracts balances
Resource    ../init.robot

Force Tags    Es-Contracts    Billing    Balances
Suite Setup     Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variable ***
${bill_balance}	                     ${499.0}
${description}                       SWQA
${err_amount_not_null}               default message [updateData[0].amount]]; default message [must not be null]
${err_decode_failed}                 decode failed
${err_es_bill_id}                    QLj9eb0m
${err_es_bill_writeoff_detail_id}    7m7Y4pRM
${err_invalid_amount}                ERROR: Invalid transaction amount: 0.00
${err_invalid_source_id}             invalid source_id
${err_need_one_of_id_code}           Need one of es_contract_id, es_contract_code
${err_no_relation}                   Cannot find relation
${err_no_write_off_detail}           Cannot find the write-off-detail
${err_not_be_negative}               ERROR: For overpay balance injection, the amount cannot be negative: -300.00
${err_scooter_id}                    gR0dj4dR
${err_source_id_not_null}            default message [updateData[0].sourceId]]; default message [must not be null]]
${err_source_id_of_type3}            Need numeric string while transaction_type equals 3
${err_transaction_type_invalid}      transaction_type must be in 3
${err_transaction_type_not_null}     default message [updateData[0].transactionType]]; default message [must not be null]
${zero_scooter_hash_id}              Z4mkaRPp

*** Test Cases ***
es-contracts-balances - update - update balance with invalid amount
    [Tags]    FET    CID:5254
    [Template]    Verify Es Contract Balance Update With Invalid Fields
    ${604040002}    ${err_invalid_amount}      es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=0    source_id=1

es-contracts-balances - update - update balance with invalid scooter id
    [Tags]    FET
    ${resp} =    Update Balance With Required Fields    ${EsContract.es_contract_id}    scooter_id=${zero_scooter_hash_id}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    604040002    ERROR: the es_contract dose not bind to the scooter of id: 0

es-contracts-balances - update - update balance with invalid source id
    [Tags]    FET
    [Template]    Verify Es Contract Balance Update With Invalid Fields
    ${402010006}    ${err_source_id_not_null}     es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=${100}    source_id=${None}                          description=${None}    scooter_id=${Scooter.scooter_id}
    ${402010006}    ${err_source_id_of_type3}     es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=${100}    source_id=${es_bill_writeoff_detail_id}    description=${None}    scooter_id=${Scooter.scooter_id}
    ${402010006}    ${err_invalid_source_id}      es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=${100}    source_id=0                                description=${None}    scooter_id=${Scooter.scooter_id}
    ${402010006}    ${err_invalid_source_id}      es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=${100}    source_id=13                               description=${None}    scooter_id=${Scooter.scooter_id}

es-contracts-balances - update - update balance with invalid required fields
    [Tags]    FET
    [Template]    Verify Es Contract Balance Update With Invalid Fields
    ${402010006}    ${err_amount_not_null}      es_contract_id=${None}    es_contract_code=${None}    transaction_type=${None}    amount=${None}    source_id=${None}    description=${None}           scooter_id=${None}

es-contracts-balances - update - update balance with invalid transaction_type
    [Tags]    FET    CID:5263
    [Template]    Verify Es Contract Balance Update With Invalid Transaction Type
    0
    1
    2
    4
    5
    6
    7
    8
    9

es-contracts-balances - update - update balance with valid required fields
    [Tags]    CID:5253    CID:5255
    [Template]    Verify Es Contract Balance Update With Valid Fields
    es_contract_id=${EsContract.es_contract_id}    transaction_type=3    amount=${100.0}     source_id=${numbers}
    es_contract_id=${EsContract.es_contract_id}    transaction_type=3    amount=${-100.0}    source_id=${numbers}

es-contracts-balances - update - update balance with valid source id
    [Tags]    CID:5256
    [Template]    Verify Es Contract Balance Update With Valid Fields
    transaction_type=3    source_id=1    description=${description}    scooter_id=${Scooter.scooter_id}
    transaction_type=3    source_id=2
    transaction_type=3    source_id=3
    transaction_type=3    source_id=4
    transaction_type=3    source_id=5
    transaction_type=3    source_id=6
    transaction_type=3    source_id=7
    transaction_type=3    source_id=8
    transaction_type=3    source_id=9
    transaction_type=3    source_id=10
    transaction_type=3    source_id=11
    transaction_type=3    source_id=12

es-contracts-balances-transition - get - get balance transition with empty response
    [Tags]    FET
    [Template]    Verify Es Contract Balance Transaction With Empty Response
    es_contract_id=${None}    transaction_type=${4}    source_id=${numbers}    scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${None}    offset=${None}    limit=${None}
    es_contract_id=${None}    transaction_type=${0}    source_id=${numbers}    scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${None}    offset=${None}    limit=${None}
    es_contract_id=${None}    transaction_type=${3}    source_id=${0}          scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${None}    offset=${None}    limit=${None}
    es_contract_id=${None}    transaction_type=${3}    source_id=${13}         scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${None}    offset=${None}    limit=${None}

es-contracts-balances-transition - get - get balance transition with invalid required fields
    [Tags]    FET
    [Template]    Verify Es Contract Balance Transaction With Invalid Fields
    ${604040002}    ERROR: Must provide at least one criteria                            es_contract_id=${None}    transaction_type=${None}    source_id=${None}       scooter_id=${None}                  by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${None}    offset=${None}    limit=${None}
    ${402010005}    Balance transaction create date from is later than create date to    es_contract_id=${None}    transaction_type=${None}    source_id=${numbers}    scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${10}      create_time_to=${0}       order=${None}    offset=${None}    limit=${None}

es-contracts-balances-transition - get - get balance transition with valid required fields
    [Setup]    Update Balance With Required Fields    source_id=${numbers}    scooter_id=${Scooter.scooter_id}
    [Template]    Verify Es Contract Balance Transaction With Valid Fields
    es_contract_id=${EsContract.es_contract_id}    transaction_type=${None}    source_id=${None}       scooter_id=${None}                  by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${2}    offset=${None}    limit=${None}
    es_contract_id=${EsContract.es_contract_id}    transaction_type=${None}    source_id=${None}       scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${2}    offset=${None}    limit=${None}
    es_contract_id=${EsContract.es_contract_id}    transaction_type=3          source_id=${numbers}    scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${2}    offset=${None}    limit=${None}
    es_contract_id=${EsContract.es_contract_id}    transaction_type=${None}    source_id=${numbers}    scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${2}    offset=${None}    limit=${None}
    es_contract_id=${None}                         transaction_type=3          source_id=${numbers}    scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${2}    offset=${None}    limit=${None}
    es_contract_id=${None}                         transaction_type=${None}    source_id=${numbers}    scooter_id=${Scooter.scooter_id}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${2}    offset=${None}    limit=${None}

*** Keywords ***
# -------- Setup  Keywords --------
Setup Variable
    ${es_plan_id} =    Get Latest Published Activate Es Plan Id
    ${numbers} =    Evaluate    random.choice(range(1, 12))
    Set Suite Variable    ${numbers}
    Set Suite Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}

Setup Suite Object Variable
    [Arguments]    ${brand_company_code}    ${model_code}
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Suite Variable    ${EsBill}     ${EsBills()}
    Set Suite Variable    ${Order}      ${Orders('P0${order_number}')}
    Set Suite Variable    ${Scooter}    ${Scooters('${brand_company_code}', '${model_code}')}
    Set Suite Variable    ${User}       ${Users()}

Suite Setup
    Setup Variable
    Setup Suite Object Variable    1500    AZ2
    Deliver Scooter To User    ${User}    ${Scooter}    ${Order}    ${EsContract}
    ${resp} =    Create Es Bill     ${EsBill}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    Es Bills Transitions Update    2    ${EsBill.bill_id}
    Es Bills Transitions Update    3    ${EsBill.bill_id}
    Es Bills Transitions Update    4    ${EsBill.bill_id}
    ${resp} =    Pay Amount To Bill     ${EsBill.bill_id}    ${bill_balance}
    Set Suite Variable    ${es_bill_writeoff_detail_id}    ${resp}

# -------- Gogoro Keywords --------
Update Balance With Required Fields
    [Arguments]    ${es_contract_id}=${EsContract.es_contract_id}
    ...            ${transaction_type}=3    ${amount}=${100.0}
    ...            ${source_id}=1           &{fields}
    sleep    0.5s
    ${balance_update} =    Es Contracts Balances Update
    ...    es_contract_id=${es_contract_id}
    ...    transaction_type=${transaction_type}
    ...    amount=${amount}
    ...    source_id=${source_id}
    ...    &{fields}
    Verify Status Code As Expected           ${balance_update}    200
    [Return]    ${balance_update}

# -------- Verify Keywords --------