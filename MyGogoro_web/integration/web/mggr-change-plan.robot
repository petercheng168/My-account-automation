*** Settings ***
Documentation    Test suite for MyGogoro Change-plan page
Resource    ../../init.robot

Force Tags    MyGogoroWeb    Change-Plan
Suite Setup    SuiteSetup
# Suite Teardown    Close All Browsers
Test Teardown    Go To    https://pa-network-my.gogoro.com/my-plan
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***   
Change plan successfully
    [Setup]    Test Setup For New Plan    預選里程630
    Click Rounded Button    變更資費
    Click Select Plan Button    預選里程方案 630
    Fill In Change Plan Information    ${User}
    Confirm Change Plan Dialog
    Get Next Plan Start Date    ${es_contract_id}
    Verify Plan Card Message As Expected    ${next_plan_start}    預選里程方案 630
    Verify New Subscription Is Correct    ${scooter_id}    ${gogoro-sess}    ${csrf_token}     預選里程630  #預選里程630

Change plan to flex plan successfully
    [Setup]    Test Setup For New Plan    $299 自由省方案
    Click Rounded Button    變更資費
    Click Select Plan Button    $299 自由省方案
    Fill In Change Plan Information    ${User}
    Confirm Change Plan Dialog
    Get Next Plan Start Date    ${es_contract_id}
    Verify Plan Card Message As Expected    ${next_plan_start}    $299 自由省方案 及性能提升服務
    Verify New Subscription Is Correct    ${scooter_id}    ${gogoro-sess}    ${csrf_token}    $299 自由省方案

Change plan to bundle plan successfully
    [Setup]    Test Setup For New Plan    綁定 3 年 $899 方案
    Click Rounded Button    變更資費
    Click Select Plan Button    $899 騎到飽
    Fill In Change Plan Information    ${User}
    Confirm Change Plan Dialog
    Get Next Plan Start Date    ${es_contract_id}
    Verify Plan Card Message As Expected    ${next_plan_start}    $899 騎到飽
    Verify New Subscription Is Correct    ${scooter_id}    ${gogoro-sess}    ${csrf_token}    綁定 3 年 $899 方案


Change next plan to fixed plan
    [Setup]    Test Setup For New Plan    預選里程630
    Click Rounded Button    變更資費
    Click Select Plan Button    預選里程方案 630
    Fill In Wrong Name Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    預選里程方案 630
    Fill In Wrong ID Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    預選里程方案 630
    Fill In Wrong BD Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    預選里程方案 630
    Fill In Change Plan Information    ${User}
    Cancel Change Plan Dialog
    Click Select Plan Button    預選里程方案 630
    Fill In Change Plan Information    ${User}
    Confirm Change Plan Dialog
    Get Next Plan Start Date    ${es_contract_id}
    Verify Plan Card Message As Expected    ${next_plan_start}    預選里程方案 630
    Verify New Subscription Is Correct    ${scooter_id}    ${gogoro-sess}    ${csrf_token}    預選里程630

Change next plan to flex plan
    [Setup]    Test Setup For New Plan    $299 自由省方案
    Click Rounded Button    變更資費
    Click Select Plan Button    $299 自由省方案
    Fill In Wrong Name Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    $299 自由省方案
    Fill In Wrong ID Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    $299 自由省方案
    Fill In Wrong BD Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    $299 自由省方案
    Fill In Change Plan Information    ${User}
    Cancel Change Plan Dialog
    Click Select Plan Button    $299 自由省方案
    Fill In Change Plan Information    ${User}
    Confirm Change Plan Dialog
    Get Next Plan Start Date    ${es_contract_id}
    Verify Plan Card Message As Expected    ${next_plan_start}    $299 自由省方案 及性能提升服務
    Verify New Subscription Is Correct    ${scooter_id}    ${gogoro-sess}    ${csrf_token}    $299 自由省方案

Change next plan to bundle plan
    [Setup]    Test Setup For New Plan    綁定 3 年 $899 方案
    Click Rounded Button    變更資費
    Click Select Plan Button    $899 騎到飽
    Fill In Wrong Name Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    $899 騎到飽
    Fill In Wrong ID Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    $899 騎到飽
    Fill In Wrong BD Change Plan Information    ${User}
    Click Rounded Button    確認
    Wait Until Keyword Succeeds    20s    2s    Verify Wrong Info Plan Cannot Be Change Message       使用者資料錯誤\n您所輸入的使用者資料不正確，請重新輸入，或是請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，由專人為您服務。\n確認
    Click Select Plan Button    $899 騎到飽
    Fill In Change Plan Information    ${User}
    Cancel Change Plan Dialog
    Click Select Plan Button    $899 騎到飽
    Fill In Change Plan Information    ${User}
    Confirm Change Plan Dialog
    Get Next Plan Start Date    ${es_contract_id}
    Verify Plan Card Message As Expected    ${next_plan_start}    $899 騎到飽
    Verify New Subscription Is Correct    ${scooter_id}    ${gogoro-sess}    ${csrf_token}    綁定 3 年 $899 方案


