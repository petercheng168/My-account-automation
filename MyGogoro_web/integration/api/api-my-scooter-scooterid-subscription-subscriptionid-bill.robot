*** Settings ***
Documentation    Test suite for MyGogoro scooter bill
Resource    ../../init.robot

Force Tags    MyGogoro    bill
Suite Setup    SuiteSetup
Test Setup    TestSetupForActivateSubscription
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Get empty bill
    ${resp} =    Api My Scooter ScooterId Subscription SubscriptionId Bill Get    ${scooter_Id}    ${es_contract_Id}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Verify Schema    ../../..MyGogoro_web/res/schema/api-my-scooter-scooterId-subscription-subscriptionId-bill.json    getEmptyBill    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['total']}    0

Get user subscription bill
    [Setup]    TestSetupForAddNewBill
    ${resp} =    Api My Scooter ScooterId Subscription SubscriptionId Bill Get    ${scooter_Id}    ${es_contract_Id}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Verify Schema    ../../..MyGogoro_web/res/schema/api-my-scooter-scooterId-subscription-subscriptionId-bill.json    getEsContractBill    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['items'][0]['id']}    ${bill_Id}
    Verify Response Contains Expected    ${resp.json()['items'][0]['total']}    499
    Verify Response Contains Expected    ${resp.json()['items'][0]['period']}    ${bill_period}
    Verify Response Contains Expected    ${resp.json()['items'][0]['dueTime']}    ${to_time}

Get user subscription with incorrect scooter Id
    ${resp} =    Api My Scooter ScooterId Subscription SubscriptionId Bill Get    12345678    ${es_contract_Id}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   403
    Verify Schema    ../../..MyGogoro_web/res/schema/api-my-scooter-scooterId-subscription-subscriptionId-bill.json    errorWithIncorrectScooter    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()['error']['message']}    Scooter Not Found Under User

*** Keywords ***
Create Battery
    [Arguments]    ${index}
    Setup Battery Variables
    ${resp} =    Batteries Post    ${Battery.battery_guid}    ${Battery.battery_sn}    ${Battery.charge_cycles}\
    ...    ${Battery.state}    ${Battery.manufacture_date}    ${Battery.pn}
    Set Test Variable    ${battery_guid${index}}    ${Battery.battery_guid}
    Set Test Variable    ${battery_sn${index}}    ${Battery.battery_sn}

Create Batteries
    FOR    ${index}    IN RANGE    2
        Create Battery    ${index}
    END

Create Bill
    [Arguments]    ${user_Id}    ${bill_period}    ${code0}    ${code1}    ${code2}    ${code3}    ${code4}    ${bill_to_address}    ${bill_to_zipcode}    ${bill_to_email}    ${due_date}    ${date_from}    ${date_to}    ${issue_date}    ${last_calc_date}    ${es_contract_Id}    ${scooter_Id}
    ${resp} =    Es Bills Post    ${user_Id}    ${bill_period}    ${code0}    ${code1}    ${code2}\
    ...    ${code3}    ${code4}    ${bill_to_address}    ${bill_to_zipcode}    ${bill_to_email}\
    ...    ${due_date}    ${date_from}    ${date_to}    issue_date=${issue_date}    latest_bill_calc_end_date=${last_calc_date}    amount=499\
    ...    settle_days=31    bill_to_name=Mygogoro Test    base_price_amount=499    over_unit_price_amount=0\
    ...    other_charge_amount=0    addon_price_amount=0    promotion_price_amount=0    penalty_amount=0\
    ...    delivery_method=1    es_contract_id=${es_contract_Id}    scooter_id=${scooter_Id}    resource_type=5\
    ...    other_data=Test data    details_amount=499    tax_amount=0    tax_rate=0    adjustment_amount=0    balance=499\
    ...    bill_status=1    previous_balance=0    previous_paid_amount=0    bill_type=1    payment_type=1    suspend_days=0\
    Set Test Variable    ${bill_Id}    ${resp.json()['data'][0]['es_bill_id']}
    Es Bills Transitions Update    2    ${bill_Id}
    Es Bills Transitions Update    3    ${bill_Id}
    Es Bills Transitions Update    4    ${bill_Id}

Create Scooter
    Setup Scooter Variables
    ${resp} =    Scooters Post    ${Scooter.company_code}    TW    ${Scooter.scooter_vin}\
    ...    ${Scooter.scooter_guid}    ${Scooter.matnr}    ${Scooter.atmel_key}    ${Scooter.state}    ${Scooter.es_state}\
    ...    ${Scooter.ecu_status}    ${Scooter.keyfobs_status}    keyfobs_id=${Scooter.keyfobs_id}\
    ...    motor_num=${Scooter.motor_num}    atmel_sn=${Scooter.atmel_sn}    ecu_mac=${Scooter.ecu_mac}\
    ...    ecu_sn=${Scooter.ecu_sn}    manufacture_date=${Scooter.manufacture_date}
    Set Test Variable    ${scooter_Id}    ${resp.json()['data'][0]['scooter_id']}

Get Es Contract Time
    [Arguments]    ${es_contract_Id}
    ${resp} =    Es Contracts Get    ${es_contract_Id}
    Set Test Variable    ${plan_start}    ${resp.json()['data'][0]['plan_start']}
    Set Test Variable    ${plan_end}    ${resp.json()['data'][0]['plan_end']}
    Set Test Variable    ${plan_effective_date}    ${resp.json()['data'][0]['plan_effective_date']}

