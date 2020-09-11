*** Keywords ***
# -------- Gogoro Keywords --------
Get Balance Via Es Contract Id
    [Arguments]    ${es_contract_id}=${EsContract.es_contract_id}
    ${balance_get} =       Es Contracts Balances Get      ${es_contract_id}
    ${org_credit} =        Set Variable If    ${balance_get.json()['data']}!=${{[]}}    ${balance_get.json()['data'][0]['credit']}     0
    ${org_balance} =       Set Variable If    ${balance_get.json()['data']}!=${{[]}}    ${balance_get.json()['data'][0]['balance']}    0
    [Return]    ${org_credit}    ${org_balance}

# -------- Verify Keywords --------
# ------- Templete Keywords -------
Verify Es Contract Balance Update With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${update_resp} =    Es Contracts Balances Update    &{fields}
	Verify Status Code As Expected       ${update_resp}    200
	Verify GoPlatform Error Message      ${update_resp}    ${additional_code}    ${err_msg}

Verify Es Contract Balance Update With Invalid Transaction Type
    [Arguments]    ${invalid_transaction_type}
    ${resp} =    Es Contracts Balances Update
    ...    es_contract_id=${EsContract.es_contract_id}
    ...    transaction_type=${invalid_transaction_type}
    ...    amount=${100}
    ...    source_id=${es_bill_writeoff_detail_id}
    Verify Status Code As Expected     ${resp}    200
	Verify GoPlatform Error Message    ${resp}    ${402010006}    ${err_transaction_type_invalid}

Verify Es Contract Balance Update With Valid Fields
    [Arguments]    ${amount}=${100.0}    &{fields}
    ${org_credit}  ${org_balance} =    Get Balance Via Es Contract Id    ${EsContract.es_contract_id}
    ${balance_update} =    Update Balance With Required Fields    amount=${amount}    &{fields}
    ${balance_get} =       Es Contracts Balances Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected           ${balance_get}       200
    Verify Response Json Data As Expected    ${balance_update}    amount_applied      ${amount}
    Verify Response Json Data As Expected    ${balance_update}    balance_remained    ${amount + ${org_credit} + ${org_balance}}
    Verify Response Json Data As Expected    ${balance_get}       credit              ${amount + ${org_credit}}
    Verify Response Json Data As Expected    ${balance_get}       balance             0.0
    Verify Response Json Data As Expected    ${balance_get}       es_contract_id      ${EsContract.es_contract_id}
