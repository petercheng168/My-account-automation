*** Settings ***
Documentation    API baseline of es-bills

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Variables         ${GP_LIB_ROOT}/DataPlatformObject.py

Library           ${GP_API_ROOT}/LibContractUsers.py
Library           ${GP_API_ROOT}/LibEsBillsTransitions.py
Library           ${GP_API_ROOT}/LibEsBills.py
Library           ${GP_API_ROOT}/LibEsBillWriteoffDetails.py
Library           ${GP_API_ROOT}/LibEsPlans.py
Library           ${GP_API_ROOT}/LibUsers.py
Library           ${GP_API_ROOT}/LibEsContracts.py
Library           ${GP_API_ROOT}/LibScooters.py
Library           ${GP_API_ROOT}/LibOrders.py
Library           ${GP_API_ROOT}/LibScootersInfos.py

Library           ${PROJECT_ROOT}/lib/LibAppCipher.py
Library           ${PROJECT_ROOT}/lib/LibCrypto.py

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_contract_users.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_bill_writeoff_details.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_bills.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_contracts.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_plans.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_orders.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_scooters.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_setup.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_users.robot

Force Tags      Es-Bills    Transition
Suite Setup     Suite Setup
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${test_bill_period}     1993-10
${test_date_from}       1000000000
${test_date_to}         1000000001
${err_date_from_and_date_to_must_provied}                ERROR: current_date_from and current_date_to must be provied at the same query
${err_es_bill_id_need_provide}                           ERROR: change over_due_paid_receive_date must provide current_es_bill_id_list
${err_over_due_paid_and_bill_status_at_the_same_time}    ERROR: cannot change over_due_paid_receive_date and bill_status at the same time
${err_bill_status_is_not_issued}                         ERROR: Only when bill_status is issued can have over_due_paid_receive_date. But the es_bill.bill_status != 4(issued) for es-bill id:
${err_cannot_all_be_null}                                ERROR: bill_status, issue_date, and over_due_paid_receive_date cannot all be null
${err_bill_status_must_be_2_3_4_5}                       bill_status must be in 2 3 4 5
${err_latest_bill_calc_end_date_must_provided}           For discard bill, latest_bill_calc_end_date must provided.

*** Test Cases ***
es-bills-transition - update - valid - es bill success update
    [Template]    Verify Es Bill Update With Valid Fields
    ${None}    ${EsBill.bill_id}    ${None}                  ${None}                ${None}              ${issue_date}    ${None}
    ${None}    ${None}              ${EsBill.bill_period}    ${None}                ${None}              ${issue_date}    ${None}
    ${None}    ${None}              ${None}                  ${EsBill.date_from}    ${EsBill.date_to}    ${issue_date}    ${None}
    ${None}    ${EsBill.bill_id}    ${test_bill_period}      ${None}                ${None}              ${issue_date}    ${None}
    ${None}    ${EsBill.bill_id}    ${None}                  ${test_date_from}      ${test_date_to}      ${issue_date}    ${None}
    2          ${EsBill.bill_id}    ${None}                  ${None}                ${None}              ${None}          ${None}
    3          ${EsBill.bill_id}    ${None}                  ${None}                ${None}              ${None}          ${None}
    4          ${EsBill.bill_id}    ${None}                  ${None}                ${None}              ${None}          ${None}
    ${None}    ${EsBill.bill_id}    ${None}                  ${None}                ${None}              ${None}          ${furture_timestamp}
    ${None}    ${EsBill.bill_id}    ${test_bill_period}      ${None}                ${None}              ${None}          ${furture_timestamp}
    ${None}    ${EsBill.bill_id}    ${None}                  ${test_date_from}      ${test_date_to}      ${None}          ${furture_timestamp}

es-bills-transition - update - invalid - bill status fail update to 0,1
    [Tags]    FET
    [Template]    Verify Es Bill Update With Invalid Fields
    402010006    ${err_bill_status_must_be_2_3_4_5}    bill_status=0    es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}    date_to=${None}      issue_date=${None}    over_due_paid_receive_date=${None}
    402010006    ${err_bill_status_must_be_2_3_4_5}    bill_status=1    es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}    date_to=${None}      issue_date=${None}    over_due_paid_receive_date=${None}

