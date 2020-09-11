*** Settings ***
Documentation    API integration of es-bill-writeoff-details
Resource    	../init.robot

Force Tags      Es-Bill-Writeoff-Details
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${GSS_company_code}       1500
${GSS_model_code}         AZ2
${brand_company_code}     B22318608
${model_code}             BUS

${bill_balance}                 ${499.0}
${full_paid_amount}	            ${bill_balance}          #499
${overpaid_amount}              ${bill_balance + 100}    #599
${partial_paid_amount}          ${bill_balance - 100}    #399

${overcharge_amount}            ${overpaid_amount - ${bill_balance}}    #100
${refund_overcharge}            ${-${overcharge_amount}}                #-100
${refund_partial_overcharge}    ${-${overcharge_amount - 50}}           #-50
${refund_full_paid_amount}      ${-${full_paid_amount}}                 #-499
${refund_overpaid_amount}       ${-${overpaid_amount}}                  #-599
${refund partial paid}          ${-${partial_paid_amount}}              #-399

*** Test Cases ***
es-bill-writeoff-details - add - invalid - pay the draft bill should be failed
    [Tags]    FET
    [Setup]    Setup Bill With Specific Status    1
	${resp} =    Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1    amount=${EsBill.balance}    credit_card_no=87654321
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    604040002    ERROR: the draft bill cannot be paid for the bill_id: ${decode_bill_id}

es-bill-writeoff-details - add - valid - pay the approved bill
    [Setup]    Setup Bill With Specific Status    2
	${resp} =        Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1    amount=${EsBill.balance}    credit_card_no=87654321
    ${resp_get} =    Es Bill Writeoff Details Get     es_bill_id=${EsBill.bill_id}
    ${bill_get} =    Es Bills Get                     es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected         ${resp}                        				      200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}      				      es_bill_writeoff_detail_id
    Verify Response Json Data As Expected    ${resp_get}    transaction_id    ${transaction_id}
    Verify Response Json Data As Expected    ${resp_get}    amount            ${EsBill.balance}
    Verify Response Json Data As Expected    ${bill_get}    paid_amount       ${EsBill.balance}

es-bill-writeoff-details - add - valid - pay the issued bill
    [Setup]    Setup Bill With Specific Status    4
	${resp} =        Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1    amount=${EsBill.balance}    credit_card_no=87654321
    ${resp_get} =    Es Bill Writeoff Details Get     es_bill_id=${EsBill.bill_id}
    ${bill_get} =    Es Bills Get                     es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected         ${resp}                        				      200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}      				      es_bill_writeoff_detail_id
    Verify Response Json Data As Expected    ${resp_get}    transaction_id    ${transaction_id}
    Verify Response Json Data As Expected    ${resp_get}    amount            ${EsBill.balance}
    Verify Response Json Data As Expected    ${bill_get}    paid_amount       ${EsBill.balance}

es-bill-writeoff-details - add - valid - pay the invoiced bill (partial pay)
    [Setup]    Setup Invoiced Bill    299
    ${resp} =        Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}_2    transaction_time=1    amount=${200}    credit_card_no=87654321
    ${resp_get} =    Es Bill Writeoff Details Get     es_bill_id=${EsBill.bill_id}
    ${bill_get} =    Es Bills Get                     es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected         ${resp}                        				      200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}      				      es_bill_writeoff_detail_id
    Verify Response Json Data As Expected    ${resp_get}    transaction_id    ${transaction_id}
    Verify Response Json Data As Expected    ${resp_get}    amount            299.0                0
    Verify Response Json Data As Expected    ${resp_get}    amount            200.0                1
    Verify Response Json Data As Expected    ${bill_get}    paid_amount       ${EsBill.balance}

# TODO
# es-bill-writeoff-details - add - valid - pay the invoiced bill (overpay)

es-bill-writeoff-details - add - valid - pay the pdf generated bill
    [Setup]    Setup Bill With Specific Status    3
	${resp} =        Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1    amount=${EsBill.balance}    credit_card_no=87654321
    ${resp_get} =    Es Bill Writeoff Details Get     es_bill_id=${EsBill.bill_id}
    ${bill_get} =    Es Bills Get                     es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected         ${resp}                      200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    es_bill_writeoff_detail_id
    Verify Response Json Data As Expected    ${resp_get}    transaction_id    ${transaction_id}
    Verify Response Json Data As Expected    ${resp_get}    amount            ${EsBill.balance}
    Verify Response Json Data As Expected    ${bill_get}    paid_amount       ${EsBill.balance}


