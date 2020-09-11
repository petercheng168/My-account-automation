*** Settings ***
Documentation    Test suite for MyGogoro
Resource    ../../init.robot

Force Tags    MyGogoroWeb Myplan
Suite Setup    SuiteSetup  #建立新帳號
# Test Teardown    Go To    https://pa-network-my.gogoro.com/my-plan
Test Timeout    ${TEST_TIMEOUT}
# Suite Setup    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
# Suite Teardown    Close All Browsers

*** Test Cases ***
Change user profile         #M02-01-01
    [Setup]    Activate Subscription    True
    Go To My-Profile Page
    Input text      //*[@id="1val-profile-mobile"]      886-${User.mobile} 
    Click Element   //*[@id="app"]/div[2]/div/form/section[1]/div[3]/label[3]/label
    Click Element   //*[@id="app"]/div[2]/div/form/section[5]/div/button
    Sleep     2s
    ${resp} =    Api My Profile Get    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}    200
    Verify Schema    ../../../MyGogoro_web/res/schema/api-my-profile.json    getUserProfile    ${resp.json()}
    Log     ${resp.json()} 
    Verify Response Contains Expected    ${resp.json()['username']}    {'email': '${User.email}', 'emailVerified': 1, 'mobileVerified': 0}
    Verify Response Contains Expected    ${resp.json()['emails']}    [{'target': '${User.email}', 'isVerified': True, 'isPrimary': True}]
    Verify Response Contains Expected    ${resp.json()['lastName']}    ${User.last_name}
    Verify Response Contains Expected    ${resp.json()['displayName']}    ${User.display_name}
    Verify Response Contains Expected    ${resp.json()['gender']}    female
    Log     ${resp.json()} 

# Change gender to f
#     [Setup]    Activate Subscription    True
#     Go To My-Profile Page
#     Click Element   //*[@id="app"]/div[2]/div/form/section[1]/div[3]/label[4]/label
#     Click Element   //*[@id="app"]/div[2]/div/form/section[5]/div/button
#     ${resp} =    Api My Profile Get    ${gogoro-sess}    ${csrf_token}
#     Verify Status Code As Expected    ${resp}    200
#     Verify Schema    ../../../MyGogoro_web/res/schema/api-my-profile.json    getUserProfile    ${resp.json()}
#     Verify Response Contains Expected    ${resp.json()['username']}    {'email': '${User.email}', 'mobile': '${User.mobile}'}
#     Verify Response Contains Expected    ${resp.json()['emails']}    [{'target': '${User.email}', 'isVerified': True, 'isPrimary': True}]
#     Verify Response Contains Expected    ${resp.json()['lastName']}    ${User.last_name}
#     Verify Response Contains Expected    ${resp.json()['displayName']}    ${User.display_name}
#     Verify Response Contains Expected    ${resp.json()['gender']}    female

*** Keywords ***
# -------- MyGogoro Keyword --------  # 
Activate Subscription            #建立新合約
    [Arguments]    ${addon}
    Mapping Scooter VIN And Batteries
    Save User Detail As Subscriber    male    ${User.first_name}\
    ...    ${User.last_name}    ${User.birthday}    E123456789    ${User.mobile}    ${User.invoice_city}\
    ...    ${User.invoice_district}    ${User.invoice_zipcode}    ${User.invoice_address}\
    ...    ${User.contact_city}    ${User.contact_district}    ${User.contact_zipcode}\
    ...    ${User.contact_address}    ${gogoro-sess}    ${csrf_token}
    ${plan} =    Get Public Plan Detail    SUBFEE-00041    ${gogoro-sess}    ${csrf_token}
    Save Plan To Subscription    ${plan['id']}    ${plan['sku']}    ${plan['lockedLength']}\
    ...    ${plan['chargeType']}    ${plan['chargeBase']}    ${plan['chargeUnit']}\
    ...    ${plan['goRewards']}    ${gogoro-sess}    ${csrf_token}
    ${addon_id} =     Run Keyword If    '${addon}' == 'True'    
    ...    Add Addon With Specific Addon Code    SUBFEE-20002    ${gogoro-sess}    ${csrf_token}
    ...    ELSE   
    ...    Add Addon With Empty Payload    ${gogoro-sess}    ${csrf_token}
    Set Bill Config    0    e-carrier    false    ${gogoro-sess}    ${csrf_token}
    # Set Invoice Config   e-carrier    ${EMPTY}    ${EMPTY}    false    ${gogoro-sess}    ${csrf_token}
    ${contract} =    Save Draft Subscription    ${gogoro-sess}    ${csrf_token}
    Save Scooter Information For Inactive    ${Scooter.plate}    ${Scooter.scooter_vin}    ${Scooter.file_name}\
    ...    ${User.display_name}    ${last_six_sn}    ${gogoro-sess}    ${csrf_token}
    Activate Es Contract    ${gogoro-sess}    ${csrf_token}
    Save Scooter Detail To Redis With Getting All Scooter    ${gogoro-sess}    ${csrf_token}
    Set Suite Variable    ${plan_Id}    ${plan['id']}
    Set Suite Variable    ${sku}    ${plan['sku']}
    Set Suite Variable    ${locked_length}    ${plan['lockedLength']}
    Set Suite Variable    ${charge_base}    ${plan['chargeBase']}
    Set Suite Variable    ${charge_type}    ${plan['chargeType']}
    Set Suite Variable    ${charge_unit}    ${plan['chargeUnit']}
    Set Suite Variable    ${go_rewards}    ${plan['goRewards']}
    Set Suite Variable    ${es_contract_id}    ${contract.json()['id']}

