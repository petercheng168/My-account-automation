*** Settings ***
Documentation    Test suite of es contracts balances transaction
Resource    ../init.robot

Force Tags    Es-Contracts    Balances
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-contracts-balances-transactions - get - order is 1 will return create_time ASC transaction_id ASC
    ${resp} =    Es Contracts Balances Transactions Get    es_contract_id=${EsContract.es_contract_id}    transaction_type=${None}    source_id=${None}       scooter_id=${None}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${1}    offset=${None}    limit=${None}
	Verify Status Code As Expected       ${resp}    200
	Verify Response Contains Expected    ${resp.json()["data"][0]["amount"]}     ${100.0}
	Verify Response Contains Expected    ${resp.json()["data"][0]["source_id"]}    1
    Verify Response Contains Expected    ${resp.json()["data"][1]["amount"]}     ${200.0}
	Verify Response Contains Expected    ${resp.json()["data"][1]["source_id"]}    2
    Verify Response Contains Expected    ${resp.json()["data"][2]["amount"]}     ${300.0}
	Verify Response Contains Expected    ${resp.json()["data"][2]["source_id"]}    3
    Verify Response Contains Expected    ${resp.json()["data"][3]["amount"]}     ${400.0}
	Verify Response Contains Expected    ${resp.json()["data"][3]["source_id"]}    3

es-contracts-balances-transactions - get - order is 2 will return create_time DESC, transaction_id ASC
    ${resp} =    Es Contracts Balances Transactions Get    es_contract_id=${EsContract.es_contract_id}    transaction_type=${None}    source_id=${None}       scooter_id=${None}    by_emp_id=${None}    create_time_from=${None}    create_time_to=${None}    order=${2}    offset=${None}    limit=${None}
	Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${resp.json()["data"][0]["amount"]}     ${300.0}
	Verify Response Contains Expected    ${resp.json()["data"][0]["source_id"]}    3
    Verify Response Contains Expected    ${resp.json()["data"][1]["amount"]}     ${400.0}
	Verify Response Contains Expected    ${resp.json()["data"][1]["source_id"]}    3
	Verify Response Contains Expected    ${resp.json()["data"][2]["amount"]}     ${200.0}
	Verify Response Contains Expected    ${resp.json()["data"][2]["source_id"]}    2
    Verify Response Contains Expected    ${resp.json()["data"][3]["amount"]}     ${100.0}
	Verify Response Contains Expected    ${resp.json()["data"][3]["source_id"]}    1

*** Keywords ***
# -------- Setup  Keywords --------
Setup Variable
    ${es_plan_id} =    Get Latest Published Activate Es Plan Id
    ${numbers} =    Evaluate    random.choice(range(1, 11))
    Set Suite Variable    ${numbers}
    Set Suite Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}

Setup Test Object Variable
    [Arguments]    ${brand_company_code}    ${model_code}
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${password} =        Encode Password Get    Gogoro123
    Set Suite Variable    ${EsBill}        ${EsBills()}
    Set Suite Variable    ${Order}    ${Orders('P0${order_number}')}
    Set Suite Variable    ${Scooter}    ${Scooters('${brand_company_code}', '${model_code}')}
    Set Suite Variable    ${User}    ${Users('${password.text}')}

Suite Setup
    Deliver Scooter To User
    Update Es Contract Balance    es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=${100}    source_id=${1}    description=${None}    scooter_id=${Scooter.scooter_id}
    sleep    1s
    Update Es Contract Balance    es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=${200}    source_id=${2}    description=${None}    scooter_id=${Scooter.scooter_id}
    sleep    1s
    Update Es Contract Balance    es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=${300}    source_id=${3}    description=${None}    scooter_id=${Scooter.scooter_id}
    Update Es Contract Balance    es_contract_id=${EsContract.es_contract_id}    es_contract_code=${None}    transaction_type=3    amount=${400}    source_id=${3}    description=${None}    scooter_id=${Scooter.scooter_id}

# -------- Gogoro Keywords --------
Deliver Scooter To User
    Setup Variable
    Setup Test Object Variable    1500    AZ2
    ${User.user_id} =          Create User    ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    1    turn_light=1    brake_light=1    tpms=0    sport_mode=0    warranty_start=${Scooter.warranty_start}    warranty_end=${Scooter.warranty_end}

Update Es Contract Balance
    [Arguments]    ${es_contract_id}    ${es_contract_code}    ${transaction_type}    ${amount}    ${source_id}    ${description}    ${scooter_id}
    ${update_resp} =    Es Contracts Balances Update    ${es_contract_id}    ${es_contract_code}    ${transaction_type}    ${amount}    ${source_id}    ${description}    ${scooter_id}

# -------- Verify Keywords --------