Mapping Scooter VIN And Batteries
    ${swap_Id} =    Generate Random String    8    [NUMBERS]
    Create Scooter
    Create Batteries
    Batteries Swap Logs Post Gds    ${swap_Id}    ${Scooter.scooter_guid}    ${battery_guid0}    ${battery_guid1}
    ${resp} =    Scooters Batteries Get    ${scooter_Id}
    ${last_six_sn} =    Evaluate    str('${battery_sn0}')[-6:]
    Set Test Variable    ${last_six_sn}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][0]['battery_sn']}    ${battery_sn0}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][1]['battery_sn']}    ${battery_sn1}

Setup Battery Variables
    ${Battery}    Set Variable    ${Batteries()}
    Set Test Variable    ${Battery}

Setup Scooter Variables
    ${Scooter}    Set Variable    ${Scooters('B22318608', 'BUS')}
    Set Test Variable    ${Scooter}

Setup User Variables
    ${password} =    Encode Password Get    Gogoro123
    ${User}    Set Variable    ${User('${password.text}')}
    Set Suite Variable    ${User}

Sign In New User
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}

Signup User
    Setup User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Suite Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_Id}    1

SuiteSetup
    ${time} =    Evaluate    time.strftime("%Y%m%d%s")    time
    ${date} =    Evaluate    time.strftime("%Y-%m-%d")    time
    ${timestamp} =    Evaluate    int(time.time())   time
    Set Suite Variable    ${time}
    Set Suite Variable    ${date}
    Set Suite Variable    ${timestamp}
    Sign In New User

TestSetupForActivateSubscription
    Mapping Scooter VIN And Batteries
    Save User Detail As Subscriber    male    ${User.first_name}\
    ...    ${User.last_name}    ${User.birthday}    E123456789    ${User.mobile}    ${User.invoice_city}\
    ...    ${User.invoice_district}    ${User.invoice_zipcode}    ${User.invoice_address}\
    ...    ${User.contact_city}    ${User.contact_district}    ${User.contact_zipcode}\
    ...    ${User.contact_address}    ${gogoro-sess}    ${csrf_token}
    ${plan} =    Get Public Plan Detail    SUBFEE-40036    ${gogoro-sess}    ${csrf_token}
    Save Plan To Subscription    ${plan['id']}    ${plan['sku']}    ${plan['lockedLength']}\
    ...    ${plan['chargeType']}    ${plan['chargeBase']}    ${plan['chargeUnit']}\
    ...    ${plan['goRewards']}    ${gogoro-sess}    ${csrf_token}
    Add Addon With Specific Addon Code    SUBFEE-20002    ${gogoro-sess}    ${csrf_token}
    Set Bill Config    0    e-carrier    false    ${gogoro-sess}    ${csrf_token}
    # Set Invoice Config   e-carrier    ${EMPTY}    ${EMPTY}    false    ${gogoro-sess}    ${csrf_token}
    ${contract} =    Save Draft Subscription    ${gogoro-sess}    ${csrf_token}
    Save Scooter Information For Inactive    ${Scooter.plate}    ${Scooter.scooter_vin}    ${Scooter.file_name}\
    ...    ${User.display_name}    ${last_six_sn}    ${gogoro-sess}    ${csrf_token}
    Activate Es Contract    ${gogoro-sess}    ${csrf_token}
    Get Es Contract Time    ${contract.json()['id']}
    Save Scooter Detail To Redis With Getting All Scooter    ${gogoro-sess}    ${csrf_token}
    Set Test Variable    ${plan_Id}    ${plan['id']}
    Set Test Variable    ${sku}    ${plan['sku']}
    Set Test Variable    ${locked_length}    ${plan['lockedLength']}
    Set Test Variable    ${charge_base}    ${plan['chargeBase']}
    Set Test Variable    ${charge_type}    ${plan['chargeType']}
    Set Test Variable    ${charge_unit}    ${plan['chargeUnit']}
    Set Test Variable    ${go_rewards}    ${plan['goRewards']}
    Set Test Variable    ${es_contract_Id}    ${contract.json()['id']}

TestSetupForAddNewBill
    TestSetupForActivateSubscription
    ${bill_period} =    Get Current Date    result_format=%Y-%m
    ${from_time} =    Get Current Date    increment=-15 days    result_format=epoch    exclude_millis=yes
    ${to_time} =    Get Current Date    increment=15 days    result_format=epoch    exclude_millis=yes
    ${issue_date} =   Get Current Date    increment=-1 day    result_format=epoch    exclude_millis=yes
    ${last_calc_date} =   Get Current Date    increment=-30 day    result_format=epoch    exclude_millis=yes
    ${from_time} =    Convert To Integer    ${from_time}
    ${last_calc_date} =    Convert To Integer    ${last_calc_date}
    ${to_time} =    Convert To Integer    ${to_time}
    FOR    ${index}    IN RANGE    5
        ${code} =    Generate Random String    8    [NUMBERS][UPPER]
        Set Test Variable    ${code${index}}    ${code}
    END
    Create Bill    ${user_Id}    ${bill_period}    ${code0}    ${code1}    ${code2}\
    ...    ${code3}    ${code4}    ${User.contact_address}    ${User.contact_zipcode}    ${User.email}\
    ...    ${to_time}    ${from_time}    ${to_time}    ${issue_date}    ${last_calc_date}\
    ...    ${es_contract_Id}    ${scooter_Id}
    Set Test Variable    ${bill_period}
    Set Test Variable    ${from_time}
    Set Test Variable    ${issue_date}
    Set Test Variable    ${last_calc_date}
    Set Test Variable    ${to_time}
