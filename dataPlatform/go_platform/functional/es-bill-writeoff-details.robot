*** Settings ***
Documentation    API baseline of es-bill-writeoff-details

Variables       ../../../env.py
Variables       ${PROJECT_ROOT}/setting.py    dev
Variables		${GP_LIB_ROOT}/DataPlatformObject.py

Library         ${GP_API_ROOT}/LibEsBillWriteoffs.py
Library			${GP_API_ROOT}/LibEsBills.py
Library         ${GP_API_ROOT}/LibEsPlans.py
Library			${GP_API_ROOT}/LibEsContracts.py
Library			${GP_API_ROOT}/LibEsBillWriteoffDetails.py

Resource        ${DP_ROOT}/standard_library_init.robot
Resource    	../init.robot

Resource        ${PROJECT_ROOT}/lib/keywords_common.robot
Resource        ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource        ${GP_KEYWORD_ROOT}/keywords_es_bill_writeoffs.robot
Resource        ${GP_KEYWORD_ROOT}/keywords_es_bill_writeoff_details.robot
Resource		${GP_KEYWORD_ROOT}/keywords_users.robot

Force Tags      Es-Bill-Writeoff-Details
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-bill-writeoff-details - add - valid - create es_bill_writeoff_detail with correct value
    [Setup]    Setup for Test With Template
    [Template]  Verify Es Bill Writeoff Detail With Valid Fields
    collection_time=${timestamp}
    collection_time=${timestamp}    credit_card_no=12345678
    collection_time=${timestamp}    credit_card_no=12345678    description=This is test

es-bill-writeoff-details - add - invalid - create es_bill_writeoff_detail with null required fields
    [Tags]    FET
    [Setup]    Setup for Test With Template
    [Template]    Verify Es Bill Writeoff Detail Post With Invalid Fields
    402010003     transaction_id must not be null  transaction_id=${None}    es_bill_id=${bill_id}   transaction_time=1           amount=${balance_price}
    402010003     transaction_source must not be null  transaction_id=${transaction_id}    es_bill_id=${bill_id}   transaction_time=1           amount=${balance_price}    transaction_source=${None}
    402010006     es_bill_id and es_bill_writeoff_id must not both be null  transaction_id=${transaction_id}    es_bill_id=${None}   transaction_time=1           amount=${balance_price}
    402010003     amount must not be null  transaction_id=${transaction_id}    es_bill_id=${bill_id}   transaction_time=1           amount=${None}

es-bill-writeoff-details - add - invalid - create es_bill_writeoff_detail with invalid fields
    [Tags]    FET
    [Setup]    Setup for Test With Template
    [Template]    Verify Es Bill Writeoff Detail Post With Invalid Fields
    402010006     transaction_source is invalid              transaction_id=${transaction_id}    es_bill_id=${bill_id}   transaction_time=1           amount=${balance_price}    transaction_source=0
    402010006     transaction_source is invalid              transaction_id=${transaction_id}    es_bill_id=${bill_id}   transaction_time=1           amount=${balance_price}    transaction_source=15
    402010006     credit_card_type must be in 0 1 2 3 4 5    transaction_id=${transaction_id}    es_bill_id=${bill_id}   transaction_time=1           amount=${balance_price}    credit_card_type=-1
    402010006     credit_card_type must be in 0 1 2 3 4 5    transaction_id=${transaction_id}    es_bill_id=${bill_id}   transaction_time=1           amount=${balance_price}    credit_card_type=6

*** Keywords ***
Setup Test Object Variable
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${es_plan_id} =    Get Es Plan Id Via Es Plan Name    綁定 3 年 $899 方案
    Set Test Variable    ${esContract}    ${EsContracts('${es_plan_id}')}
    Set Test Variable    ${order}         ${Orders('P0${order_number}')}
    Set Test Variable    ${user}          ${Users()}

Setup Scooters
    FOR    ${index}    IN RANGE    ${scooters_count}
        Set Test Variable    ${Scooter${index}}    ${Scooters('${brand_company_code}', '${model_code}')}
        ${scooter_id} =    Create Scooters    ${Scooter${index}}
        Set Test Variable    ${Scooter${index}.scooter_id}    ${scooter_id}
        Es Contracts Update Scooters    ${esContract.es_contract_id}    ${esContract.es_plan_id}    2    1    ${Scooter${index}.scooter_id}
        GDK Scooters Update Plate       ${Scooter${index}.vin}          ${Scooter${index}.plate}    ${Scooter${index}.plate_date}
    END

