*** Settings ***
Documentation    API integration of /es-bill-transitions
Resource    	../init.robot

Force Tags      Billing    Es-Bill
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${GSS_company_code}    1500
${GSS_model_code}      AZ2

*** Test Cases ***
es-bills-transition - update - update approved paid es_bill.bill_status to 3 (status = 2)
    [Setup]    Setup Bill With Specific Status    2
    ${detail_post} =      Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1    amount=${EsBill.balance}    credit_card_no=87654321
    ${status_update} =    Es Bills Transitions Update      bill_status=3                   es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected       ${detail_post}       200
    Verify Status Code As Expected       ${status_update}     200
    Verify Es Bill Status As Expected    ${EsBill.bill_id}    3

es-bills-transition - update - update approved paid es_bill.bill_status to 4 (status = 2)
    [Setup]    Setup Bill With Specific Status    3
    ${detail_post} =      Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1    amount=${EsBill.balance}    credit_card_no=87654321
    ${status_update} =    Es Bills Transitions Update      bill_status=4                   es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected       ${detail_post}       200
    Verify Status Code As Expected       ${status_update}     200
    Verify Es Bill Status As Expected    ${EsBill.bill_id}    4

es-bills-transition - update - update pdf generated paid es_bill.bill_status to 4 (status = 3)
    [Setup]    Setup Bill With Specific Status    3
    ${detail_post} =      Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1    amount=${EsBill.balance}    credit_card_no=87654321
    ${status_update} =    Es Bills Transitions Update      bill_status=4                  es_bill_ids=${EsBill.bill_id}
    Verify Status Code As Expected       ${detail_post}       200
    Verify Status Code As Expected       ${status_update}     200
    Verify Es Bill Status As Expected    ${EsBill.bill_id}    4

*** Keywords ***
# --------   Suite Setup   --------
Setup Suite Object Variable
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
    Setup Suite Object Variable
    Deliver Scooter To User
	${timestamp} =           Evaluate    int(time.time())        time
    ${timestamp_millis} =    Evaluate    int(time.time()*1000)   time
	Set Test Variable    ${timestamp}
    Set Test Variable    ${transaction_id}      swqa_tr_${timestamp_millis}
    Set Test Variable    ${invoice_no}          ${timestamp_millis}
    Set Test Variable    ${invoice_time}        ${timestamp}
    Set Test Variable    ${EsBill}              ${EsBills()}
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
    Setup Bill With Specific Status    4
    Es Bill Writeoff Details Post    es_bill_id=${EsBill.bill_id}    transaction_id=${transaction_id}    transaction_time=1          amount=${paid_amount}           credit_card_no=87654321
    Es Bill Writeoffs Update         es_bill_id=${EsBill.bill_id}    es_bill_writeoff_id=${None}         invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=1
    ${resp} =    Es Bills Get        es_bill_ids=${EsBill.bill_id}
    Verify Response Contains Expected    ${resp.json()["data"][0]["bill_status"]}    ${6}

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

# -------- Verify Keywords --------