es-bills-transition - update - invalid - bill status and issue date fail update
    [Tags]    FET
    [Setup]    Setup Different Bill Status Bill
    [Template]    Verify Es Bill Update With Invalid Bill Status Update
    1    3          ${EsBill_status_1}    ${None}    ${None}    ${None}    ${None}          ${None}
    1    4          ${EsBill_status_1}    ${None}    ${None}    ${None}    ${None}          ${None}
    1    5          ${EsBill_status_1}    ${None}    ${None}    ${None}    ${None}          ${None}
    2    ${None}    ${EsBill_status_2}    ${None}    ${None}    ${None}    ${issue_date}    ${None}
    2    1          ${EsBill_status_2}    ${None}    ${None}    ${None}    ${None}          ${None}
    2    4          ${EsBill_status_2}    ${None}    ${None}    ${None}    ${None}          ${None}
    2    5          ${EsBill_status_2}    ${None}    ${None}    ${None}    ${None}          ${None}
    3    ${None}    ${EsBill_status_3}    ${None}    ${None}    ${None}    ${issue_date}    ${None}
    3    1          ${EsBill_status_3}    ${None}    ${None}    ${None}    ${None}          ${None}
    3    2          ${EsBill_status_3}    ${None}    ${None}    ${None}    ${None}          ${None}
    3    5          ${EsBill_status_3}    ${None}    ${None}    ${None}    ${None}          ${None}
    4    ${None}    ${EsBill_status_4}    ${None}    ${None}    ${None}    ${issue_date}    ${None}
    4    1          ${EsBill_status_4}    ${None}    ${None}    ${None}    ${None}          ${None}
    4    2          ${EsBill_status_4}    ${None}    ${None}    ${None}    ${None}          ${None}
    4    3          ${EsBill_status_4}    ${None}    ${None}    ${None}    ${None}          ${None}
    4    5          ${EsBill_status_4}    ${None}    ${None}    ${None}    ${None}          ${None}
    4    6          ${EsBill_status_4}    ${None}    ${None}    ${None}    ${None}          ${None}

es-bills-transition - update - invalid - es bill fail update when bill status = 1
    [Tags]    FET
    [Template]    Verify Es Bill Update With Invalid Fields
    604040002    ${err_date_from_and_date_to_must_provied}             bill_status=${None}    es_bill_ids=${None}              bill_period=${None}                  date_from=${test_date_from}      date_to=${None}              issue_date=${EsBill.issue_date}    over_due_paid_receive_date=${None}
    604040002    ${err_date_from_and_date_to_must_provied}             bill_status=${None}    es_bill_ids=${None}              bill_period=${None}                  date_from=${None}                date_to=${test_date_to}      issue_date=${EsBill.issue_date}    over_due_paid_receive_date=${None}
    604040002    ${err_bill_status_is_not_issued} ${decode_bill_id}    bill_status=${None}    es_bill_ids=${EsBill.bill_id}    bill_period=${None}                  date_from=${None}                date_to=${None}              issue_date=${None}                 over_due_paid_receive_date=${EsBill.over_due_paid_receive_date}
    604040002    ${err_es_bill_id_need_provide}                        bill_status=${None}    es_bill_ids=${None}              bill_period=${EsBill.bill_period}    date_from=${None}                date_to=${None}              issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}
    604040002    ${err_es_bill_id_need_provide}                        bill_status=${None}    es_bill_ids=${None}              bill_period=${None}                  date_from=${EsBill.date_from}    date_to=${EsBill.date_to}    issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}

es-bills-transition - update - invalid - es bill fail update when bill status = 2
    [Tags]    FET
    [Setup]    Setup Bill With Specific Status    2
    [Template]    Verify Es Bill Update With Invalid Fields
    604040002    ${err_bill_status_is_not_issued} ${decode_bill_id}   bill_status=2          es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}             date_to=${None}            issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}
    604040002    ${err_bill_status_is_not_issued} ${decode_bill_id}   bill_status=${None}    es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}             date_to=${None}            issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}
    604040002    ${err_date_from_and_date_to_must_provied}            bill_status=${None}    es_bill_ids=${None}              bill_period=${None}    date_from=${test_date_from}   date_to=${None}            issue_date=${EsBill.issue_date}    over_due_paid_receive_date=${None}
    604040002    ${err_date_from_and_date_to_must_provied}            bill_status=${None}    es_bill_ids=${None}              bill_period=${None}    date_from=${None}             date_to=${test_date_to}    issue_date=${EsBill.issue_date}    over_due_paid_receive_date=${None}