Test Setup
	${timestamp} =    Evaluate    int(time.time())   time

	Set Test Variable    ${timestamp}
	Set Test Variable    ${scooters_count}    1
	Set Test Variable    ${brand_company_code}    B22318608
	Set Test Variable    ${model_code}    BUS
	Set Test Variable    ${balance_price}	499.0

    Setup Test Object Variable
    ${user.user_id} =        Create User    ${user}
    ${contract_user_id} =    Create Contract User  ${user}
    ${order.order_id}    ${order.owner_id} =    Set Variable    ${None}    ${contract_user_id}
    ${esContract.es_contract_id} =    Create Es Contracts    ${order.order_id}    ${user.user_id}    1    ${order.owner_id}    1    ${order.owner_id}    ${esContract.es_plan_id}    ${esContract.start_date}    1    1    2
	Setup Scooters

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
    ...    ${user.user_id}            ${bill_period}
    ...    bank_barcode1=${code0}     bank_barcode2=${code1}
    ...    store_barcode1=${code2}    store_barcode2=${code3}    store_barcode3=${code4}
    ...    bill_to_address=${user.contact_address}    bill_to_zipcode=${user.contact_zip}    bill_to_email=${user.email}
    ...    due_date=${due_date}       date_from=${date_from}     date_to=${date_to}    issue_date=${issue_date}
    ...    latest_bill_calc_end_date=${last_calc_date}    amount=499     settle_days=31
    ...    bill_to_name=dataplatform_test       base_price_amount=499     over_unit_price_amount=0
    ...    other_charge_amount=0                addon_price_amount=0      promotion_price_amount=0
    ...    penalty_amount=0                     delivery_method=1         es_contract_id=${esContract.es_contract_id}
    ...    scooter_id=${Scooter0.scooter_id}    resource_type=5           other_data=Test data
    ...    details_amount=499                   tax_amount=0              tax_rate=0
    ...    adjustment_amount=0                  balance=${balance_price}               bill_status=1
    ...    previous_balance=0                   previous_paid_amount=0    bill_type=1
    ...    payment_type=1                       suspend_days=0
    ${bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    Set Test Variable    ${bill_id}
    Set Test Variable    ${date_from}
    Set Test Variable    ${date_to}

Create Issued Es Bill
	Create Es Bill
	Es Bills Transitions Update    2    ${bill_id}
    Es Bills Transitions Update    3    ${bill_id}
    Es Bills Transitions Update    4    ${bill_id}

Verify Es Bill Writeoff Detail With Valid Fields
    [Arguments]    &{fields}

    ${current_idx}    Set Variable    ${idx}

    ${timestamp} =    Evaluate    int(time.time())   time

    ${random_num} =    Generate Random String    1    [NUMBERS]
    # ${temp}    Evaluate    ${uniqueTransactionId} + ${random_num}
    # Set Test Variable    ${uniqueTransactionId}    ${temp}
    ${transaction_id}=    Set Variable    Tr_${uniqueTransactionId}${random_num}

    ${temp}    Evaluate    ${idx} + 1
    Set Test Variable    ${idx}    ${temp}

    ${resp} =    Es Bill Writeoff Details Post
    ...    transaction_id=${transaction_id}    transaction_time=${timestamp}    	  transaction_source=1        es_bill_id=${bill_id}
    ...    amount=1.0
	...    &{fields}

    ${resp_get} =    Es Bill Writeoff Details Get    es_bill_id=${bill_id}
    Verify Status Code As Expected         ${resp}                        				200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}      				es_bill_writeoff_detail_id
	Verify Response Contains Expected      ${resp_get.json()['data'][${current_idx}]['transaction_id']}	${transaction_id}
    Verify Response Contains Expected      ${resp_get.json()['data'][${current_idx}]['amount']}	1.0

Verify Es Bill Writeoff Detail Post With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Es Bill Writeoff Details Post    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Setup for Test With Template
	Test Setup
	Create Issued Es Bill
    Set Test Variable   ${uniqueTransactionId}    ${timestamp}
	${uniqueTransactionId} =    Set Variable    Evaluate    ${uniqueTransactionId+1}
    Set Test Variable    ${transaction_id}    Tr_${uniqueTransactionId}
    Set Test Variable    ${idx}    0