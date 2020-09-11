*** Settings ***
Documentation    Test suite for MyGogoro
Resource    ../../init.robot

Force Tags    MyGogoroWeb Myplan
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}
# Suite Setup    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
# Suite Teardown    Close All Browsers

*** Test Cases ***
Paper Invoice Setting In MyPlan Positive Test
    # Click Longin Function
    Navigate To My Plan Page
    Paper Invoice Setting In MyPlan

*** Keywords ***
# -------- MyGogoro Keyword --------  # 
Navigate To My Plan Page
    [Documentation]    Navigate to My Plan page after click left menu
    Assign Id To Element    //*[@id="app"]/div[2]/aside/ul[1]/li/a      MyPlan_btn
    #將Element的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  MyPlan_btn   timeout=20
    Sleep    5s 
    Click element   MyPlan_btn
    Wait Until Location Is    https://pa-network-my.gogoro.com/my-plan   30s


Click Longin Function
    Input Valid Data For Login Page
    Sleep    1s
    Wait Until Keyword Succeeds    10s    2s    Verify Menu Myplan String       我的電池服務資費

# Go to My Plan page
#     Navigate to My Plan page
#     Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://pa-network-my.gogoro.com/my-plan 
#     Check Go To Myplan Page

Activate Subscription
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

Go To My-Plan Page
    Open Browser    ${MYGOGORO_GN_DOMAIN}    ${WINDOW_HEIGHT}    ${WINDOW_WEIGHT}
    Login With Email And Password For MyPlan    ${User.email}    Gogoro123
    Go To    https://pa-network-my.gogoro.com/my-plan

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

Scooter Swap Batteries To Active Addon
    Add Scooter Mileage    ${scooter_guid}    ${battery_guid0}    ${battery_guid1}\
    ...    ${battery_guid2}    ${battery_guid3}    45    45

Setup Battery Variables
    Set Suite Variable    ${Battery}    ${Batteries()}

Setup Scooter Variables
    Set Suite Variable    ${Scooter}    ${Scooters('B22318608', 'BUS')}

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