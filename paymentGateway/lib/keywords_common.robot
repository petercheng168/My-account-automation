*** Keywords ***
# -------- PG Keywords --------
Generate Random Credit Card
    [Documentation]    Generate Payment Gateway Random Credit Card Number Stored In The Go Wallet
    ${first_6_digit} =    Generate Random String    6    [NUMBERS]
    ${last_4_digit} =    Generate Random String    4    [NUMBERS]
    ${credit_card_number} =    Catenate    ${first_6_digit}******${last_4_digit}
    [Return]    ${credit_card_number}

Check Bind Card URL Redirect
    [Arguments]  ${account_type}    ${response_json}    ${status_code}    ${key}    ${should_contain}
    Update User Info    ${account_type}    ${response_json}    ${status_code}
    ${auth_url} =    Get User Info    ${account_type}    ${key}
    ${card_info} =    Filter Get Card Page Info    ${PATMENT_GATEWAY_CREDIT_CARD_NUMBER}    ${PATMENT_GATEWAY_CREDIT_CARD_EXPIRED_DATE}    ${auth_url}
    ${card_no1} =    Set Variable    ${card_info['card_no1']}
    ${card_no2} =    Set Variable    ${card_info['card_no2']}
    ${card_no3} =    Set Variable    ${card_info['card_no3']}
    ${card_no4} =    Set Variable    ${card_info['card_no4']}
    ${expired_year} =    Set Variable    ${card_info['expired_year']}
    ${expired_month} =    Set Variable    ${card_info['expired_month']}
    ${trans_id} =    Set Variable    ${card_info['trans_id']}
    ${resp} =    Taishin Bank Auth    ${card_no1}    ${card_no2}    ${card_no3}    ${card_no4}
    ...    ${PATMENT_GATEWAY_CREDIT_CARD_NUMBER}    ${expired_month}    ${expired_year}
    ...    ${PATMENT_GATEWAY_CREDIT_CARD_EXPIRED_DATE}    ${trans_id}    ${PATMENT_GATEWAY_CREDIT_CARD_CVV2}
    ...    ${PAYMENT_GATEWAY_CARD_NAME}
    Should Contain    ${resp.text}    ${should_contain}

Check 3D Verification URL Redirect
    [Arguments]  ${account_type}    ${response_json}    ${status_code}    ${key}    ${should_contain}
    Update User Info    ${account_type}    ${response_json}    ${status_code}
    ${auth_url} =    Get User Info    ${account_type}    ${key}
    ${resp} =    Taishin 3D Verification Auth    ${auth_url}
    Should Contain    ${resp.text}    ${should_contain}

Binding Credit Card Process
    [Documentation]    Binding The Credit Card To User
    [Arguments]    ${auth}
    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    ${pay_source_account_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${101}    ${pay_source_account_id}    1
    ...    ${1}    ${2}    https://www.gogoro.com    https://www.facebook.com    ${auth}
    Check Bind Card URL Redirect    pg_correct_info    ${resp.json()}    ${resp.status_code}    card_auth_url    gogoro

Payment Gateway Test Data Setup
    [Documentation]    Keyword for test data setup with payment_type as input
    [Arguments]    ${payment_type}    ${date}    ${user_type}
    Delivery GSS Scooter With New User    ${user_type}
    Create Bill    ${payment_type}    ${date}
    Update ES Bill Info    es_bill_id=${bill_id}    bank_barcode1=${Bill.bank_code1}    bank_barcode2=${Bill.bank_code2}
    ...    store_barcode1=${Bill.store_code1}    store_barcode2=${Bill.store_code2}    store_barcode3=${Bill.store_code3}
    ...    user_email=${User.email}    user_password=${User.encode_password}    user_id=${user_id}    es_contract_id=${Bill.es_contract_id}

Unbinding Credit Card Process
    [Documentation]    Unbinding The Credit Card To User
    [Arguments]    ${auth}
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    ${wallet_id} =    Encode Hashid    ${PAYMENT_GATEWAY_WALLET_ID}
    ${credit_card_list_resp} =    Credit Card List     ${PAYMENT_GATEWAY_BANK_CODE}    ${member_id}    ${auth}
    ${credit_cards_resp} =    Get Credit Cards    ${wallet_id}    ${auth}
    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_list_resp.json()['ResultData'][0]['CardToken']}
    ...    ${member_id}    ${credit_cards_resp.json()['data'][0]['credit_card_id']}    ${wallet_id}    ${auth}