es-bills-transition - update - invalid - es bill fail update when bill status = 3
    [Tags]    FET
    [Setup]    Setup Bill With Specific Status    3
    [Template]    Verify Es Bill Update With Invalid Fields
    604040002    ${err_bill_status_is_not_issued} ${decode_bill_id}    bill_status=3          es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}              date_to=${None}            issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}
    604040002    ${err_bill_status_is_not_issued} ${decode_bill_id}    bill_status=${None}    es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}              date_to=${None}            issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}
    604040002    ${err_date_from_and_date_to_must_provied}             bill_status=${None}    es_bill_ids=${None}              bill_period=${None}    date_from=${test_date_from}    date_to=${None}            issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}
    604040002    ${err_date_from_and_date_to_must_provied}             bill_status=${None}    es_bill_ids=${None}              bill_period=${None}    date_from=${None}              date_to=${test_date_to}    issue_date=${EsBill.issue_date}    over_due_paid_receive_date=${None}

es-bills-transition - update - invalid - es bill fail update when bill status = 4
    [Tags]    FET
    [Setup]    Setup Bill With Specific Status    4
    [Template]    Verify Es Bill Update With Invalid Fields
    604040002    ${err_over_due_paid_and_bill_status_at_the_same_time}    bill_status=4          es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}              date_to=${None}            issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}
    604040002    ${err_date_from_and_date_to_must_provied}                bill_status=${None}    es_bill_ids=${None}              bill_period=${None}    date_from=${test_date_from}    date_to=${None}            issue_date=${None}                 over_due_paid_receive_date=${furture_timestamp}
    604040002    ${err_date_from_and_date_to_must_provied}                bill_status=${None}    es_bill_ids=${None}              bill_period=${None}    date_from=${None}              date_to=${test_date_to}    issue_date=${EsBill.issue_date}    over_due_paid_receive_date=${None}

es-bills-transitions - update - update bill_status to 99 without latest_bill_calc_end_date
    [Tags]    FET    CID:530
    ${resp} =    Es Bills Transitions Update    bill_status=99    es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}    date_to=${None}      issue_date=${None}    over_due_paid_receive_date=${None}
    Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    402010006    ${err_latest_bill_calc_end_date_must_provided}

es-bills-transitions - update - update bill_status to 99 with latest_bill_calc_end_date
    [Tags]    CID:531
    ${resp} =    Es Bills Transitions Update    bill_status=99    es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}    date_to=${None}      issue_date=${None}    over_due_paid_receive_date=${None}    latest_bill_calc_end_date=${timestamp}
    ${get_resp} =    Es Bills Get    ${EsBill.bill_id}
    ${es_contract_resp} =    Es Contracts Get    ${EsContract.es_contract_id}
	Verify Status Code As Expected       ${resp}    200
	Verify Status Code As Expected       ${get_resp}       200
    Verify Response Contains Expected    ${get_resp.json()["data"]}     []
    Verify Response Contains Expected    ${es_contract_resp.json()["data"][0]["latest_bill_calc_end_date"]}    ${timestamp}

es-bills-transitions - update - when update bill_status to status 2, latest_bill_calc_end_date should not be updated
    [Tags]    CID:532
    Es Bills Transitions Update    bill_status=${2}    es_bill_ids=${EsBill.bill_id}    latest_bill_calc_end_date=${timestamp}
	${get_resp} =    Es Bills Get    ${EsBill.bill_id}
    ${es_contract_resp} =    Es Contracts Get    ${EsContract.es_contract_id}
	Verify Status Code As Expected       ${get_resp}       200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["bill_status"]}    ${2}
    Verify Response Contains Expected    ${es_contract_resp.json()["data"][0]["latest_bill_calc_end_date"]}     ${EsBill.last_calc_date}

es-bills-transitions - update - when update bill_status to status 3, latest_bill_calc_end_date should not be updated
    [Tags]    CID:5379
    Update Bill Status    2    ${EsBill.bill_id}
    Es Bills Transitions Update    bill_status=${3}    es_bill_ids=${EsBill.bill_id}    latest_bill_calc_end_date=${timestamp}
	${get_resp} =    Es Bills Get    ${EsBill.bill_id}
    ${es_contract_resp} =    Es Contracts Get    ${EsContract.es_contract_id}
	Verify Status Code As Expected       ${get_resp}       200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["bill_status"]}    ${3}
    Verify Response Contains Expected    ${es_contract_resp.json()["data"][0]["latest_bill_calc_end_date"]}     ${EsBill.last_calc_date}

