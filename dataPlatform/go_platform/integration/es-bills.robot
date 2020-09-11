*** Settings ***
Documentation    Test suite of es-bills
Resource    ../init.robot

Force Tags    Billing    Es-Bills
Test Setup    Setup Test Object Variable
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${brand_company_code}    B22318608
${model_code}    BUS
${bill_balance}           ${499.0}
${full_paid_amount}	      ${bill_balance}
${overpay_paid_amount}    ${bill_balance + 100}
${partial_paid_amount}    ${bill_balance - 100}

*** Test Cases ***
es-bills - get - get es bill scooter data
    [Setup]    Create Es Bill With Multiple Scooter
    ${resp} =    Es Bills Get    es_bill_ids=${EsBill.bill_id}    request_data_type=${1}
    Verify Status Code As Expected       ${resp}                                               200
    Verify Response Contains Expected    ${resp.json()['data'][0]['es_bill_id']}               ${EsBill.bill_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['es_bill_scooter_count']}    ${Scooters_count}
    Verify Schema    es-bill.json    esBillWithScooter    ${resp.json()}

es-bills - add - rolling bill with unissue_invoice_amount and previous unissue_invoice_amount = 0 should be failed
    [Tags]    FET    CID:8
    [Setup]    Create Es Bill Setup    ${0}
    Pay Amount To Bill    ${EsBill.bill_id}    ${full_paid_amount}
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}

    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Partial Error Message    ${resp}    604040002    ERROR: unissued_invoice_amount must the pass to the new bill

es-bills - add - rolling bill with unissue_invoice_amount > previous unissue_invoice_amount should be failed
    [Tags]    FET    CID:9
    [Setup]    Create Es Bill Setup    ${599}
    Pay Amount To Bill    ${EsBill.bill_id}    ${full_paid_amount}
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}

    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Partial Error Message    ${resp}    604040002    ERROR: unissued_invoice_amount must the pass to the new bill

es-bills - add - rolling bill with unissue_invoice_amount = previous unissue_invoice_amount should be passed
    [Tags]    CID:10
    [Setup]    Create Es Bill Setup    ${full_paid_amount}
    Pay Amount To Bill    ${EsBill.bill_id}    ${full_paid_amount}
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${bill_get} =    Es Bills Get    es_bill_ids=${resp.json()['data'][0]['es_bill_id']}
    Verify Status Code As Expected       ${resp}    200
    Verify Status Code As Expected       ${bill_get}    200
    Verify Response Contains Expected    ${bill_get.json()["data"][0]["unissued_invoice_amount"]}    ${full_paid_amount}

es-bills - add - rolling bill with unissue_invoice_amount < previous unissue_invoice_amount should be failed
    [Tags]    FET    CID:11
    [Setup]    Create Es Bill Setup    ${399}
    Pay Amount To Bill    ${EsBill.bill_id}    ${full_paid_amount}
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}

    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Partial Error Message    ${resp}    604040002    ERROR: unissued_invoice_amount must the pass to the new bill

es-bills - add - recalculate rolling bill that unissued_invoice_amount should be the same
    [Tags]    CID:17
    [Setup]    Create Es Bill Setup    ${full_paid_amount}
    Pay Amount To Bill    ${EsBill.bill_id}    ${full_paid_amount}
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill_next.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}

    Set Local Variable     ${EsBill_recalculate}     ${EsBills(discarded_es_bill_id="${EsBill_next.bill_id}", previous_balance=${full_paid_amount}, previous_paid_amount=${full_paid_amount}, bill_period="2019-05", amount=${full_paid_amount}, unissued_invoice_amount=${full_paid_amount})}
    ${resp} =    Create Es Bill    ${EsBill_recalculate}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${es_bill_recalculate_get} =    Es Bills Get    es_bill_ids=${resp.json()['data'][0]['es_bill_id']}

    Verify Status Code As Expected       ${resp}                        200
    Verify Status Code As Expected       ${es_bill_recalculate_get}    200
    Verify Response Contains Expected    ${es_bill_recalculate_get.json()["data"][0]["unissued_invoice_amount"]}    ${full_paid_amount}

es-bills - add - recalculate es-bill with discard_bill_id = another user bill_id should be failed
    [Tags]    FET    CID:5383    recalculate
    [Setup]    Setup Bill With Specific Status    4
    Setup Bill With Specific Status    4    EsBill_another
    Setup Recalculate Bill             ${EsBill.bill_id}
    ${resp} =    Create Es Bill    
    ...   ${EsBill_recalculate}    ${EsContract}    
    ...   ${User}                  ${Scooter.scooter_id}
    ${resp1} =    Es Bills Get    es_bill_ids=${EsBill.bill_id}    request_data_type=${1}
    Verify Response Contains Expected    ${resp1.json()['data'][0]['bill_status']}    4
    Verify Status Code As Expected             ${resp}    200
    Verify GoPlatform Partial Error Message    ${resp}    502010006    The store_barcode2 of the discarded_es_bill_id is not the same as request input.