Get Wallets Information From User
    [Arguments]    ${auth}    ${user_id}
    ${resp} =    Get Wallets    ${auth}    user_ids=${user_id}
    [Return]    ${resp}

# -------- PG Setup Keywords --------
Create Bill
    [Arguments]    ${payment_type}    ${date}
    Setup Bill Variables    ${payment_type}    ${date}
    ${resp} =    Es Bills Post    ${Bill.user_id}    ${Bill.bill_period}    ${Bill.bank_code1}    ${Bill.bank_code2}    ${Bill.store_code1}\
    ...    ${Bill.store_code2}    ${Bill.store_code3}    ${Bill.contact_address}    ${Bill.contact_zipcode}    ${Bill.email}\
    ...    ${Bill.to_time}    ${Bill.from_time}    ${Bill.to_time}    amount=${Bill.amount}    settle_days=${Bill.settle_days}    bill_to_name=${Bill.bill_to_name}\
    ...    base_price_amount=${Bill.base_price_amount}    over_unit_price_amount=${Bill.over_unit_price_amount}    other_charge_amount=${Bill.other_charge_amount}\
    ...    addon_price_amount=${Bill.addon_price_amount}    promotion_price_amount=${Bill.promotion_price_amount}    penalty_amount=${Bill.penalty_amount}\
    ...    issue_date=${Bill.issue_date}    delivery_method=${Bill.delivery_method}    es_contract_id=${Bill.es_contract_id}    scooter_id=${Bill.scooter_id}\
    ...    resource_type=${Bill.resource_type}    other_data=${Bill.other_data}    details_amount=${Bill.details_amount}    latest_bill_calc_end_date=${Bill.last_calc_date}\
    ...    tax_amount=${Bill.tax_amount}    tax_rate=${Bill.tax_rate}    adjustment_amount=${Bill.adjustment_amount}    balance=${Bill.balance}    bill_status=${Bill.bill_status}\
    ...    previous_balance=${Bill.previous_balance}    previous_paid_amount=${Bill.previous_paid_amount}    payment_type=${Bill.payment_type}
    Set Suite Variable    ${bill_id}    ${resp.json()['data'][0]['es_bill_id']}
    Es Bills Transitions Update    2    ${bill_id}
    Es Bills Transitions Update    3    ${bill_id}
    Es Bills Transitions Update    4    ${bill_id}

Create Scooter
    Setup Scooter Variables
    ${resp} =    Scooters Post    ${Scooter.company_code}    TW    ${Scooter.scooter_vin}\
    ...    ${Scooter.scooter_guid}    ${Scooter.matnr}    ${Scooter.atmel_key}    ${Scooter.state}    ${Scooter.es_state}\
    ...    ${Scooter.ecu_status}    ${Scooter.keyfobs_status}    keyfobs_id=${Scooter.keyfobs_id}\
    ...    motor_num=${Scooter.motor_num}    atmel_sn=${Scooter.atmel_sn}    ecu_mac=${Scooter.ecu_mac}\
    ...    ecu_sn=${Scooter.ecu_sn}    manufacture_date=${Scooter.manufacture_date}
    Set Suite Variable    ${scooter_id}    ${resp.json()['data'][0]['scooter_id']}