es-bills-transitions - update - when update bill_status to status 4, latest_bill_calc_end_date should not be updated
    [Tags]    CID:5380
    Update Bill Status    3    ${EsBill.bill_id}
    Es Bills Transitions Update    bill_status=${4}    es_bill_ids=${EsBill.bill_id}    latest_bill_calc_end_date=${timestamp}
	${get_resp} =    Es Bills Get    ${EsBill.bill_id}
    ${es_contract_resp} =    Es Contracts Get    ${EsContract.es_contract_id}
	Verify Status Code As Expected       ${get_resp}       200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["bill_status"]}    ${4}
    Verify Response Contains Expected    ${es_contract_resp.json()["data"][0]["latest_bill_calc_end_date"]}     ${EsBill.last_calc_date}

es-bills-transitions - update - when update bill_status to status 5, latest_bill_calc_end_date should not be updated
    [Tags]    CID:5381
    Update Bill Status    4    ${EsBill.bill_id}
    Pay Amount To Bill    ${EsBill.bill_id}    ${499}
    Es Bills Transitions Update    bill_status=${5}    es_bill_ids=${EsBill.bill_id}    latest_bill_calc_end_date=${timestamp}

	${get_resp} =    Es Bills Get    ${EsBill.bill_id}
    ${es_contract_resp} =    Es Contracts Get    ${EsContract.es_contract_id}
	Verify Status Code As Expected       ${get_resp}       200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["bill_status"]}    ${5}
    Verify Response Contains Expected    ${es_contract_resp.json()["data"][0]["latest_bill_calc_end_date"]}     ${EsBill.last_calc_date}

es-bills-transitions - update - when update negative latest_bill_calc_end_date should be fail
    [Tags]    CID:5252
    ${resp} =    Es Bills Transitions Update    bill_status=99    es_bill_ids=${EsBill.bill_id}    bill_period=${None}    date_from=${None}    date_to=${None}      issue_date=${None}    over_due_paid_receive_date=${None}    latest_bill_calc_end_date=${-1}
    Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    402010006    invalid latest_bill_calc_end_date value

*** Keywords ***
# -------- Setup  Keywords --------
Setup Test Object Variable
    [Arguments]    ${brand_company_code}    ${model_code}
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${es_plan_id} =      Get Es Plan Id Via Es Plan Name    綁定 3 年 $899 方案
    Set Test Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}
    Set Test Variable    ${Order}         ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}       ${Scooters('${brand_company_code}', '${model_code}')}
    Set Test Variable    ${User}          ${Users()}

Setup Bill With Specific Status
    [Arguments]    ${bill_status}
    Setup Test Object Variable    1500    AZ2
    Deliver Scooter To User
    Set Test Variable    ${EsBill}        ${EsBills()}
    Create Es Bill With Specific Bill Status    ${EsBill}    ${bill_status}
    ${decode_bill_id} =    Decode Encodeid    ${EsBill.bill_id}
    Set Test Variable    ${decode_bill_id}

Setup Different Bill Status Bill
    Setup Test Object Variable    1500    AZ2
    Deliver Scooter To User
    Set Test Variable    ${EsBill_status_1}     ${EsBills(bill_period="2019-01")}
    Set Test Variable    ${EsBill_status_2}     ${EsBills(bill_period="2019-02")}
    Set Test Variable    ${EsBill_status_3}     ${EsBills(bill_period="2019-03")}
    Set Test Variable    ${EsBill_status_4}     ${EsBills(bill_period="2019-04")}
    Create Es Bill With Specific Bill Status    ${EsBill_status_1}    1
    Create Es Bill With Specific Bill Status    ${EsBill_status_2}    2
    Create Es Bill With Specific Bill Status    ${EsBill_status_3}    3
    Create Es Bill With Specific Bill Status    ${EsBill_status_4}    4

Suite Setup
	${timestamp} =            Evaluate    int(time.time())   time
	${furture_timestamp} =    Evaluate    int(time.time() + 86400)   time
	Set Suite Variable    ${timestamp}
	Set Suite Variable    ${furture_timestamp}

Test Setup
    Setup Test Object Variable    1500    AZ2
    Deliver Scooter To User
    Set Test Variable    ${EsBill}        ${EsBills()}
    Set Test Variable    ${issue_date}                           1
    Set Test Variable    ${EsBill.over_due_paid_receive_date}    2
	${resp} =    Create Es Bill     ${EsBill}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    ${decode_bill_id} =    Decode Encodeid    ${EsBill.bill_id}
    Set Test Variable    ${decode_bill_id}

