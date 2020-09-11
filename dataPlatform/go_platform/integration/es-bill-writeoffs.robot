*** Settings ***
Documentation    Test suite of es-bills-writeoffs
Resource    ../init.robot

Force Tags    Billing    Es-Bills-Writeoffs
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${brand_company_code}     B22318608
${model_code}             BUS
${invoice_donate_to}      SWQA1234
${scooters_count}         1
${bill_balance}	          ${499.0}
${overpay_paid_amount}    ${599.0}
${partial_paid_amount}    ${399.0}

*** Test Cases ***
es-bill-writeoffs - update - valid - update invoice with donate_to_no
    [Setup]    Test Setup
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}    invoice_donate_to=${invoice_donate_to}
    ${get_resp} =    Es Bill Writeoffs Get    ${None}    ${bill_id}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
	Verify Status Code As Expected       ${update_resp}    200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}            ${bill_id}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["status"]}                ${1}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["invoice_donate_to"]}     ${invoice_donate_to}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}    ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}       ${6}

es-bill-writeoffs - update - valid - cancel invoice and es_bill payment
    [Setup]    Test Setup
    ${update_resp_with_invoice_donate_to} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}    invoice_donate_to=${invoice_donate_to}
    ${update_resp_with_cancel} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${0}    invoice_donate_to=${None}
    ${get_resp} =    Es Bill Writeoffs Get    ${None}    ${bill_id}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
    ${es_bill_writeoff_details_resp} =    Es Bill Writeoff Details Get    ${None}    ${bill_id}
	Verify Status Code As Expected       ${update_resp_with_invoice_donate_to}    200
	Verify Status Code As Expected       ${update_resp_with_cancel}    200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}                     ${bill_id}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["status"]}                         ${0}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["invoice_donate_to"]}              ${invoice_donate_to}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}                ${0.0}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}                ${4}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}
    Verify Response Contains Expected    ${es_bill_writeoff_details_resp.json()["data"][1]["amount"]}    ${-${bill_balance}}

# SSD-526 Automation
es-bill-writeoffs - update - update writeoff to the draft es_bill should be failed
    [Tags]    FET
    [Setup]    Test Setup For Create Es Bill
    ${resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${604040002}    ERROR: es_bill_writeoff does not exist

es-bill-writeoffs - update - update writeoff to the unpaid bill should be failed
    [Tags]    FET
    [Setup]    Test Setup For Create Es Bill
    [Template]    Verify Es Bill Writeoff Fail Update To 6
    ${604040002}    ERROR: es_bill_writeoff does not exist    ${2}    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${604040002}    ERROR: es_bill_writeoff does not exist    ${3}    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${604040002}    ERROR: es_bill_writeoff does not exist    ${4}    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}

es-bill-writeoffs - update - update writeoff to the paid bill should be success
    [Tags]    FET
    [Setup]    Test Setup For Create Es Bill
    [Template]    Verify Es Bill Writeoff Fail Update To 6
    ${604040002}    ERROR: es_bill_writeoff does not exist    ${2}    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${604040002}    ERROR: es_bill_writeoff does not exist    ${3}    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${604040002}    ERROR: es_bill_writeoff does not exist    ${4}    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}

es-bill-writeoffs - update - update writeoff to the paid issued invoice bill should be failed
    [Tags]    FET
    [Setup]    Test Setup
    ${update_resp_to_writeoffs_first} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${604040003}    ERROR: An existing writeoff with valid invoice number is exist

es-bill-writeoffs - update - update writeoff to discard es_bill should be failed
    [Tags]    FET
    [Setup]    Test Setup For Create Es Bill
    Es Bills Transitions Update    99    ${bill_id}
	${resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${604040002}    ERROR: es_bill_writeoff does not exist

es-bill-writeoffs - update - update writeoff to complete paid es_bill and bill_status = 4 should update bill_status to 6
    [Setup]    Test Setup
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${get_resp} =    Es Bill Writeoffs Get    ${None}    ${bill_id}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
	Verify Status Code As Expected       ${update_resp}    200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}            ${bill_id}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["status"]}                ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}    ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}       ${bill_balance}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}       ${6}