es-bill-writeoff-details - add - valid - pay the reconciled bill
    [Setup]    Setup Bill With Specific Status    5
	${resp} =        Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1    amount=${EsBill.balance}    credit_card_no=87654321
    ${resp_get} =    Es Bill Writeoff Details Get     es_bill_id=${EsBill.bill_id}
    ${bill_get} =    Es Bills Get                     es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected         ${resp}                      200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    es_bill_writeoff_detail_id
    Verify Response Json Data As Expected    ${resp_get}    transaction_id    ${transaction_id}
    Verify Response Json Data As Expected    ${resp_get}    amount            ${EsBill.balance}
    Verify Response Json Data As Expected    ${bill_get}    paid_amount       ${EsBill.balance}


es-bill-writeoff-details - add - overpaid bill that unissued_invoice_amount should be paid_amount
    [Tags]    CID:4
    [Setup]    Setup Bill With Specific Status    4
    Overpay To Bill    ${EsBill.bill_id}    ${overpaid_amount}
    Es Bills Transitions Update    5    ${EsBill.bill_id}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected    ${es_bill_resp}    200
    Verify Response Json Data As Expected    ${es_bill_resp}    payment_status             1
    Verify Response Json Data As Expected    ${es_bill_resp}    paid_amount                ${overpaid_amount}
    Verify Response Json Data As Expected    ${es_bill_resp}    unissued_invoice_amount    ${overpaid_amount}

es-bill-writeoff-details - add - paid completed bill that unissued_invoice_amount should be paid_amount
    [Tags]    CID:2
    [Setup]    Setup Bill With Specific Status    4
    Pay Amount To Bill    ${EsBill.bill_id}    ${bill_balance}
    Es Bills Transitions Update    5    ${EsBill.bill_id}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected    ${es_bill_resp}    200
    Verify Response Json Data As Expected    ${es_bill_resp}    payment_status             1
    Verify Response Json Data As Expected    ${es_bill_resp}    paid_amount                ${full_paid_amount}
    Verify Response Json Data As Expected    ${es_bill_resp}    unissued_invoice_amount    ${full_paid_amount}

es-bill-writeoff-details - add - partial paid bill that unissued_invoice_amount = paid_amount
    [Tags]    CID:6
    [Setup]    Setup Bill With Specific Status    4
    Pay Amount To Bill    ${EsBill.bill_id}    ${partial_paid_amount}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected    ${es_bill_resp}    200
    Verify Response Json Data As Expected    ${es_bill_resp}    payment_status             0
    Verify Response Json Data As Expected    ${es_bill_resp}    paid_amount                ${partial_paid_amount}
    Verify Response Json Data As Expected    ${es_bill_resp}    unissued_invoice_amount    ${partial_paid_amount}

es-bill-writeoff-details - add - pay the rolling bill that unissued_invoice_amount = previous.unissued_invoice_amount + paid_amount
    [Tags]    CID:15
    [Setup]    Setup Bill With Specific Status    4

    Pay Amount To Bill    ${EsBill.bill_id}    ${partial_paid_amount}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${EsBill.bill_id}
    Set Test Variable     ${EsBill_next}     ${EsBills(accumulated_es_bill_id="${EsBill.bill_id}", previous_balance=${bill_balance}, previous_paid_amount=${partial_paid_amount}, bill_period="2019-05", amount=${bill_balance}, balance=${599}, unissued_invoice_amount=${partial_paid_amount})}
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill_next.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    Update Bill Status    ${EsBill_next.bill_id}    4
    Pay Amount To Bill    ${EsBill_next.bill_id}    ${599}
    Es Bills Transitions Update    5    ${EsBill_next.bill_id}
    ${es_bill_next_resp} =    Es Bills Get    es_bill_ids=${EsBill_next.bill_id}
    Verify Status Code As Expected    ${es_bill_next_resp}    200
    Verify Response Json Data As Expected    ${es_bill_next_resp}    payment_status             1
    Verify Response Json Data As Expected    ${es_bill_next_resp}    paid_amount                599.0
    Verify Response Json Data As Expected    ${es_bill_next_resp}    unissued_invoice_amount    998.0

