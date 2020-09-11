*** Settings ***
Documentation    API baseline of es-bill-writeoffs

Variables    ../../../env.py
Variables    ${PROJECT_ROOT}/setting.py    dev
Variables    ${GP_LIB_ROOT}/DataPlatformObject.py

Library      ${GP_API_ROOT}/LibContractUsers.py
Library      ${GP_API_ROOT}/LibEsBillWriteoffDetails.py
Library      ${GP_API_ROOT}/LibEsBillWriteoffs.py
Library      ${GP_API_ROOT}/LibEsBills.py
Library      ${GP_API_ROOT}/LibEsBillsTransitions.py
Library      ${GP_API_ROOT}/LibEsContracts.py
Library      ${GP_API_ROOT}/LibEsPlans.py
Library      ${GP_API_ROOT}/LibGDKScooters.py
Library      ${GP_API_ROOT}/LibOrders.py
Library      ${GP_API_ROOT}/LibScooters.py
Library      ${GP_API_ROOT}/LibScootersInfos.py
Library      ${GP_API_ROOT}/LibUsers.py

Resource     ${DP_ROOT}/standard_library_init.robot

Resource     ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource     ${GP_KEYWORD_ROOT}/keywords_contract_users.robot
Resource     ${GP_KEYWORD_ROOT}/keywords_es_bill_writeoffs.robot
Resource     ${GP_KEYWORD_ROOT}/keywords_es_bill_writeoff_details.robot
Resource     ${GP_KEYWORD_ROOT}/keywords_es_contracts.robot
Resource     ${GP_KEYWORD_ROOT}/keywords_es_plans.robot
Resource     ${GP_KEYWORD_ROOT}/keywords_orders.robot
Resource     ${GP_KEYWORD_ROOT}/keywords_scooters.robot
Resource     ${GP_KEYWORD_ROOT}/keywords_users.robot

Force Tags      Es-Bill_Writeoffs
Suite Setup     Suite Setup
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-bill-writeoffs - get - invalid - get es_bill_writeoff with invalid fields
    [Tags]    FET
    [Setup]    Setup For FET
    [Template]    Verify Es Bill Writeoff Get With Invalid Fields
    402010006     get_data.status is invalid    status=3
    402010006     get_data.status is invalid    status=-1
    402010006     invalid invoice_type          invoice_type=-1
    402010006     invalid invoice_type          invoice_type=6

es-bill-writeoffs - get - valid - get es_bill_writeoff by es_bill_id
    Create Paid Complete Es Bill

    ${resp_get} =    Get Es Bill Writeoffs By BillId    es_bill_id=${bill_id}
	Verify Status Code As Expected         ${resp_get}                        	      200
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['amount']}    ${balance_price}
    Verify Response Contains Expected      ${resp_get.json()['data'][0]['status']}    1

es-bill-writeoffs - update - invalid - update es_bill_writeoff with null required fields
	[Tags]    FET
	[Setup]    Setup For FET

	[Template]    Verify Es Bill Writeoff Update With Invalid Fields
	402010006     [updateData[0].writeoffStatus]]; default message [must not be null]]   writeoff_status=${None}  es_bill_id=${bill_id}  es_bill_writeoff_id=${None}  invoice_time=${invoice_time}  invoice_no=${invoice_no}
	402010004     update_data[0].es_bill_writeoff_id and es_bill_id cannot both be null  writeoff_status=1        es_bill_id=${None}     es_bill_writeoff_id=${None}  invoice_time=${invoice_time}  invoice_no=${invoice_no}

es-bill-writeoffs - update - invalid - update es_bill_writeoff with invalid required fields
	[Tags]    FET
	[Setup]    Setup For FET

	[Template]    Verify Es Bill Writeoff Update With Invalid Fields
	402010006     update_data[0].writeoff_status is invalid                                               writeoff_status=-1  es_bill_id=${bill_id}  es_bill_writeoff_id=${None}  invoice_time=${invoice_time}  invoice_no=${invoice_no}
	402010006     update_data[0].writeoff_status is invalid                                               writeoff_status=5   es_bill_id=${bill_id}  es_bill_writeoff_id=${None}  invoice_time=${invoice_time}  invoice_no=${invoice_no}
	402010006     updateData[0].invoiceRandomCode],4,0]; default message [size must be between 0 and 4]]  writeoff_status=1   es_bill_id=${bill_id}  es_bill_writeoff_id=${None}  invoice_time=${invoice_time}  invoice_no=${invoice_no}    invoice_random_code=12345
	402010006     invalid invoice_type                                                                    writeoff_status=1   es_bill_id=${bill_id}  es_bill_writeoff_id=${None}  invoice_time=${invoice_time}  invoice_no=${invoice_no}    invoice_type=-1
	402010006     invalid invoice_type                                                                    writeoff_status=1   es_bill_id=${bill_id}  es_bill_writeoff_id=${None}  invoice_time=${invoice_time}  invoice_no=${invoice_no}    invoice_type=6