es-bill-writeoffs - update - update writeoff to partial paid es_bill and bill_status = 2 should update bill_status to 6
    [Setup]    Test Setup For Create Es Bill
    Set Test Variable    ${transaction_id}		TEST_${timestamp}
    Update Bill Status    ${bill_id}    2
    Pay Amount To Bill    ${bill_id}    ${partial_paid_amount}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${get_resp} =    Es Bill Writeoffs Get    ${None}    ${bill_id}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
	Verify Status Code As Expected       ${update_resp}    200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}            ${bill_id}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["status"]}                ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}    ${0}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}       ${partial_paid_amount}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}       ${6}

es-bill-writeoffs - update - update writeoff to partial paid es_bill and bill_status = 3 should update bill_status to 6
    [Setup]    Test Setup For Create Es Bill
    Set Test Variable    ${transaction_id}		TEST_${timestamp}
    Update Bill Status    ${bill_id}    3
    Pay Amount To Bill    ${bill_id}    ${partial_paid_amount}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${get_resp} =    Es Bill Writeoffs Get    ${None}    ${bill_id}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
	Verify Status Code As Expected       ${update_resp}    200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}            ${bill_id}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["status"]}                ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}    ${0}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}       ${partial_paid_amount}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}       ${6}

es-bill-writeoffs - update - update writeoff to partial paid es_bill and bill_status = 4 should update bill_status to 6
    [Setup]    Test Setup For Create Partial Paid Es Bill
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${get_resp} =    Es Bill Writeoffs Get    ${None}    ${bill_id}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
	Verify Status Code As Expected       ${update_resp}    200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}            ${bill_id}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["status"]}                ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}    ${0}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}       ${partial_paid_amount}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}       ${6}

es-bill-writeoffs - update - register invoice to paid completed bill that unissued_invoice_amount should be equals to 0
    [Tags]    CID:3
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${bill_balance}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}

    Verify Status Code As Expected    ${es_bill_resp}    200
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}             ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}                ${6}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}                ${bill_balance}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}

es-bill-writeoffs - update - register invoice to partial paid bill that unissued_invoice_amount = 0
    [Tags]    CID:7
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${partial_paid_amount}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
    Verify Status Code As Expected    ${es_bill_resp}    200
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}             ${0}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}                ${6}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}                ${partial_paid_amount}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}

es-bill-writeoffs - update - register invoice to overpaid bill that unissued_invoice_amount = unissued_invoice_amount - taxable_amount
    [Tags]    CID:5    bug_1254
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Overpay To Bill    ${bill_id}    ${overpay_paid_amount}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
    ${balance} =    Convert To Number    ${EsBill.balance}
    Verify Status Code As Expected    ${es_bill_resp}    200
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}             ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["bill_status"]}                ${6}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}                ${overpay_paid_amount}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}    ${overpay_paid_amount-${balance}}

es-bill-writeoffs - update - register invoice separately to first unissued invoice bill (paid completed)
    [Tags]    CID:12    bug_1254
    [Setup]    Test Setup
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill_next.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}

    Update Bill Status    ${EsBill_next.bill_id}    4
    Pay Amount To Bill    ${EsBill_next.bill_id}    ${bill_balance}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
    ${es_bill_next_resp} =    Es Bills Get    es_bill_ids=${EsBill_next.bill_id}

    Verify Status Code As Expected    ${es_bill_resp}    200
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}                  ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}                     ${bill_balance}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}         ${499.0}
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["unissued_invoice_amount"]}    ${499.0}

