*** Settings ***
Documentation    Test suite for get MyGogoro subscription promotion
Resource    ../../init.robot

Force Tags    MyGogoro    promotion
Suite Setup    Sign In New User
Test Setup    TestSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Get without promotion user subscription
    ${resp} =    Api My Subscription Es ContractId Promotion Get    ${es_contract_Id}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Verify Schema    ../../..MyGogoro_web/res/schema/api-my-subscription-es-contractId-promotion.json    getWithoutPromotionSubscription    ${resp.json()}
    Verify Response Contains Expected    ${resp.json()}    {'total': 0, 'items': []}

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

Create Scooter
    Setup Scooter Variables
    ${resp} =    Scooters Post    ${Scooter.company_code}    TW    ${Scooter.scooter_vin}\
    ...    ${Scooter.scooter_guid}    ${Scooter.matnr}    ${Scooter.atmel_key}    ${Scooter.state}    ${Scooter.es_state}\
    ...    ${Scooter.ecu_status}    ${Scooter.keyfobs_status}    keyfobs_id=${Scooter.keyfobs_id}\
    ...    motor_num=${Scooter.motor_num}    atmel_sn=${Scooter.atmel_sn}    ecu_mac=${Scooter.ecu_mac}\
    ...    ecu_sn=${Scooter.ecu_sn}    manufacture_date=${Scooter.manufacture_date}
    Set Test Variable    ${scooter_Id}    ${resp.json()['data'][0]['scooter_id']}

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

TestSetup
    Mapping Scooter VIN And Batteries
    Save User Detail As Subscriber    male    ${User.first_name}\
    ...    ${User.last_name}    ${User.birthday}    E123456789    ${User.mobile}    ${User.invoice_city}\
    ...    ${User.invoice_district}    ${User.invoice_zipcode}    ${User.invoice_address}\
    ...    ${User.contact_city}    ${User.contact_district}    ${User.contact_zipcode}\
    ...    ${User.contact_address}    ${gogoro-sess}    ${csrf_token}
    ${plan} =    Get Public Plan Detail    SUBFEE-00040    ${gogoro-sess}    ${csrf_token}
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
    Save Scooter Detail To Redis With Getting All Scooter    ${gogoro-sess}    ${csrf_token}
    Set Test Variable    ${plan_Id}    ${plan['id']}
    Set Test Variable    ${sku}    ${plan['sku']}
    Set Test Variable    ${locked_length}    ${plan['lockedLength']}
    Set Test Variable    ${charge_base}    ${plan['chargeBase']}
    Set Test Variable    ${charge_type}    ${plan['chargeType']}
    Set Test Variable    ${charge_unit}    ${plan['chargeUnit']}
    Set Test Variable    ${go_rewards}    ${plan['goRewards']}
    Set Test Variable    ${es_contract_Id}    ${contract.json()['id']}