es-bill-writeoffs - update - valid - register an invoice to a paid complete bill
	Create Paid Complete Es Bill

	${timeNow} =    Evaluate    int(time.time())   time
	${invoice_no} =      Set Variable    Inv${uniqueInvoiceNo}
	${invoice_time} =    Set Variable    ${timeNow}
	${invoice_type} =    Set Variable    1
	${invoice_random_code} =    Set Variable    123

	${resp} =    Register Invoice To An Es Bill Writeoff By Es_Bill_Id    es_bill_id=${bill_id}
	...    invoice_no=${invoice_no}     invoice_time=${invoice_time}
	...    invoice_type=${invoice_type}    invoice_random_code=${invoice_random_code}
    ${resp_get} =    Get Es Bill Writeoffs By BillId    es_bill_id=${bill_id}
    ${resp_bill_get} =    Es Bills Get    es_bill_ids=${bill_id}

	Verify Status Code As Expected         ${resp}                        				           200
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['es_bill_id']}	           ${bill_id}
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['invoice_no']}	           ${invoice_no}
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['invoice_time']}	       ${invoice_time}
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['invoice_type']}	       ${invoice_type}
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['invoice_random_code']}    ${invoice_random_code}
    Verify Response Contains Expected      ${resp_bill_get.json()['data'][0]['payment_status']}    1
    Verify Response Contains Expected      ${resp_bill_get.json()['data'][0]['bill_status']}       6

es-bill-writeoffs - update - valid - regist an invoice to a partial paid bill
    Create Partial Paid Es Bill

	${timeNow} =    Evaluate    int(time.time())   time
	${invoice_no} =      Set Variable    Inv${uniqueInvoiceNo}
	${invoice_time} =    Set Variable    ${timeNow}
	${invoice_type} =    Set Variable    1
	${invoice_random_code} =    Set Variable    123

	${resp} =    Register Invoice To An Es Bill Writeoff By Es_Bill_Id    es_bill_id=${bill_id}
	...    invoice_no=${invoice_no}     invoice_time=${invoice_time}
	...    invoice_type=${invoice_type}    invoice_random_code=${invoice_random_code}
    ${resp_get} =    Get Es Bill Writeoffs By BillId    es_bill_id=${bill_id}
    ${resp_bill_get} =    Es Bills Get    es_bill_ids=${bill_id}

	Verify Status Code As Expected         ${resp}                        				           200
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['es_bill_id']}	           ${bill_id}
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['invoice_no']}	           ${invoice_no}
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['invoice_time']}	       ${invoice_time}
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['invoice_type']}	       ${invoice_type}
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['invoice_random_code']}    ${invoice_random_code}
    Verify Response Contains Expected      ${resp_get.json()['data'][0]['amount']}                 ${partial_paid_amount}
    Verify Response Contains Expected      ${resp_bill_get.json()['data'][0]['payment_status']}    0
    Verify Response Contains Expected      ${resp_bill_get.json()['data'][0]['bill_status']}       6

*** Keywords ***
# -------- Setup  Keywords --------
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
    ${es_plan_id} =    Get Es Plan Id Via Es Plan Name    綁定 3 年 $899 方案
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}
    Set Test Variable    ${Order}         ${Orders('P0${order_number}')}
    Set Test Variable    ${User}          ${Users()}

Setup For FET
	Test Setup
	Create Paid Complete Es Bill

	Set Test Variable    ${invoice_no}     Inv${uniqueInvoiceNo}
	Set Test Variable    ${invoice_time}    ${timestamp}

Suite Setup
	${timestamp} =    Evaluate    int(time.time())   time
	Set Suite Variable   ${uniqueInvoiceNo}    ${timestamp}