es-bill-writeoff-details - add - refund overcharge should be passed
    [Tags]    CID:20    refund
    [Setup]    Setup Bill With Specific Status    4
    Overpay To Bill    ${EsBill.bill_id}    ${overpaid_amount}
    Refund Overcharge To User     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_overcharge}
    ...     refund_balance=${refund_overcharge}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    ${bill_get} =       Es Bills Get                 es_bill_ids=${EsBill.bill_id}
    ${balance_get} =    Es Contracts Balances Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected           ${bill_get}       200
    Verify Response Json Data As Expected    ${bill_get}       bill_status                5
    Verify Response Json Data As Expected    ${bill_get}       paid_amount                ${overpaid_amount - ${overcharge_amount}}
    Verify Response Json Data As Expected    ${bill_get}       payment_status             1
    Verify Response Json Data As Expected    ${bill_get}       unissued_invoice_amount    ${overpaid_amount - ${overcharge_amount}}
    Verify Response Json Data As Expected    ${balance_get}    balance                    0.0
    Verify Response Json Data As Expected    ${balance_get}    credit                     0.0

es-bill-writeoff-details - add - refund partial overcharge should be passed
    [Tags]    CID:22    refund
    [Setup]    Setup Bill With Specific Status    4
    Overpay To Bill    ${EsBill.bill_id}    ${overpaid_amount}
    Refund Overcharge To User     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_partial_overcharge}
    ...     refund_balance=${refund_partial_overcharge}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    ${bill_get} =       Es Bills Get                 es_bill_ids=${EsBill.bill_id}
    ${balance_get} =    Es Contracts Balances Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected           ${bill_get}       200
    Verify Response Json Data As Expected    ${bill_get}       bill_status                5
    Verify Response Json Data As Expected    ${bill_get}       paid_amount                ${overpaid_amount + ${refund_partial_overcharge}}
    Verify Response Json Data As Expected    ${bill_get}       payment_status             1
    Verify Response Json Data As Expected    ${bill_get}       unissued_invoice_amount    ${overpaid_amount + ${refund_partial_overcharge}}
    Verify Response Json Data As Expected    ${balance_get}    balance                    50.0
    Verify Response Json Data As Expected    ${balance_get}    credit                     0.0

es-bill-writeoff-details - add - refund overpaid amount should be passed
    [Tags]    CID:19   bug_1472    refund
    [Setup]    Setup Bill With Specific Status    4
    Overpay To Bill    ${EsBill.bill_id}    ${overpaid_amount}
    Refund Overcharge To User     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_overpaid_amount}
    ...     refund_balance=${refund_overcharge}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    ${bill_get} =       Es Bills Get                 es_bill_ids=${EsBill.bill_id}
    ${balance_get} =    Es Contracts Balances Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected    ${bill_get}    200
    Verify Response Json Data As Expected    ${bill_get}       bill_status                4
    Verify Response Json Data As Expected    ${bill_get}       paid_amount                0.0
    Verify Response Json Data As Expected    ${bill_get}       payment_status             0
    Verify Response Json Data As Expected    ${bill_get}       unissued_invoice_amount    0.0
    Verify Response Json Data As Expected    ${balance_get}    balance                    0.0
    Verify Response Json Data As Expected    ${balance_get}    credit                     0.0

es-bill-writeoff-details - add - refund full paid amount should be passed
    [Tags]    CID:5437    refund
    [Setup]    Setup Bill With Specific Status    4
    Pay Amount To Bill            ${EsBill.bill_id}    ${full_paid_amount}
    Refund Paid Amount To User    ${EsBill.bill_id}    ${refund_full_paid_amount}
    ${bill_get} =     Es Bills Get    es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected    ${bill_get}    200
    Verify Response Json Data As Expected    ${bill_get}     bill_status                4
    Verify Response Json Data As Expected    ${bill_get}     paid_amount                0.0
    Verify Response Json Data As Expected    ${bill_get}     payment_status             0
    Verify Response Json Data As Expected    ${bill_get}     unissued_invoice_amount    0.0