# -------- Gogoro Keywords --------
Create Es Bill With Specific Bill Status
    [Arguments]    ${EsBill}    ${bill_status}
    ${resp} =    Create Es Bill     ${EsBill}    ${EsContract}    ${User}    ${Scooter.scooter_id}
    ${EsBill.bill_id} =    Set Variable    ${resp.json()['data'][0]['es_bill_id']}
    Update Bill Status     ${bill_status}    es_bill_ids=${EsBill.bill_id}
    Set Test Variable      ${issue_date}                           1
    Set Test Variable      ${EsBill.over_due_paid_receive_date}    2

Deliver Scooter To User
    ${User.user_id} =          Create User    ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    1    turn_light=1    brake_light=1    tpms=0    sport_mode=0    warranty_start=${Scooter.warranty_start}    warranty_end=${Scooter.warranty_end}

Update Bill Status
    [Arguments]    ${bill_status}    ${es_bill_ids}
    FOR    ${index}    IN RANGE    2    ${bill_status}+1
        Es Bills Transitions Update    bill_status=${index}    es_bill_ids=${es_bill_ids}
    END

Pay Amount To Bill
    [Arguments]    ${bill_id}    ${balance_price}
	${timeNow} =    Evaluate    int(time.time())   time
	Set Suite Variable    ${transaction_id}		TEST_${timeNow}

	${resp} =    Create Es Bill Writeoff Detail
    ...    es_bill_id=${bill_id}    transaction_id=${transaction_id}
    ...    transaction_time=1
    ...    amount=${balance_price}
    ...    credit_card_no=87654321

    Set Suite Variable    ${es_bill_writeoff_detail_id}    ${resp.json()['data'][0]['es_bill_writeoff_detail_id']}

# -------- Verify Keywords --------
Verify Es Bill Update With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Es Bills Transitions Update    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Es Bill Update With Invalid Bill Status Update
	[Arguments]    ${expected_bill_status}    ${bill_status}    ${EsBill}    ${bill_period}
    ...            ${date_from}               ${date_to}        ${issue_date}    ${over_due_paid_receive_date}
	${update_resp} =    Es Bills Transitions Update
    ...    bill_status=${bill_status}    es_bill_ids=${EsBill.bill_id}    bill_period=${bill_period}
    ...    date_from=${date_from}        date_to=${date_to}               issue_date=${issue_date}
    ...    over_due_paid_receive_date=${over_due_paid_receive_date}

	${get_resp} =       Es Bills Get    ${EsBill.bill_id}
    ${over_due_paid_receive_date} =    Set Variable If    '${over_due_paid_receive_date}'=='None'
    ...    ${EsBill.over_due_paid_receive_date}
    ...    ${over_due_paid_receive_date}
	Verify Status Code As Expected       ${update_resp}    200
	Verify Status Code As Expected       ${get_resp}       200
    Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}     ${EsBill.bill_id}
	Verify Response Contains Expected    ${get_resp.json()["data"][0]["bill_status"]}    ${expected_bill_status}
	Verify Response Contains Expected    ${get_resp.json()["data"][0]["issue_date"]}     ${EsBill.issue_date}

Verify Es Bill Update With Valid Fields
	[Arguments]    ${bill_status}    ${es_bill_id}    ${bill_period}    ${date_from}    ${date_to}    ${issue_date}    ${over_due_paid_receive_date}
    ${update_resp} =    Es Bills Transitions Update
    ...    bill_status=${bill_status}    es_bill_ids=${es_bill_id}    bill_period=${bill_period}
    ...    date_from=${date_from}        date_to=${date_to}           issue_date=${issue_date}
    ...    over_due_paid_receive_date=${over_due_paid_receive_date}

	${get_resp} =    Es Bills Get    ${EsBill.bill_id}
    ${bill_status} =    Set Variable If    '${bill_status}'=='None'    ${get_resp.json()["data"][0]["bill_status"]}    ${bill_status}
    ${issue_date} =     Set Variable If    '${issue_date}'=='None'     ${get_resp.json()["data"][0]["issue_date"]}     ${issue_date}
    ${over_due_paid_receive_date} =    Set Variable If    '${over_due_paid_receive_date}'=='None'
    ...    ${EsBill.over_due_paid_receive_date}
    ...    ${over_due_paid_receive_date}
	Verify Status Code As Expected       ${update_resp}    200
	Verify Status Code As Expected       ${get_resp}       200
	Verify Response Contains Expected    ${get_resp.json()["data"][0]["es_bill_id"]}     ${EsBill.bill_id}
	Verify Response Contains Expected    ${get_resp.json()["data"][0]["bill_status"]}    ${bill_status}
	Verify Response Contains Expected    ${get_resp.json()["data"][0]["issue_date"]}     ${issue_date}