*** Keywords ***
Activate Subscription
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
    Set Bill Config    0    e-carrier    false    ${gogoro-sess}    ${csrf_token}
    # # Set Invoice Config   e-carrier    ${EMPTY}    ${EMPTY}    false    ${gogoro-sess}    ${csrf_token}
    ${contract} =    Save Draft Subscription    ${gogoro-sess}    ${csrf_token}
    Save Scooter Information For Inactive    ${Scooter.plate}    ${Scooter.scooter_vin}    ${Scooter.file_name}\
    ...    ${User.display_name}    ${last_six_sn}    ${gogoro-sess}    ${csrf_token}
    Activate Es Contract    ${gogoro-sess}    ${csrf_token}
    Save Scooter Detail To Redis With Getting All Scooter    ${gogoro-sess}    ${csrf_token}
    Set Suite Variable    ${plan_id}    ${plan['id']}
    Set Suite Variable    ${sku}    ${plan['sku']}
    Set Suite Variable    ${locked_length}    ${plan['lockedLength']}
    Set Suite Variable    ${charge_base}    ${plan['chargeBase']}
    Set Suite Variable    ${charge_type}    ${plan['chargeType']}
    Set Suite Variable    ${charge_unit}    ${plan['chargeUnit']}
    Set Suite Variable    ${go_rewards}    ${plan['goRewards']}
    Set Suite Variable    ${es_contract_id}    ${contract.json()['id']}
    log to console      ${es_contract_id} 


Create Battery
    [Arguments]    ${index}
    Setup Battery Variables
    ${resp} =    Batteries Post    ${Battery.battery_guid}    ${Battery.battery_sn}    ${Battery.charge_cycles}\
    ...    ${Battery.state}    ${Battery.manufacture_date}    ${Battery.pn}
    Set Suite Variable    ${battery_guid${index}}    ${Battery.battery_guid}
    Set Suite Variable    ${battery_sn${index}}    ${Battery.battery_sn}

Create Batteries
    :FOR    ${index}    IN RANGE    2
    \    Create Battery    ${index}

Create Scooter
    Setup Scooter Variables
    ${resp} =    Scooters Post    ${Scooter.company_code}    TW    ${Scooter.scooter_vin}\
    ...    ${Scooter.scooter_guid}    ${Scooter.matnr}    ${Scooter.atmel_key}    ${Scooter.state}    ${Scooter.es_state}\
    ...    ${Scooter.ecu_status}    ${Scooter.keyfobs_status}    keyfobs_id=${Scooter.keyfobs_id}\
    ...    motor_num=${Scooter.motor_num}    atmel_sn=${Scooter.atmel_sn}    ecu_mac=${Scooter.ecu_mac}\
    ...    ecu_sn=${Scooter.ecu_sn}    manufacture_date=${Scooter.manufacture_date}
    Set Suite Variable    ${scooter_id}    ${resp.json()['data'][0]['scooter_id']}

Get Next Plan Start Date
    [Arguments]    ${es_contract_id}
    ${resp} =    Es Contracts Get    ${es_contract_id}
    ${plan_end} =    Set Variable        ${resp.json()['data'][0]['plan_end']}
    ${next_plan_start} =    Evaluate    int(${plan_end} + 86400)
    ${next_plan_start} =    Convert Date     ${next_plan_start}    result_format=%Y-%m-%d
    Set Test Variable    ${next_plan_start}

Mapping Scooter VIN And Batteries
    ${swap_id} =    Generate Random String    5    [NUMBERS]
    Create Scooter
    Create Batteries
    Batteries Swap Logs Post Gds    ${swap_id}    ${Scooter.scooter_guid}    ${battery_guid0}    ${battery_guid1}
    ${resp} =    Scooters Batteries Get    ${scooter_id}
    ${last_six_sn} =    Evaluate    str('${battery_sn0}')[-6:]
    Set Suite Variable    ${last_six_sn}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][0]['battery_sn']}    ${battery_sn0}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][1]['battery_sn']}    ${battery_sn1}

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
    Set Suite Variable    ${birth}    ${User.birthday}
    @{birthday} =    Split String    ${birth}    -
    ${User.year} =    Set Variable        @{birthday}[0]
    ${User.month} =    Set Variable        @{birthday}[1]
    ${User.date} =    Set Variable        @{birthday}[2]
    ${user_id} =    Set Variable        ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_id}    1

SuiteSetup
    Signup User
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}
    Activate Subscription 
    Open Browser    ${MYGOGORO_GN_DOMAIN}    ${WINDOW_HEIGHT}    ${WINDOW_WEIGHT}
    Login With Email And Password For MyPlan    ${User.email}    Gogoro123
    Go To    https://pa-network-my.gogoro.com/my-plan

Test Setup For New Plan
    [Arguments]    ${next_plan_name}
    ${next_plan_code} =    Get Es Plan Code Via Es Plan Name    ${next_plan_name}
    Set Test Variable    ${next_plan_code}

Verify New Subscription Is Correct
    [Arguments]    ${scooter_id}    ${gogoro-sess}    ${csrf_token}    ${next_plan}
    ${resp} =    Api My Scooter ScooterId Subscription Get    ${scooter_id}    ${gogoro-sess}    ${csrf_token}
    Verify Response Contains Expected    ${resp.json()['fallbackPlan']['name']}    ${next_plan}
    Verify Response Contains Expected    ${resp.json()['fallbackPlan']['sku']}    ${next_plan_code}