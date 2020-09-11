*** Settings ***
Documentation    Test suite for MyGogoro update subscription invoice-config
Resource    ../../init.robot

Force Tags    MyGogoro    invoice-config
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Update the subscription invoice config to commercial
    ${resp} =    Api My Subscription SubscriptionId Invoice Config Patch    ${es_contract_Id}    duplicate    gogoro_sess=${gogoro-sess}    csrf_token=${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Verify Response Contains Expected    ${resp.text}    OK
    Verify Subscription Invoice Config Is Correct    Commercial    ${scooter_Id}    duplicate    ${EMPTY}    ${EMPTY}    False    ${gogoro-sess}    ${csrf_token}

Update the subscription invoice config to donation
    [Setup]    Setup Donation Organization
    [Template]    Update Invoice Format To Donation
    ${財團法人伊甸社會福利基金會}
    ${中華民國災難救援協會}
    ${財團法人陽光社會福利基金會}
    ${公益關懷協會}
    ${社團法人台灣動物保護協進會}
    ${關懷弱勢協會}
    ${財團法人崔媽媽基金會}

Update the subscription invoice config to e-carrier
    ${resp} =    Api My Subscription SubscriptionId Invoice Config Patch    ${es_contract_Id}    e-carrier    gogoro_sess=${gogoro-sess}    csrf_token=${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Verify Response Contains Expected    ${resp.text}    OK
    Verify Subscription Invoice Config Is Correct    Membership    ${scooter_Id}    e-carrier    ${EMPTY}    ${EMPTY}    False    ${gogoro-sess}    ${csrf_token}

*** Keywords ***
Create Batteries
    FOR    ${index}    IN RANGE    2
        Create Battery    ${index}
    END

Create Battery
    [Arguments]    ${index}
    Setup Battery Variables
    ${resp} =    Batteries Post    ${Battery.battery_guid}    ${Battery.battery_sn}    ${Battery.charge_cycles}\
    ...    ${Battery.state}    ${Battery.manufacture_date}    ${Battery.pn}
    Set Suite Variable    ${battery_guid${index}}    ${Battery.battery_guid}
    Set Suite Variable    ${battery_sn${index}}    ${Battery.battery_sn}

Create Scooter
    Setup Scooter Variables
    ${resp} =    Scooters Post    ${Scooter.company_code}    TW    ${Scooter.scooter_vin}\
    ...    ${Scooter.scooter_guid}    ${Scooter.matnr}    ${Scooter.atmel_key}    ${Scooter.state}    ${Scooter.es_state}\
    ...    ${Scooter.ecu_status}    ${Scooter.keyfobs_status}    keyfobs_id=${Scooter.keyfobs_id}\
    ...    motor_num=${Scooter.motor_num}    atmel_sn=${Scooter.atmel_sn}    ecu_mac=${Scooter.ecu_mac}\
    ...    ecu_sn=${Scooter.ecu_sn}    manufacture_date=${Scooter.manufacture_date}
    Set Suite Variable    ${scooter_Id}    ${resp.json()['data'][0]['scooter_id']}

Get Es Contract Time
    [Arguments]    ${es_contract_Id}
    ${resp} =    Es Contracts Get    ${es_contract_Id}
    Set Suite Variable    ${plan_start}    ${resp.json()['data'][0]['plan_start']}
    Set Suite Variable    ${plan_end}    ${resp.json()['data'][0]['plan_end']}
    Set Suite Variable    ${plan_effective_date}    ${resp.json()['data'][0]['plan_effective_date']}

Mapping Scooter VIN And Batteries
    ${swap_Id} =    Generate Random String    8    [NUMBERS]
    Create Scooter
    Create Batteries
    Batteries Swap Logs Post Gds    ${swap_Id}    ${Scooter.scooter_guid}    ${battery_guid0}    ${battery_guid1}
    ${resp} =    Scooters Batteries Get    ${scooter_Id}
    ${last_six_sn} =    Evaluate    str('${battery_sn0}')[-6:]
    Set Suite Variable    ${last_six_sn}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][0]['battery_sn']}    ${battery_sn0}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][1]['battery_sn']}    ${battery_sn1}

Setup Battery Variables
    ${Battery}    Set Variable    ${Batteries()}
    Set Suite Variable    ${Battery}

Setup Donation Organization
    Set Test Variable    ${財團法人伊甸社會福利基金會}    25885 
    Set Test Variable    ${中華民國災難救援協會}    6274 
    Set Test Variable    ${財團法人陽光社會福利基金會}    13579 
    Set Test Variable    ${公益關懷協會}    9168 
    Set Test Variable    ${社團法人台灣動物保護協進會}    99520 
    Set Test Variable    ${關懷弱勢協會}    600101 
    Set Test Variable    ${財團法人崔媽媽基金會}    17864 

Setup Scooter Variables
    ${Scooter}    Set Variable    ${Scooters('B22318608', 'BUS')}
    Set Suite Variable    ${Scooter}

Set User Variables
    ${password} =    Encode Password Get    Gogoro123
    ${User}    Set Variable    ${User('${password.text}')}
    Set Suite Variable    ${User}

Sign In New User
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}

Signup User
    Set User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Suite Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_Id}    1

SuiteSetup
    Sign In New User
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
    Set Suite Variable    ${es_contract_Id}    ${contract.json()['id']}

Update Invoice Format To Donation
    [Arguments]    ${donate_to}
    ${resp} =    Api My Subscription SubscriptionId Invoice Config Patch    ${es_contract_Id}    e-carrier    ${donate_to}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Verify Response Contains Expected    ${resp.text}    OK
    Verify Subscription Invoice Config Is Correct    Donation    ${scooter_Id}    e-carrier    ${EMPTY}    ${EMPTY}    False    ${gogoro-sess}    ${csrf_token}    ${donate_to}