Delivery GSS Scooter With New User
    [Arguments]    ${user_type}
    Setup Order Variables
    Setup Es Plan Variables
    Run Keyword If    '${user_type}' == 'new_user'    Prepare New User
    ...    ELSE IF    '${user_type}' == 'exist_user'    Prepare Exist User
    Create Scooter
    ${order_resp} =    Orders Post    VEH_SALE_CR    ${order_number}    I    ${user_Id}    30001
    Set Suite Variable    ${order_Id}    ${order_resp.json()['data'][0]['order_id']}
    Set Suite Variable    ${owner_Id}    ${order_resp.json()['data'][0]['owner_id']}
    ${es_plan_resp} =    Es Plans Get Via Plan Name    預選里程105
    Set Suite Variable    ${plan_id}    ${es_plan_resp.json()['data'][0]['plan_id']}
    ${es_contract_resp} =    Es Contracts Post    ${order_Id}    ${user_Id}    1    ${owner_Id}    1    ${owner_Id}    ${plan_id}    ${current_timestamp}    1    1    2
    Set Suite Variable    ${es_contract_id}    ${es_contract_resp.json()['data'][0]['es_contract_id']}
    Run Keyword If    '${ENV}' == 'dev'
    ...    Es Contracts Update Addons    ${es_contract_id}    ${plan_id}    2    1    6mQdYQNY    ${current_timestamp}    ${future_time}    ${current_timestamp}    1    0
    ...    ELSE
    ...    Es Contracts Update Addons    ${es_contract_id}    ${plan_id}    2    1    wKmBZDm8    ${current_timestamp}    ${future_time}    ${current_timestamp}    1    0
    Scooters Infos Update    ${order_number}    ${Scooter.scooter_vin}    ${user_Id}    ${owner_Id}    ${User.gogoro_guid}    0    turn_light=1    brake_light=1    tpms=0    sport_mode=1
    Orders Update    ${order_Id}    VEH_SALE_CR    ${order_number}    ${NONE}    ${user_Id}    30004    1    delivery_place=ES313020
    Scooters Infos Update    ${order_number}    ${Scooter.scooter_vin}    ${user_Id}    ${owner_Id}    ${User.gogoro_guid}    2    turn_light=1    brake_light=1    tpms=0    sport_mode=1
    Scooters Infos Update    ${order_number}    ${Scooter.scooter_vin}    ${user_Id}    ${owner_Id}    ${User.gogoro_guid}    3    turn_light=1    brake_light=1    tpms=0    sport_mode=1
    Orders Update    ${order_Id}    VEH_SALE_CR    ${order_number}    R    ${user_Id}    50001    1    plate=${Scooter.plate}    plate_date=${current_timestamp}
    Orders Update    ${order_Id}    VEH_SALE_CR    ${order_number}    DA    ${user_Id}    50001    1
    Scooters Infos Update    ${order_number}    ${Scooter.scooter_vin}    ${user_Id}    ${owner_Id}    ${User.gogoro_guid}    1    turn_light=1    brake_light=1    tpms=0    sport_mode=1    warranty_start=${current_timestamp}    warranty_end=${future_time}

Setup Bill Variables
    [Arguments]    ${payment_type}    ${date}
    ${bill_period} =    Get Current Date    result_format=%Y-%m
    ${time} =    Get Timestamp Interval    ${date}
    ${issue_date} =   Get Current Date    increment=-1 day    result_format=epoch    exclude_millis=yes
    ${last_calc_date} =   Get Current Date    increment=-30 day    result_format=epoch    exclude_millis=yes
    ${from_time} =    Convert To Integer    ${time['from_time']}
    ${to_time} =    Convert To Integer    ${time['to_time']}
    ${issue_date} =    Convert To Integer    ${issue_date}
    ${last_calc_date} =    Convert To Integer    ${last_calc_date}
    ${Bill}    Set Variable    ${SetUpBill('${user_id}','${User.email}','${es_contract_id}','${scooter_id}','${payment_type}','${bill_period}','${to_time}','${from_time}','${issue_date}','${last_calc_date}')}
    Set Suite Variable    ${Bill}

Setup Es Plan Variables
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${future_time} =    Evaluate    int(time.time() + 10000)    time
    Set Suite Variable    ${current_timestamp}
    Set Suite Variable    ${future_time}

Setup Order Variables
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Suite Variable    ${order_number}    P0${order_number}

Setup Scooter Variables
    ${Scooter}    Set Variable    ${SetUpScooter('1500', 'PC2')}
    Set Suite Variable    ${Scooter}

Set User Variables
    [Arguments]    ${user_type}
    ${password} =    Encode Password Get    Gogoro123
    ${User}    Set Variable    ${SetUpUser('${user_type}', '${password.text}')}
    Set Suite Variable    ${User}

Prepare New User
    Set User Variables    new_user
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}\
    ...    password=${User.encode_password}    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Suite Variable    ${user_id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_id}    1

Prepare Exist User
    Set User Variables    exist_user
    ${user_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    Set Suite Variable    ${user_id}