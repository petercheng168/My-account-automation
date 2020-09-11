*** Settings ***
Documentation    Test suite of batteries/swap-logs
Resource    ../init.robot

Force Tags    Batteries    Swap-Logs
Suite Setup    Setup Es Contract Variable
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${GDK_company_code}    B22318608
${GDK_model_code}      BUS
${GSS_company_code}    1500
${GSS_model_code}      AZ2

*** Test Cases ***
batteries-swap-logs - add - enable addon to delivered GSS scooter that addon effective_date should be swap time (obc)
    [Tags]    hotfix_1182
    [Setup]    Delivery GSS Scooter
    [Template]    Verify Add-On Effective Date After Swap Log
    SUBFEE-00002    OBC
    SUBFEE-10002    OBC
    SUBFEE-20002    OBC

batteries-swap-logs - add - enable addon to delivered GDK scooter that addon effective_date should be swap time (vm)
    [Tags]    Bug-Issue    Es-Addon
    [Setup]    Delivery GDK Scooter
    [Template]    Verify Add-On Effective Date After Swap Log
    SUBFEE-00002
    SUBFEE-10002
    SUBFEE-20002

batteries-swap-logs - add - enable addon to delivered GSS scooter that addon effective_date should be swap time (vm)
    [Tags]    Bug-Issue    Es-Addon
    [Setup]    Delivery GSS Scooter
    [Template]    Verify Add-On Effective Date After Swap Log
    SUBFEE-00002
    SUBFEE-10002
    SUBFEE-20002

*** Keywords ***
# -------- Setup  Keywords --------
Delivery GDK Scooter
    Test Setup    ${GDK_company_code}    ${GDK_model_code}    GDK
    GDK Scooters Update Plate    ${Scooter.vin}    ${Scooter.plate}    ${Scooter.plate_date}
    Scooter Deliveries Update    ${None}           ${Scooter.vin}      ${Scooter.plate}         ${User.birthday}    ${EsContract.es_contract_id}

Delivery GSS Scooter
    Test Setup    ${GSS_company_code}    ${GSS_model_code}    GSS
    Update Scooter Contract To Delivery Approval Status    ${Order}    ${Scooter}    ${User}    sport_mode=0
    Scooters Infos Update        ${Order.order_no}    ${Scooter.vin}    ${User.user_id}     ${Order.owner_id}    ${User.gogoro_guid}    1    turn_light=1    brake_light=1    tpms=0    sport_mode=0    warranty_start=${Scooter.warranty_start}    warranty_end=${Scooter.warranty_end}
    Scooter Deliveries Update    ${Order.order_id}    ${Scooter.vin}    ${Scooter.plate}    ${User.birthday}

Setup Es Contract Variable
    ${es_plan_id} =    Get Es Plan Id Via Es Plan Name    預選里程105
    Set Suite Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}

Setup Test Object Variable
    [Arguments]    ${brand_company_code}    ${model_code}
    ${exchange_time} =    Get Current Date    UTC    increment=+ 1 hours    result_format=%Y-%m-%dT%H:%M:%S.000000Z
    ${exchange_timestamp} =    Evaluate    int((datetime.datetime.strptime("${exchange_time}", "%Y-%m-%dT%H:%M:%S.%fZ") + datetime.timedelta(hours=8)).timestamp())    datetime
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${exchange_time}
    Set Test Variable    ${exchange_timestamp}
    Set Test Variable    ${Order}      ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}    ${Scooters('${brand_company_code}', '${model_code}')}
    Set Test Variable    ${User}       ${Users()}

Test Setup
    [Arguments]    ${brand_company_code}    ${model_code}    ${scooter_type}
    Setup Test Object Variable    ${brand_company_code}    ${model_code}
    ${User.user_id} =          Create User        ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    Mapping Scooter Vin And Batteries
    ${Order.order_id}    ${Order.owner_id} =    Run Keyword If    '${scooter_type}'=='GSS'
    ...    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ...    ELSE
    ...    Set Variable    ${None}    ${User.user_id}
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.effective_date}    1    1    2
    ${resp} =    Es Contracts Update Addons    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    1    1    ${None}    ${EsContract.start_date}    ${None}    ${None}    1    0    addon_code=SUBFEE-00003
    Verify Status Code As Expected    ${resp}    200

# -------- Gogoro Keywords --------
Add Add-On To Delivered Scooter
    [Arguments]    ${addon_code}
    ${addon_start_date} =    Evaluate    int(time.time())    time
    Set Test Variable    ${addon_start_date}
    ${resp} =    Es Contracts Update Addons    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    1    1    ${None}    ${addon_start_date}    ${None}    ${None}    1    0    addon_code=${addon_code}
    Verify Status Code As Expected    ${resp}    200

Create Batteries
    FOR    ${index}    IN RANGE    4
        Create Battery    ${index}
    END

Create Battery
    [Arguments]    ${index}
    ${Battery} =    Set Variable    ${Batteries()}
    ${resp} =    Batteries Post
    ...    ${Battery.battery_guid}    ${Battery.battery_sn}          ${Battery.charge_cycles}
    ...    ${Battery.state}           ${Battery.manufacture_date}    ${Battery.pn}
    Set Test Variable    ${battery_guid${index}}    ${Battery.battery_guid}
    Set Test Variable    ${battery_sn${index}}      ${Battery.battery_sn}

Disable Es Contract Add-On
    [Arguments]    ${addon_code}
    ${resp} =    Es Contracts Update Addons    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    2    3    ${None}    ${addon_start_date}    ${addon_start_date}    ${addon_start_date}    1    0    addon_code=${addon_code}

Mapping Scooter Vin And Batteries
    Create Batteries
    ${swap_id} =    Generate Random String    8    [NUMBERS]
    Batteries Swap Logs Post Gds    ${swap_id}    ${Scooter.guid}    ${battery_guid0}    ${battery_guid1}
    ${resp} =    Scooters Batteries Get    ${Scooter.scooter_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][0]['battery_sn']}    ${battery_sn0}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][1]['battery_sn']}    ${battery_sn1}

# -------- Verify Keywords --------
Verify Add-On Effective Date After Swap Log
    [Arguments]    ${addon_code}    ${source}=VM
    Add Add-On To Delivered Scooter    ${addon_code}
    Run Keyword If    '${source}' == 'VM'
    ...    Swap Scooter Batteries Via VM    ${Scooter.guid}    ${battery_guid0}    ${battery_guid1}    ${battery_guid2}    ${battery_guid3}    45    45
    ...    ELSE IF    '${source}' == 'OBC'
    ...    Swap Scooter Batteries Via OBC    ${Scooter.guid}    ${battery_guid0}    ${battery_guid1}    ${battery_guid2}    ${battery_guid3}    45    45
    Verify Es Contract Addon Effective Date As Expected    ${EsContract.es_contract_id}    ${addon_code}    ${exchange_timestamp}
    [Teardown]    Disable Es Contract Add-On     ${addon_code}