es-bill-writeoffs - update - register invoice separately whole unissued invoice bill (paid completed)
    [Tags]    CID:13    bug_1254
    [Setup]    Test Setup
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill_next.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}

    Update Bill Status    ${EsBill_next.bill_id}    4
    Pay Amount To Bill    ${EsBill_next.bill_id}    ${bill_balance}
    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    Es Bill Writeoffs Update    es_bill_id=${EsBill_next.bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${pre_bill_get} =    Es Bills Get    es_bill_ids=${bill_id}
    ${es_bill_next_resp} =    Es Bills Get    es_bill_ids=${EsBill_next.bill_id}

    Verify Status Code As Expected    ${es_bill_next_resp}    200
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["payment_status"]}             ${1}
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["paid_amount"]}                ${bill_balance}
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}
    Verify Response Contains Expected    ${pre_bill_get.json()["data"][0]["unissued_invoice_amount"]}         ${499.0}

es-bill-writeoffs - update - register latest invoice to merge invoice (partial paid)
    [Tags]    CID:14    bug_1296
    [Setup]    Test Setup For Create Partial Paid Es Bill
    Set Test Variable     ${EsBill_next}     ${EsBills(accumulated_es_bill_id="${bill_id}", previous_balance=${bill_balance}, previous_paid_amount=${partial_paid_amount}, bill_period="2019-05", amount=${bill_balance}, balance=${overpay_paid_amount}, unissued_invoice_amount=${partial_paid_amount}, taxable_amount=${bill_balance + ${bill_balance}})}
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill_next.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}

    Update Bill Status    ${EsBill_next.bill_id}    4
    Pay Amount To Bill    ${EsBill_next.bill_id}    ${overpay_paid_amount}
    Es Bill Writeoffs Update    es_bill_id=${EsBill_next.bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_next_resp} =    Es Bills Get    es_bill_ids=${EsBill_next.bill_id}

    Verify Status Code As Expected    ${es_bill_next_resp}    200
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["payment_status"]}             ${1}
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["paid_amount"]}                ${overpay_paid_amount}
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}

es-bill-writeoffs - update - register invoice to partial paid bill that writeoff_amount should be equals to paid_amount
    [Tags]    CID:540
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${partial_paid_amount}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
    ${es_bill_writeoff_resp} =    Es Bill Writeoffs Get    es_bill_id=${bill_id}
    Verify Status Code As Expected    ${update_resp}    200
    Verify Status Code As Expected    ${es_bill_writeoff_resp}    200
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}    ${partial_paid_amount}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}
    Verify Response Contains Expected    ${es_bill_writeoff_resp.json()["data"][0]["amount"]}    ${partial_paid_amount}

es-bill-writeoffs - update - register invoice to full paid bill that writeoff_amount should be equals to taxable_amount
    [Tags]    CID:538
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${bill_balance}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
    ${es_bill_writeoff_resp} =    Es Bill Writeoffs Get    es_bill_id=${bill_id}
    Verify Status Code As Expected    ${update_resp}    200
    Verify Status Code As Expected    ${es_bill_writeoff_resp}    200
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}    ${bill_balance}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}
    Verify Response Contains Expected    ${es_bill_writeoff_resp.json()["data"][0]["amount"]}    ${EsBill.taxable_amount}

es-bill-writeoffs - update - register invoice to overpaid bill that writeoff_amount should be equals to taxable_amount
    [Tags]    CID:539
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Overpay To Bill    ${bill_id}    ${overpay_paid_amount}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
    ${es_bill_writeoff_resp} =    Es Bill Writeoffs Get    es_bill_id=${bill_id}
    Verify Status Code As Expected    ${update_resp}    200
    Verify Status Code As Expected    ${es_bill_writeoff_resp}    200
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}    ${overpay_paid_amount}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}    ${overpay_paid_amount - ${EsBill.taxable_amount}}
    Verify Response Contains Expected    ${es_bill_writeoff_resp.json()["data"][0]["amount"]}    ${EsBill.taxable_amount}