es-bill-writeoff-details - add - refund partial paid amount should be passed
    [Tags]    CID:18    bug_1471    refund
    [Setup]    Setup Bill With Specific Status    4
    Pay Amount To Bill            ${EsBill.bill_id}    ${partial_paid_amount}
    Refund Paid Amount To User    ${EsBill.bill_id}    ${refund partial paid}
    ${bill_get} =     Es Bills Get    es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected    ${bill_get}    200
    Verify Response Json Data As Expected    ${bill_get}     bill_status                4
    Verify Response Json Data As Expected    ${bill_get}     paid_amount                0.0
    Verify Response Json Data As Expected    ${bill_get}     payment_status             0
    Verify Response Json Data As Expected    ${bill_get}     unissued_invoice_amount    0.0

es-bill-writeoff-details - add - overpay after refund should be passed
    [Tags]    CID:21    refund
    [Setup]    Setup Bill With Specific Status    4
    Overpay To Bill    ${EsBill.bill_id}    ${overpaid_amount}
    Refund Overcharge To User     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_overcharge}
    ...     refund_balance=${refund_overcharge}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    Overpay To Bill    ${EsBill.bill_id}    ${full_paid_amount}    ${full_paid_amount}
    ${bill_get} =       Es Bills Get                 es_bill_ids=${EsBill.bill_id}
    ${balance_get} =    Es Contracts Balances Get    ${EsContract.es_contract_id}
    Verify Status Code As Expected           ${bill_get}       200
    Verify Response Json Data As Expected    ${bill_get}       bill_status                5
    Verify Response Json Data As Expected    ${bill_get}       paid_amount                ${overpaid_amount - ${overcharge_amount} + ${full_paid_amount}}
    Verify Response Json Data As Expected    ${bill_get}       payment_status             1
    Verify Response Json Data As Expected    ${bill_get}       unissued_invoice_amount    ${overpaid_amount - ${overcharge_amount} + ${full_paid_amount}}
    Verify Response Json Data As Expected    ${balance_get}    balance                    499.0
    Verify Response Json Data As Expected    ${balance_get}    credit                     0.0

es-bill-writeoff-details - add - refund amount and refund_balance > current_balance should be failed
    [Tags]    FET    CID:5442    refund
    [Setup]    Setup Overpaid Bill    ${overpaid_amount}
    ${resp} =  Refund Overcharge To User
    ...     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_overcharge + ${refund_overcharge}}
    ...     refund_balance=${refund_overcharge + ${refund_overcharge}}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    604040002    the current_balance is not enough for the refund deduction

es-bill-writeoff-details - add - refund amount > overcharge should be failed
    [Tags]    FET    CID:23    refund
    [Setup]    Setup Overpaid Bill    ${overpaid_amount}
    ${resp} =  Refund Overcharge To User
    ...     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_overcharge + ${refund_overcharge}}
    ...     refund_balance=${refund_overcharge}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    402010006    contract_balance_transaction.amount must be same as refund amount.

es-bill-writeoff-details - add - refund amount > paid amount should be failed
    [Tags]    FET    CID:5443    refund
    [Setup]    Setup Overpaid Bill    ${overpaid_amount}
    ${resp} =  Refund Overcharge To User
    ...     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_overpaid_amount - 100}
    ...     refund_balance=${refund_overcharge}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    402010006    contract_balance_transaction.amount must be same as refund amount.

es-bill-writeoff-details - add - refund with invalid transaction_type should be failed
    [Tags]    FET    CID:24    refund
    [Setup]    Setup Bill With Specific Status    4
    [Template]    Verify Refund With Invalid Transaction Type
    402010006    contract_balance_transaction.amount cannot be smaller than 0    transaction_type=1
    402010006    transaction_type must be in 1 5                                 transaction_type=2
    402010006    transaction_type must be in 1 5                                 transaction_type=3
    402010006    transaction_type must be in 1 5                                 transaction_type=4
    402010006    transaction_type must be in 1 5                                 transaction_type=6
    402010006    transaction_type must be in 1 5                                 transaction_type=7
    402010006    transaction_type must be in 1 5                                 transaction_type=8
    402010006    transaction_type must be in 1 5                                 transaction_type=9

es-bill-writeoff-details - add - refund with positive balance amount should be failed
    [Tags]    FET    CID:25    refund
    [Setup]    Setup Bill With Specific Status    4
    ${resp} =  Refund Overcharge To User
    ...     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_overcharge}
    ...     refund_balance=${overcharge_amount}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    402010006    contract_balance_transaction.amount must be smaller than 0