*** Keywords ***
# --------  Test Setup     --------
Create Es Bill Scooter
    [Arguments]    ${bill_id}    ${date_from}    ${date_to}
    FOR    ${index}    IN RANGE    1    ${scooters_count}
        Es Bill Scooters Post    ${bill_id}    ${EsContract.es_contract_id}    ${Scooter${index}.scooter_id}    ${date_from}    ${date_to}    resource_type=5
    END

Create Es Bill Setup
    [Arguments]    ${unissued_invoice_amount}
    Setup Test Object Variable
    Deliver Scooter To User
    Set Test Variable      ${EsBill}     ${EsBills(bill_period="2019-04", amount=${full_paid_amount})}
    ${resp} =    Create Es Bill    ${EsBill}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    Update Bill Status     ${EsBill.bill_id}    4
    Set Test Variable      ${EsBill_next}     ${EsBills(previous_balance=${full_paid_amount}, previous_paid_amount=${full_paid_amount}, bill_period="2019-05", amount=${full_paid_amount}, unissued_invoice_amount=${unissued_invoice_amount})}
    Set Test Variable      ${EsBill_recalculate}     ${EsBills(discarded_es_bill_id="${EsBill.bill_id}", bill_period="2019-04", amount=${bill_balance})}
Create Es Bill With Multiple Scooter
    Test Setup
    Set Test Variable    ${scooters_count}    4
    Setup Scooters
    Set Test Variable    ${EsBill}        ${EsBills(bill_period="2019-01")}
    ${resp} =    Create Es Bill    ${EsBill}    ${EsContract}    ${User}    ${Scooter0.scooter_id}
    ${EsBill.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    Create Es Bill Scooter    ${EsBill.bill_id}    ${EsBill.date_from}    ${EsBill.date_to}
    Update Bill Status    ${EsBill.bill_id}    4
    Set Test Variable     ${EsBill.bill_id}

Test Setup
    Setup Test Object Variable
    ${User.user_id} =        Create User    ${User}
    ${contract_user_id} =    Create Contract User  ${User}
    ${Order.order_id}    ${Order.owner_id} =    Set Variable    ${None}    ${contract_user_id}
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2

Setup Bill With Specific Status
    [Arguments]    ${bill_status}    ${EsBill_obj_name}=EsBill
    ${EsBill} =    Create Es Bill With Specific Status    ${bill_status}
    Set Test Variable    ${${EsBill_obj_name}}    ${EsBill}

Setup Scooters
    FOR    ${index}    IN RANGE    ${scooters_count}
        Set Test Variable    ${Scooter${index}}    ${Scooters('${brand_company_code}', '${model_code}')}
        ${scooter_id} =    Create Scooters    ${Scooter${index}}
        Set Test Variable    ${Scooter${index}.scooter_id}    ${scooter_id}
        Es Contracts Update Scooters    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    2    1    ${Scooter${index}.scooter_id}
        GDK Scooters Update Plate       ${Scooter${index}.vin}          ${Scooter${index}.plate}    ${Scooter${index}.plate_date}
    END

Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${es_plan_id} =      Get Es Plan Id Via Es Plan Name    綁定 3 年 $899 方案
    ${date_from} =       Get Current Date    increment=-15 days       result_format=epoch    exclude_millis=yes
    ${date_to} =         Get Current Date    increment=15 days        result_format=epoch    exclude_millis=yes
    Set Test Variable    ${date_from}
    Set Test Variable    ${date_to}
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}
    Set Test Variable    ${Order}         ${Orders('P0${order_number}')}
    Set Test Variable    ${User}          ${Users()}
    Set Test Variable    ${Scooter}       ${Scooters('${brand_company_code}', '${model_code}')}

Setup Recalculate Bill
    [Arguments]    ${discarded_es_bill_id}
    Set Test Variable      ${EsBill_recalculate}     ${EsBills(discarded_es_bill_id="${discarded_es_bill_id}", bill_period="2019-04", amount=${bill_balance})}

Setup Rolling Unissued Invoice Bill
    [Arguments]     ${unissued_invoice_amount}
    Set Test Variable ${EsBill_next} ${EsBills(previous_balance=${full_paid_amount}, previous_paid_amount=${full_paid_amount}, bill_period="2019-05", amount=${full_paid_amount}, unissued_invoice_amount=${unissued_invoice_amount})}

# -------- Gogoro Keywords --------
Create Es Bill With Specific Status
    [Arguments]    ${bill_status}    ${amount}=${bill_balance}
    Setup Test Object Variable
    Deliver Scooter To User
    ${EsBill} =    Set Variable    ${EsBills(bill_period="2019-04", amount=${amount})}
    ${resp} =    Create Es Bill
    ...    ${EsBill}    ${EsContract}
    ...    ${User}      ${Scooter.scooter_id}
    ${EsBill.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    Update Bill Status     ${EsBill.bill_id}    ${bill_status}
    [Return]    ${EsBill}

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

Pay Amount To Bill
    [Arguments]    ${bill_id}    ${full_paid_amount}
	${timeNow} =    Evaluate    int(time.time())   time
	Set Test Variable    ${transaction_id}		TEST_${timeNow}
	${resp} =    Create Es Bill Writeoff Detail
    ...    es_bill_id=${bill_id}    transaction_id=${transaction_id}
    ...    transaction_time=1
    ...    amount=${full_paid_amount}
    ...    credit_card_no=87654321
