*** Settings ***
Documentation    Test suite for MyGogoro save scooter information
Resource    ../../init.robot

Force Tags    MyGogoro    vrc
Suite Setup    Sign In New User
Test Setup    TestSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Save scooter information with expected parameters
    ${resp} =    Api My Subscription Inactive Vrc Put    ${Scooter.plate}    ${Scooter.scooter_vin}    ${Scooter.file_name}\
    ...    ${User.display_name}    ${last_six_sn}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Verify Response Contains Expected    ${resp.text}    {"vrc":{"plate":"${Scooter.plate}","vin":"${Scooter.scooter_vin}","filename":"${Scooter.file_name}","batterySn":"${last_six_sn}"},"subscriber":{"id":"${subscriber_Id}","gender":"male","firstName":"${User.first_name}","lastName":"${User.last_name}","birthday":"${User.birthday}","idNumber":"E123456789","email":"${User.email}","mobile":"${User.mobile}","contactAddress":{"city":"${User.contact_city}","district":"${User.contact_district}","zipCode":"${User.contact_zipcode}","address":"${User.contact_address}"},"invoiceAddress":{"city":"${User.invoice_city}","district":"${User.invoice_district}","zipCode":"${User.invoice_zipcode}","address":"${User.invoice_address}"}}}
    Verify Schema    ../../..MyGogoro_web/res/schema/api-my-subscription-inactive-vrc.json    saveScooterInformation    ${resp.json()}

Save scooter information with incorrect batterySn
    ${resp} =    Api My Subscription Inactive Vrc Put    ${Scooter.plate}    ${Scooter.scooter_vin}    ${Scooter.file_name}\
    ...    ${User.display_name}    ${Scooter.plate}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   409
    Verify Response Contains Expected    ${resp.text}    {"error":{"status":409,"code":4,"message":"Battery doesn't match scooter"}}

Save scooter information with incorrect scooter owner name
    ${resp} =    Api My Subscription Inactive Vrc Put    ${Scooter.plate}    ${Scooter.scooter_vin}    ${Scooter.file_name}\
    ...    ${Scooter.file_name}    ${last_six_sn}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   409
    Verify Response Contains Expected    ${resp.text}    {"error":{"status":409,"code":3,"message":"Owner Name Not Match"}}

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
    ${plan} =    Get Public Plan Detail    SUBFEE-40036    ${gogoro-sess}    ${csrf_token}
    Save Plan To Subscription    ${plan['id']}    ${plan['sku']}    ${plan['lockedLength']}\
    ...    ${plan['chargeType']}    ${plan['chargeBase']}    ${plan['chargeUnit']}\
    ...    ${plan['goRewards']}    ${gogoro-sess}    ${csrf_token}
    Add Addon With Specific Addon Code    SUBFEE-20002    ${gogoro-sess}    ${csrf_token}
    Set Bill Config    0    e-carrier    false    ${gogoro-sess}    ${csrf_token}
    # Set Invoice Config   e-carrier    ${EMPTY}    ${EMPTY}    false    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Save Draft Subscription    ${gogoro-sess}    ${csrf_token}
    Set Test Variable    ${subscriber_Id}    ${resp.json()['subscriber']['id']}