Add Scooter Mileage
    [Arguments]    ${scooter_guid}    ${battery_guid_1}    ${battery_guid_2}    ${battery_guid_3}    ${battery_guid_4}    ${riding_distance}    ${total_distance}
    ${exchange_time} =    Get Current Date    UTC    result_format=%Y-%m-%dT%H:%M:%S.000000Z
    ${swap_Id} =    Generate Random String    6    [NUMBERS]
    Batteries Swap Logs Post Vm    ${VM_GUID}    ${swap_Id}    ${scooter_guid}\
    ...    ${battery_guid_1}    ${battery_guid_2}    ${battery_guid_3}    ${battery_guid_4}\
    ...    ${riding_distance}    ${total_distance}    ${exchange_time}

Create Batteries
    :FOR    ${index}    IN RANGE    4
    \    Create Battery    ${index}

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
    Set Suite Variable    ${scooter_id}    ${resp.json()['data'][0]['scooter_id']}
    Set Suite Variable    ${scooter_guid}    ${Scooter.scooter_guid}


Mapping Scooter VIN And Batteries
    ${swap_id} =    Generate Random String    8    [NUMBERS]
    Create Scooter
    Create Batteries
    Batteries Swap Logs Post Gds    ${swap_id}    ${Scooter.scooter_guid}    ${battery_guid0}    ${battery_guid1}
    ${resp} =    Scooters Batteries Get    ${scooter_id}
    ${last_six_sn} =    Evaluate    str('${battery_sn0}')[-6:]
    Set Suite Variable    ${last_six_sn}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][0]['battery_sn']}    ${battery_sn0}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][1]['battery_sn']}    ${battery_sn1}

# Scooter Swap Batteries To Active Addon
#     Add Scooter Mileage    ${scooter_guid}    ${battery_guid0}    ${battery_guid1}\
#     ...    ${battery_guid2}    ${battery_guid3}    45    45

Setup Battery Variables
    Set Suite Variable    ${Battery}    ${Batteries()}

Setup Scooter Variables
    Set Suite Variable    ${Scooter}    ${Scooters('B22318608', 'BUS')}


Go To My-Profile Page
    Open Browser    ${MYGOGORO_GN_DOMAIN}    ${WINDOW_HEIGHT}    ${WINDOW_WEIGHT}
    Login With Email And Password For MyPlan    ${User.email}    Gogoro123
    Go To    https://pa-network-my.gogoro.com/my-profile

Set User Variables
    ${password} =    Encode Password Get    Gogoro123
    Set Suite Variable    ${User}    ${User('${password.text}')}
    
Signup User
    Set User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    profile_id=E123456789    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    ${user_id} =    Set Variable        ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_id}    1

SuiteSetup
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}
    ${addon_end_date} =    Get Current Date    UTC    result_format=%Y-%m-%d
    Set Suite Variable    ${addon_end_date}
    Set Suite Variable    ${csrf_token}

Verify User Addon Code Is Correct
    [Arguments]    ${es_contract_id}    ${gogoro-sess}    ${csrf_token}    ${addon_code}
    ${resp} =    Api My Subscription Es ContractId Addon Get    ${es_contract_id}    ${gogoro-sess}    ${csrf_token}
    Verify Response Contains Expected    ${resp.json()['items'][0]['sku']}    ${addon_code}


