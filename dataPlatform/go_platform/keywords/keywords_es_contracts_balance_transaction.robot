*** Keywords ***
# -------- Gogoro Keywords --------
# -------- Verify Keywords --------
# ------- Template Keywords -------
Verify Es Contract Balance Transaction With Empty Response
    [Arguments]    ${es_contract_id}    ${transaction_type}    ${source_id}    ${scooter_id}    ${by_emp_id}    ${create_time_from}    ${create_time_to}    ${order}    ${offset}    ${limit}
    ${resp} =    Es Contracts Balances Transactions Get    ${es_contract_id}    ${transaction_type}    ${source_id}    ${scooter_id}    ${by_emp_id}    ${create_time_from}    ${create_time_to}    ${order}    ${offset}    ${limit}
	Verify Status Code As Expected    ${resp}    200
	Verify Response Contains Expected    ${resp.json()['data']}    []

Verify Es Contract Balance Transaction With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    ${es_contract_id}    ${transaction_type}    ${source_id}    ${scooter_id}    ${by_emp_id}    ${create_time_from}    ${create_time_to}    ${order}    ${offset}    ${limit}
    ${resp} =    Es Contracts Balances Transactions Get    ${es_contract_id}    ${transaction_type}    ${source_id}    ${scooter_id}    ${by_emp_id}    ${create_time_from}    ${create_time_to}    ${order}    ${offset}    ${limit}
	Verify Status Code As Expected     ${resp}    200
	Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}

Verify Es Contract Balance Transaction With Valid Fields
    [Arguments]    ${es_contract_id}    ${transaction_type}    ${source_id}
    ...            ${scooter_id}        ${by_emp_id}           ${create_time_from}
    ...            ${create_time_to}    ${order}               ${offset}
    ...            ${limit}
    ${resp} =    Es Contracts Balances Transactions Get
    ...    ${es_contract_id}    ${transaction_type}    ${source_id}
    ...    ${scooter_id}        ${by_emp_id}           ${create_time_from}
    ...    ${create_time_to}    ${order}               ${offset}
    ...    ${limit}
	Verify Status Code As Expected           ${resp}    200
    Verify Response Json Data As Expected    ${resp}    es_contract_id        ${EsContract.es_contract_id}
    Verify Response Json Data As Expected    ${resp}    transaction_type      3
    Verify Response Json Data As Expected    ${resp}    source_id             ${NUMBERS}