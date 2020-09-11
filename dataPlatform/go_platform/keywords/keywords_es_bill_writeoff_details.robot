*** Keywords ***
# -------- Gogoro Keywords --------
Create Es Bill Writeoff Detail
    [Documentation]    Create a es bill writeoff detail
    [Arguments]    ${transaction_id}    ${transaction_time}    ${es_bill_id}    ${amount}   ${credit_card_no}
    ${resp} =    Es Bill Writeoff Details Post    transaction_id=${transaction_id}    transaction_time=${transaction_time}    es_bill_id=${es_bill_id}    amount=${amount}   credit_card_no=${credit_card_no}
    [Return]    ${resp}

Create Es Bill Writeoff Detail With Overpay
    [Documentation]    Create a es bill writeoff detail with overpay
    [Arguments]    ${es_bill_id}         ${es_contract_id}
    ...            ${overpaid_amount}    ${overpaid_balance}    ${scooter_id}=${None}
    ${resp} =    Es Bill Writeoff Details With Balance
    ...    es_bill_id=${es_bill_id}    es_contract_id=${es_contract_id}
    ...    paid_amount=${overpaid_amount}
    ...    balance_amount=${overpaid_balance}
    ...    transaction_type=1
    ...    scooter_id=${scooter_id}
    ...    credit_card_no=87654321
    [Return]    ${resp}

Overpay To Bill
    [Arguments]    ${es_bill_id}    ${overpaid_amount}    ${overpaid_balance}=${None}
    Set Local Variable    ${balance}       ${EsBill.balance}
    ${overpaid_balance} =    Set Variable If    ${overpaid_balance}==${None}
    ...    ${overpaid_amount-${balance}}    # default overcharge
    ...    ${overpaid_balance}

	${resp} =    Create Es Bill Writeoff Detail With Overpay
    ...    es_bill_id=${es_bill_id}
    ...    es_contract_id=${EsContract.es_contract_id}
    ...    overpaid_amount=${overpaid_amount}
    ...    overpaid_balance=${overpaid_balance}
    ...    scooter_id=${Scooter.scooter_id}

    Es Bills Transitions Update    5    ${es_bill_id}
    [Return]    ${resp.json()['data'][0]['es_bill_writeoff_detail_id']}

Pay Amount To Bill
    [Arguments]    ${es_bill_id}    ${balance}
	${time_now} =    Evaluate    int(time.time())   time
    ${transaction_id} =    Set Variable    SWQA_${time_now * 1000}
	${resp} =    Create Es Bill Writeoff Detail
    ...    es_bill_id=${es_bill_id}    transaction_id=${transaction_id}
    ...    transaction_time=${time_now}
    ...    amount=${balance}
    ...    credit_card_no=87654321
    Es Bills Transitions Update    5    ${es_bill_id}
    [Return]    ${resp.json()['data'][0]['es_bill_writeoff_detail_id']}

Refund Overcharge To User
    [Documentation]    Refund overcharge to user
    [Arguments]    ${es_bill_id}    ${refund_amount}    ${refund_balance}
    ...            ${es_contract_id}=${EsContract.es_contract_id}    ${scooter_id}=${Scooter.scooter_id}
    ...            ${transaction_type}=5
    sleep    1s
    ${resp} =    Es Bill Writeoff Details With Balance
    ...    es_bill_id=${es_bill_id}    es_contract_id=${es_contract_id}
    ...    paid_amount=${refund_amount}
    ...    balance_amount=${refund_balance}
    ...    transaction_type=${transaction_type}
    ...    scooter_id=${scooter_id}
    ...    credit_card_no=87654321
    [Return]    ${resp}

Refund Paid Amount To User
    [Documentation]    Refund paid amount to user
    [Arguments]    ${es_bill_id}    ${balance}
	${time_now} =    Evaluate    int(time.time())   time
    sleep    1s
	${resp} =    Create Es Bill Writeoff Detail
    ...    es_bill_id=${es_bill_id}
    ...    transaction_id=${transaction_id}
    ...    transaction_time=${time_now}
    ...    amount=${balance}
    ...    credit_card_no=87654321

Refund With Invalid Transaction Type
    [Documentation]    Refund with invalid transaction type
    [Arguments]    ${es_bill_id}    ${refund_amount}    ${refund_balance}
    ...            ${es_contract_id}=${EsContract.es_contract_id}    ${scooter_id}=${Scooter.scooter_id}
    ${resp} =    Es Bill Writeoff Details With Balance
    ...    es_bill_id=${es_bill_id}    es_contract_id=${es_contract_id}
    ...    paid_amount=${refund_amount}
    ...    balance_amount=${refund_balance}
    ...    transaction_type=1
    ...    scooter_id=${scooter_id}
    ...    credit_card_no=87654321
    [Return]    ${resp}

# -------- Verify Keywords --------
# ------- Template Keywords -------
Verify Refund With Invalid Transaction Type
    [Arguments]    ${error_code}    ${err_msg}    ${transaction_type}
    ${resp} =  Refund Overcharge To User
    ...    es_bill_id=${EsBill.bill_id}
    ...    refund_amount=${refund_overcharge}
    ...    refund_balance=${refund_overcharge}
    ...    es_contract_id=${EsContract.es_contract_id}
    ...    transaction_type=${transaction_type}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    402010006    ${err_msg}