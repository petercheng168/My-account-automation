*** Settings ***
Documentation    Test suite for MyGogoro new subscription flow
Resource    ../../init.robot

Force Tags    MyGogoroWeb    New-Sub
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Setup    Mapping Scooter VIN And Batteries
Test Teardown    Test Teardown
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***

# Create nac new subscription with addon
#     Click Button Type Button    建立電池服務合約
#     Agree Terms And Conditions
#     Input User Information As Subscriber
#     Choose Es Contract Settings
#     Upload User Id Card
#     Send Es Contract To User Email After Sign A Signature
#     Upload User Scooter Information    ${Scooter.plate}    ${User.last_name}${User.first_name}    ${Scooter.scooter_vin}    ${last_six_sn}
#     Agree And Activate Es Contract
#     Verify User Contains Scooter    ${scooter_Id}    ${Scooter.scooter_guid}    ${Scooter.plate}    ${Scooter.scooter_vin}    ${gogoro-sess}    ${csrf_token}

# Create new subscription without addon
#     Setup User Variables
#     Signup User
#     Suite Setup
#     Click Button Type Button    建立電池服務合約
#     Agree Terms And Conditions
#     Input User Information As Subscriber
#     Choose Es Contract Settings    addon=None
#     Upload User Id Card
#     Send Es Contract To User Email After Sign A Signature
#     Upload User Scooter Information    ${Scooter.plate}    ${User.last_name}${User.first_name}    ${Scooter.scooter_vin}    ${last_six_sn}
#     Agree And Activate Es Contract
#     Verify User Contains Scooter    ${scooter_Id}    ${Scooter.scooter_guid}    ${Scooter.plate}    ${Scooter.scooter_vin}    ${gogoro-sess}    ${csrf_token}


# Change plan when user create new subscription
#     [Tags]    Change-Plan
#     Click Button Type Button    建立電池服務合約
#     Agree Terms And Conditions
#     Input User Information As Subscriber
#     Choose Es Contract Settings
#     Upload User Id Card
#     Send Es Contract To User Email After Sign A Signature
#     Upload User Scooter Information    ${Scooter.plate}    ${User.last_name}${User.first_name}    ${Scooter.scooter_vin}    ${last_six_sn}    
#     Change Plan And Confirm    預選里程 630
#     Agree And Activate Es Contract
#     Verify User Contains Scooter    ${scooter_Id}    ${Scooter.scooter_guid}    ${Scooter.plate}    ${Scooter.scooter_vin}    ${gogoro-sess}    ${csrf_token}

*** Keywords ***
Create Batteries
    :FOR    ${index}    IN RANGE    2
    \    Create Battery    ${index}

Create Battery
    [Arguments]    ${index}
    Setup Battery Variables
    ${resp} =    Batteries Post    ${Battery.battery_guid}    ${Battery.battery_sn}    ${Battery.charge_cycles}\
    ...    ${Battery.state}    ${Battery.manufacture_date}    ${Battery.pn}
    Set Test Variable    ${battery_guid${index}}    ${Battery.battery_guid}
    Set Test Variable    ${battery_sn${index}}    ${Battery.battery_sn}

Create Scooter
    Setup Scooter Variables
    ${resp} =    Scooters Post    ${Scooter.company_code}    TW    ${Scooter.scooter_vin}\
    ...    ${Scooter.scooter_guid}    ${Scooter.matnr}    ${Scooter.atmel_key}    ${Scooter.state}    ${Scooter.es_state}\
    ...    ${Scooter.ecu_status}    ${Scooter.keyfobs_status}    keyfobs_id=${Scooter.keyfobs_id}\
    ...    motor_num=${Scooter.motor_num}    atmel_sn=${Scooter.atmel_sn}    ecu_mac=${Scooter.ecu_mac}\
    ...    ecu_sn=${Scooter.ecu_sn}    manufacture_date=${Scooter.manufacture_date}
    Set Test Variable    ${scooter_Id}    ${resp.json()['data'][0]['scooter_id']}

Mapping Scooter VIN And Batteries
    ${swap_id} =    Generate Random String    8    [NUMBERS]
    Create Scooter
    Create Batteries
    Batteries Swap Logs Post Gds    ${swap_id}    ${Scooter.scooter_guid}    ${battery_guid0}    ${battery_guid1}
    ${resp} =    Scooters Batteries Get    ${scooter_Id}
    ${last_six_sn} =    Evaluate    str('${battery_sn0}')[-6:]
    Set Test Variable    ${last_six_sn}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][0]['battery_sn']}    ${battery_sn0}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][1]['battery_sn']}    ${battery_sn1}

Setup Battery Variables
    Set Test Variable    ${Battery}    ${Batteries()}

Setup Scooter Variables
    Set Test Variable    ${Scooter}    ${Scooters('B22318608', 'BUS')}

Setup User Variables
    ${password} =    Encode Password Get    Gogoro123
    Set Suite Variable    ${User}    ${User('${password.text}')}

Signup User
    Setup User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    profile_id=E123456789    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Suite Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_Id}    1

Suite Setup
    Open Browser    ${NEWMYGOGORO_PA_DOMAIN}    ${WINDOW_HEIGHT}    ${WINDOW_WEIGHT}
    Signup User
    Login With Email And Password For AC    ${User.email}    Gogoro123
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}

Test Teardown
    ${resp} =    Api My Subscription Draft Delete    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    ${resp} =    Api My Subscription Inactive Delete    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Go To    https://pa-uat-network-my.gogoro.com/new-sub