es-bill-writeoffs - update - register invoice separately to first unissued invoice bill (full paid)
    [Tags]    CID:541
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${bill_balance}

    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill_next.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}

    Es Bills Transitions Update    2    ${EsBill_next.bill_id}
    Es Bills Transitions Update    3    ${EsBill_next.bill_id}
    Es Bills Transitions Update    4    ${EsBill_next.bill_id}
    Pay Amount To Bill    ${EsBill_next.bill_id}    ${bill_balance}
    ${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_resp} =    Es Bills Get    es_bill_ids=${bill_id}
    ${es_bill_writeoff_resp} =    Es Bill Writeoffs Get    es_bill_id=${bill_id}

    Verify Status Code As Expected    ${es_bill_resp}    200
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["payment_status"]}    ${1}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["paid_amount"]}    ${bill_balance}
    Verify Response Contains Expected    ${es_bill_resp.json()["data"][0]["unissued_invoice_amount"]}    ${499.0}
    Verify Response Contains Expected    ${es_bill_writeoff_resp.json()["data"][0]["amount"]}    ${EsBill.taxable_amount}

es-bill-writeoffs - update - register invoice separately whole unissued invoice bill (full paid)
    [Tags]    CID:542
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${bill_balance}

    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill_next.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}

    Es Bills Transitions Update    2    ${EsBill_next.bill_id}
    Es Bills Transitions Update    3    ${EsBill_next.bill_id}
    Es Bills Transitions Update    4    ${EsBill_next.bill_id}
    Pay Amount To Bill    ${EsBill_next.bill_id}    ${bill_balance}
    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    Es Bill Writeoffs Update    es_bill_id=${EsBill_next.bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_next_resp} =    Es Bills Get    es_bill_ids=${EsBill_next.bill_id}
    ${es_bill_writeoff_resp} =    Es Bill Writeoffs Get    es_bill_id=${EsBill_next.bill_id}

    Verify Status Code As Expected    ${es_bill_next_resp}    200
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["payment_status"]}    ${1}
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["paid_amount"]}    ${bill_balance}
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}
    Verify Response Contains Expected    ${es_bill_writeoff_resp.json()["data"][0]["amount"]}    ${EsBill.taxable_amount}

es-bill-writeoffs - update - register the latest invoice to merge invoice (partial paid)
    [Tags]    CID:543
    [Setup]    Setup Test Object Variable
    Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${partial_paid_amount}

    Set Test Variable     ${EsBill_next}     ${EsBills(accumulated_es_bill_id="${bill_id}", previous_balance=${bill_balance}, previous_paid_amount=${partial_paid_amount}, bill_period="2019-05", amount=${bill_balance}, balance=${overpay_paid_amount}, unissued_invoice_amount=${partial_paid_amount}, taxable_amount=${bill_balance}+${bill_balance})}
    ${resp} =    Create Es Bill    ${EsBill_next}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill_next.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}

    Es Bills Transitions Update    2    ${EsBill_next.bill_id}
    Es Bills Transitions Update    3    ${EsBill_next.bill_id}
    Es Bills Transitions Update    4    ${EsBill_next.bill_id}
    Pay Amount To Bill    ${EsBill_next.bill_id}    ${overpay_paid_amount}
    Es Bill Writeoffs Update    es_bill_id=${EsBill_next.bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${1}
    ${es_bill_next_resp} =    Es Bills Get    es_bill_ids=${EsBill_next.bill_id}
    ${es_bill_writeoff_resp} =    Es Bill Writeoffs Get    es_bill_id=${EsBill_next.bill_id}

    Verify Status Code As Expected    ${es_bill_next_resp}    200
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["payment_status"]}    ${1}
    Verify Response Contains Expected    ${es_bill_next_resp.json()["data"][0]["unissued_invoice_amount"]}    ${0.0}
    Verify Response Contains Expected    ${es_bill_writeoff_resp.json()["data"][0]["amount"]}    ${998.0}

# es-bill-writeoffs - update register invoice to non required payment bill that taxable_amount should equals to taxale_amount (rolling overpaid bill)
#     [Tags]    CID:545