es-bill-writeoff-details - add - es contract balance transaction should have record after refund
    [Tags]    CID:5444    refund
    [Setup]    Setup Bill With Specific Status    4
    Overpay To Bill    ${EsBill.bill_id}    ${overpaid_amount}
    Refund Overcharge To User     es_bill_id=${EsBill.bill_id}
    ...     refund_amount=${refund_overcharge}
    ...     refund_balance=${refund_overcharge}
    ...     es_contract_id=${EsContract.es_contract_id}
    ...     scooter_id=${Scooter.scooter_id}
    ${balance_get} =            Es Contracts Balances Get                 ${EsContract.es_contract_id}
    ${balance_transaction} =    Es Contracts Balances Transactions Get    ${EsContract.es_contract_id}    order=1
    Verify Status Code As Expected           ${balance_get}            200
    Verify Status Code As Expected           ${balance_transaction}    200
    Verify Response Json Data As Expected    ${balance_get}            balance             0.0
    Verify Response Json Data As Expected    ${balance_get}            credit              0.0
    Verify Response Json Data As Expected    ${balance_transaction}    amount              -100.0    1
    Verify Response Json Data As Expected    ${balance_transaction}    transaction_type    5         1

*** Keywords ***
# --------   Suite Setup   --------
Test Setup
    Setup Test Object Variable
    Deliver Scooter To User

Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${es_plan_id} =      Get Es Plan Id Via Es Plan Name    綁定 3 年 $899 方案
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}
    Set Test Variable    ${Order}         ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}       ${Scooters('${GSS_company_code}', '${GSS_model_code}')}
    Set Test Variable    ${User}          ${Users()}

# --------   Test Setup    --------
Setup Bill With Specific Status
    [Documentation]    bill.balance = 499
    [Arguments]    ${bill_status}
    Test Setup
	${timestamp} =           Evaluate    int(time.time())        time
    ${timestamp_millis} =    Evaluate    int(time.time()*1000)   time
	Set Test Variable    ${timestamp}
    Set Test Variable    ${transaction_id}      SWQA_${timestamp_millis}
    Set Test Variable    ${invoice_no}          ${timestamp_millis}
    Set Test Variable    ${invoice_time}        ${timestamp}
    Set Test Variable    ${EsBill}              ${EsBills(bill_period="2019-01")}
    ${resp} =    Create Es Bill
    ...    ${EsBill}       ${EsContract}
    ...    ${User}         ${Scooter.scooter_id}
    Set Test Variable      ${EsBill.bill_id}    ${resp.json()['data'][0]['es_bill_id']}
    ${decode_bill_id} =    Decode Encodeid      ${EsBill.bill_id}
    Set Test Variable      ${decode_bill_id}
    Update Bill Status     ${EsBill.bill_id}    ${bill_status}

Setup Invoiced Bill
    [Documentation]    `paid_amount` is this bill writeoff detail's amount
    [Arguments]    ${paid_amount}
    Test Setup
    Setup Bill With Specific Status    4
    Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1          amount=${paid_amount}           credit_card_no=87654321
    Es Bill Writeoffs Update         es_bill_id=${EsBill.bill_id}    es_bill_writeoff_id=${None}         invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=1
    ${resp} =    Es Bills Get        es_bill_ids=${EsBill.bill_id}
    Verify Response Contains Expected    ${resp.json()["data"][0]["bill_status"]}    ${6}

Setup Overpaid Bill
    [Arguments]    ${overpaid_amount}
    Setup Bill With Specific Status    4
    Overpay To Bill    ${EsBill.bill_id}    ${overpaid_amount}

# -------- Gogoro Keywords --------
Deliver Scooter To User
    ${User.user_id} =          Create User        ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR        ${Order.order_no}    I    ${User.user_id}      30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}     ${User.user_id}      1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}
    Scooters Infos Update
    ...    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}
    ...    ${Order.owner_id}    ${User.gogoro_guid}
    ...    state=1
    ...    turn_light=1    brake_light=1
    ...    tpms=0          sport_mode=0
    ...    warranty_start=${Scooter.warranty_start}
    ...    warranty_end=${Scooter.warranty_end}

Update Bill Status
    [Arguments]    ${es_bill_ids}   ${bill_status}
    FOR    ${index}    IN RANGE    2    ${bill_status}+1
        Es Bills Transitions Update    bill_status=${index}    es_bill_ids=${es_bill_ids}
    END

# -------- Verify Keywords --------
