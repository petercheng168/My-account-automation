*** Keywords ***
# -------- Gogoro Keywords --------
Create Es Bill
    [Documentation]    Create es bills
    [Arguments]    ${EsBill}    ${EsContract}    ${User}    ${scooter_id}
    ${date_from} =         Convert To Integer    ${EsBill.date_from}
    ${last_calc_date} =    Convert To Integer    ${EsBill.last_calc_date}
    ${due_date} =          Convert To Integer    ${EsBill.due_date}
    FOR    ${index}    IN RANGE    5
        ${code} =    Generate Random String    8    [NUMBERS][UPPER]
        Set Local Variable    ${code${index}}    ${code}
    END
    ### balance = previous_balance - previous_paid_amount - adjustment_amount + amount
    ${resp} =    Es Bills Post
    ...    accumulated_es_bill_id=${EsBill.accumulated_es_bill_id}    discarded_es_bill_id=${EsBill.discarded_es_bill_id}    unissued_invoice_amount=${EsBill.unissued_invoice_amount}
    ...    user_id=${User.user_id}    bill_period=${EsBill.bill_period}
    ...    bank_barcode1=${code0}
    ...    bank_barcode2=${code1}
    ...    store_barcode1=${code2}
    ...    store_barcode2=${EsContract.es_contract_id}
    ...    store_barcode3=${code4}
    ...    bill_to_address=${User.contact_address}
    ...    bill_to_zipcode=${User.contact_zip}
    ...    bill_to_email=${User.email}
    ...    due_date=${due_date}
    ...    date_from=${EsBill.date_from}
    ...    date_to=${EsBill.date_to}
    ...    issue_date=${EsBill.issue_date}
    ...    latest_bill_calc_end_date=${last_calc_date}
    ...    amount=${EsBill.amount}
    ...    settle_days=31
    ...    bill_to_name=dataplatform_test   base_price_amount=499     over_unit_price_amount=0
    ...    other_charge_amount=0            addon_price_amount=0      promotion_price_amount=0
    ...    penalty_amount=0                 delivery_method=1         es_contract_id=${EsContract.es_contract_id}
    ...    scooter_id=${scooter_id}         resource_type=5           other_data=Test data
    ...    details_amount=499               tax_amount=0              tax_rate=0
    ...    adjustment_amount=${EsBill.adjustment_amount}    balance=${EsBill.balance}    bill_status=${EsBill.bill_status}
    ...    previous_balance=${EsBill.previous_balance}      previous_paid_amount=${EsBill.previous_paid_amount}
    ...    bill_type=1
    ...    payment_type=1
    ...    suspend_days=0
    ...    taxable_amount=${EsBill.taxable_amount}
    [Return]    ${resp}

# -------- Verify Keywords --------
Verify Es Bill Status As Expected
	[Arguments]    ${es_bill_id}    ${bill_status}
	${bill_get} =    Es Bills Get        ${es_bill_id}
	Verify Status Code As Expected       ${bill_get}       200
	Verify Response Contains Expected    ${bill_get.json()["data"][0]["es_bill_id"]}     ${EsBill.bill_id}
	Verify Response Contains Expected    ${bill_get.json()["data"][0]["bill_status"]}    ${bill_status}