*** Keywords ***
# -------- Setup  Keywords --------
Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${es_plan_id} =    Get Es Plan Id Via Es Plan Name    綁定 3 年 $899 方案
    ${timestamp} =    Evaluate    int(time.time())   time
	${uniqueInvoiceNo} =    Set Variable    int(${timestamp}+1)
    ${timestamp} =    Evaluate    int(time.time())   time
    Set Test Variable    ${invoice_no}     Inv${uniqueInvoiceNo}
    Set Test Variable    ${invoice_time}    ${timestamp}
    Set Test Variable    ${timestamp}
    Set Test Variable    ${transaction_id}		TEST_${timestamp}
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}
    Set Test Variable    ${Order}         ${Orders('P0${order_number}')}
    Set Test Variable    ${User}          ${Users()}
    Set Test Variable    ${Scooter}    ${Scooters('${brand_company_code}', '${model_code}')}
    Set Test Variable    ${EsBill}        ${EsBills(bill_period="2019-01", taxable_amount=${bill_balance})}
    ${User.user_id} =        Create User    ${User}
    ${contract_user_id} =    Create Contract User  ${User}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
	${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    1    turn_light=1    brake_light=1    tpms=0    sport_mode=0    warranty_start=${Scooter.warranty_start}    warranty_end=${Scooter.warranty_end}
    Set Test Variable     ${EsBill_next}     ${EsBills(previous_balance=${bill_balance}, previous_paid_amount=${bill_balance}, bill_period="2019-05", amount=${bill_balance}, unissued_invoice_amount=${bill_balance}, taxable_amount=${bill_balance})}

Test Setup
    Setup Test Object Variable
    Create Paid Complete Es Bill

Test Setup For Create Es Bill
    Setup Test Object Variable
	${resp} =    Create Es Bill     ${EsBill}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
	Set Test Variable    ${bill_id}

Test Setup For Create Partial Paid Es Bill
    Setup Test Object Variable
    Create Partial Paid Es Bill

# -------- Gogoro Keywords --------
Create Issed Es Bill
	${resp} =    Create Es Bill     ${EsBill}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
	Set Test Variable    ${bill_id}
    Update Bill Status    ${bill_id}    4

Create Paid Complete Es Bill
	Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${bill_balance}

Create Partial Paid Es Bill
    Create Issed Es Bill
    Pay Amount To Bill    ${bill_id}    ${partial_paid_amount}

Update Bill Status
    [Arguments]    ${es_bill_ids}   ${bill_status}
    FOR    ${index}    IN RANGE    2    ${bill_status}+1
        Es Bills Transitions Update    bill_status=${index}    es_bill_ids=${es_bill_ids}
    END

# -------- Verify Keywords --------
Verify Es Bill Writeoff Fail Update To 6
	[Arguments]    ${additional_code}    ${err_msg}    ${bill_status}    ${es_bill_id}    ${es_bill_writeoff_id}    ${invoice_no}    ${invoice_time}    ${writeoff_status}
    Es Bills Transitions Update    ${bill_status}    ${es_bill_id}
	${resp} =    Es Bill Writeoffs Update    ${es_bill_id}    ${es_bill_writeoff_id}    ${invoice_no}    ${invoice_time}    ${writeoff_status}
    Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Es Bill Writeoff Success Update To 6
	[Arguments]    ${bill_id}    ${es_bill_writeoff_id}    ${invoice_no}    ${invoice_time}    ${writeoff_status}    ${invoice_donate_to}
	${update_resp} =    Es Bill Writeoffs Update    es_bill_id=${bill_id}    es_bill_writeoff_id=${es_bill_writeoff_id}    invoice_no=${invoice_no}    invoice_time=${invoice_time}    writeoff_status=${writeoff_status}    invoice_donate_to=${invoice_donate_to}
    ${get_resp} =    Es Bill Writeoffs Get    ${es_bill_writeoff_id}    ${bill_id}
	Verify Status Code As Expected       ${update_resp}    200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}           ${bill_id}
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["status"]}               ${writeoff_status}