Test Setup
	${timestamp} =    Evaluate    int(time.time())   time
	${uniqueInvoiceNo} =    Set Variable    int(${uniqueInvoiceNo}+1)

	Set Test Variable    ${timestamp}
	Set Test Variable    ${scooters_count}    1
	Set Test Variable    ${brand_company_code}    B22318608
	Set Test Variable    ${model_code}    BUS
	Set Test Variable    ${balance_price}	499.0

    Setup Test Object Variable
    ${User.user_id} =        Create User    ${User}
    ${contract_user_id} =    Create Contract User  ${User}
    ${Order.order_id}    ${Order.owner_id} =    Set Variable    ${None}    ${contract_user_id}
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
	Setup Scooters

# -------- Gogoro Keywords --------
Create Es Bill
    ${bill_period} =       Get Current Date    result_format=%Y-%m
    ${date_from} =         Get Current Date    increment=-15 days       result_format=epoch    exclude_millis=yes
    ${date_to} =           Get Current Date    increment=15 days        result_format=epoch    exclude_millis=yes
    ${due_date} =          Get Current Date    increment=15 days        result_format=epoch    exclude_millis=yes
    ${issue_date} =        Get Current Date    increment=-1 day         result_format=epoch    exclude_millis=yes
    ${last_calc_date} =    Get Current Date    increment=-30 day        result_format=epoch    exclude_millis=yes
    ${date_from} =         Convert To Integer    ${date_from}
    ${last_calc_date} =    Convert To Integer    ${last_calc_date}
    ${due_date} =          Convert To Integer    ${due_date}
    FOR    ${index}    IN RANGE    5
        ${code} =    Generate Random String    8    [NUMBERS][UPPER]
        Set Test Variable    ${code${index}}    ${code}
    END
    ${resp} =    Es Bills Post
    ...    ${User.user_id}            ${bill_period}
    ...    bank_barcode1=${code0}     bank_barcode2=${code1}
    ...    store_barcode1=${code2}    store_barcode2=${code3}    store_barcode3=${code4}
    ...    bill_to_address=${User.contact_address}    bill_to_zipcode=${User.contact_zip}    bill_to_email=${User.email}
    ...    due_date=${due_date}       date_from=${date_from}     date_to=${date_to}    issue_date=${issue_date}
    ...    latest_bill_calc_end_date=${last_calc_date}    amount=499     settle_days=31
    ...    bill_to_name=dataplatform_test       base_price_amount=499     over_unit_price_amount=0
    ...    other_charge_amount=0                addon_price_amount=0      promotion_price_amount=0
    ...    penalty_amount=0                     delivery_method=1         es_contract_id=${EsContract.es_contract_id}
    ...    scooter_id=${Scooter0.scooter_id}    resource_type=5           other_data=Test data
    ...    details_amount=499                   tax_amount=0              tax_rate=0
    ...    adjustment_amount=0                  balance=${balance_price}               bill_status=1
    ...    previous_balance=0                   previous_paid_amount=0    bill_type=1
    ...    payment_type=1                       suspend_days=0
    ${bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    Set Test Variable    ${bill_id}
    Set Test Variable    ${date_from}
    Set Test Variable    ${date_to}

Create Issed Es Bill
	Create Es Bill
	Es Bills Transitions Update    2    ${bill_id}
    Es Bills Transitions Update    3    ${bill_id}
    Es Bills Transitions Update    4    ${bill_id}

Create Paid Complete Es Bill
	Create Issed Es Bill

	${timeNow} =    Evaluate    int(time.time())   time
	Set Test Variable    ${transaction_id}		TEST_${timeNow}

	Create Es Bill Writeoff Detail
    ...    es_bill_id=${bill_id}    transaction_id=${transaction_id}   	  transaction_time=1           amount=${balance_price}
    ...    credit_card_no=87654321

Create Partial Paid Es Bill
    Create Issed Es Bill

	${timeNow} =    Evaluate    int(time.time())   time
	Set Test Variable    ${transaction_id}		TEST_${timeNow}
    SET Test Variable    ${partial_paid_amount}    1.0

	Create Es Bill Writeoff Detail
    ...    es_bill_id=${bill_id}    transaction_id=${transaction_id}   	  transaction_time=1           amount=${partial_paid_amount}
    ...    credit_card_no=87654321

# -------- Verify Keywords --------
Verify Es Bill Writeoff Get With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Es Bill Writeoffs Get    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Es Bill Writeoff Update With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Es Bill Writeoffs Update    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}