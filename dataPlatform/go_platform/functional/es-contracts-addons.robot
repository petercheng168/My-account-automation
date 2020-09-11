*** Settings ***
Documentation    Test suite of es-contracts addons
Resource    ../init.robot

Force Tags    Es-Contracts
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-contracts-addons - get - get es_contract addon
    [Setup]    Update Addons To Es Contracts
    ${resp} =    Es Contracts Addons Get    ${es_contract_id}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['es_contract_id']}    ${es_contract_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['es_addon_id']}       ${es_addons_Id}
    Verify Schema    es-contracts-addons.json    esContractsAddonsGet    ${resp.json()}

es-contracts-addons - get - get es_contract addon with invalid payload
    [Tags]    FET
    [Setup]    Update Addons To Es Contracts
    [Template]    Verify Es Contract Get With Invalid Payload
    9999                 ${None}           ${None}                 803010003    decode failed
    ${es_contract_id}    ${future_time}    ${current_timestamp}    402010005    End time can not be smaller than start time
    ${es_contract_id}    -1                -1                      402010006    [getData.timeFrom],0]; default message [must be greater than or equal to 0]
    ${es_contract_id}    -1                ${None}                 402010006    [getData.timeFrom],0]; default message [must be greater than or equal to 0]
    ${es_contract_id}    ${None}           -1                      402010006    [getData.timeTo],0]; default message [must be greater than or equal to 0]

*** Keywords ***
Create Es Contracts
    Setup Scooter Variables
    Setup Order Variables
    ${scooters_resp} =    Scooters Post    1300    TW    ${scooter_vin}    ${scooter_guid}    ${matnr}    ${atmel_key}    ${state}    ${es_state}    ${ecu_status}    ${keyfobs_status}    keyfobs_id=${keyfobs_id}
    ${order_resp} =    Orders Post    VEH_SALE_CR    ${order_number}    I    ${user_Id}    30001
    ${es_plan_resp} =    Get All Es Plans    1    1    0    ${current_timestamp}
    Set Test Variable    ${scooter_Id}    ${scooters_resp.json()['data'][0]['scooter_id']}
    Set Test Variable    ${order_Id}    ${order_resp.json()['data'][0]['order_id']}
    Set Test Variable    ${owner_Id}    ${order_resp.json()['data'][0]['owner_id']}
    Set Test Variable    ${es_plan_Id}    ${es_plan_resp.json()['data'][0]['plan_id']}
    ${es_contract_resp} =    Es Contracts Post    ${order_Id}    ${user_Id}    1    ${owner_Id}    1    ${owner_Id}    ${es_plan_Id}    ${current_timestamp}    1    1    2
    Set Test Variable    ${es_contract_id}    ${es_contract_resp.json()['data'][0]['es_contract_id']}

Create User
    Setup User Variables
    ${resp} =    Users Post    ${company_code}    ${first_name}    ${gender}    ${email}    ${status}    ${enable_e_carrier}    gogoro_guid=${gogoro_guid}
    Set Test Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}

Get Es Addons Id
    ${resp} =    Es Addons Get    status=1    published=1    valid_time_from=0    valid_time_to=${current_timestamp}
    Set Test Variable    ${es_addons_Id}    ${resp.json()['data'][0]['addon_id']}

Setup Order Variables
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${order_number}    P0${order_number}

Setup Scooter Variables
    ${scooter_vin} =    Generate Random String    7    [UPPER][NUMBERS]
    ${scooter_plate_first} =    Generate Random String    3    [UPPER]
    ${scooter_plate_second} =    Generate Random String    4    [NUMBERS]
    ${scooter_guid} =    Generate Random UUID
    ${time} =    Evaluate    time.strftime("%Y%m%d%s")    time
    Set Test Variable    ${time}
    Set Test Variable    ${scooter_vin}    PINJMETERJ${scooter_vin}
    Set Test Variable    ${scooter_plate}    ${scooter_plate_first}-${scooter_plate_second}
    Set Test Variable    ${scooter_guid}
    Set Test Variable    ${matnr}    GSAZ2-160-GR
    Set Test Variable    ${notor_num}    ${matnr}
    Set Test Variable    ${atmel_key}    ED554638AD91C64694A39262CA1A3C14663B8ACBDF8E074E98BBD965EA1969C8
    Set Test Variable    ${atmel_sn}    0123F61FCBFED2A0B1
    Set Test Variable    ${manufacture_date}    ${time}
    Set Test Variable    ${color_code}    IL
    Set Test Variable    ${state}    1
    Set Test Variable    ${es_state}    13
    Set Test Variable    ${ecu_mac}    rpNx83uY
    Set Test Variable    ${ecu_sn}    MABBQUFCBBIwABYzRQBkEA==
    Set Test Variable    ${ecu_status}    1
    Set Test Variable    ${keyfobs_id}    321
    Set Test Variable    ${keyfobs_mac}    rpNx83uY
    Set Test Variable    ${keyfobs_sn}    0123F61FCBFED2A0B1
    Set Test Variable    ${keyfobs_status}    1

Setup User Variables
    ${first_name} =    Generate Random String    5    [UPPER][NUMBERS]
    ${gogoro_guid} =    Generate Random UUID
    ${time} =    Evaluate    int(time.time())   time
    Set Test Variable    ${time}
    Set Test Variable    ${first_name}
    Set Test Variable    ${gogoro_guid}
    Set Test Variable    ${gender}    M
    Set Test Variable    ${email}    sw.verify+${time}@gogoro.com
    Set Test Variable    ${status}    1
    Set Test Variable    ${enable_e_carrier}    0

SuiteSetup
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${future_time} =    Evaluate    int(time.time() + 10)    time
    Set Suite Variable    ${company_code}    1300
    Set Suite Variable    ${current_timestamp}
    Set Suite Variable    ${future_time}

Update Addons To Es Contracts
    Create User
    Create Es Contracts
    Get Es Addons Id
    Es Contracts Update Addons    ${es_contract_id}    ${es_plan_Id}    2    1    ${es_addons_Id}    ${current_timestamp}    ${future_time}    ${current_timestamp}    1    0

Verify Es Contract Get With Invalid Payload
    [Arguments]    ${es_contract_id}    ${time_from}    ${time_to}    ${error_code}    ${error_message}
    ${resp} =    Es Contracts Addons Get    es_contract_id=${es_contract_id}    time_from=${time_from}    time_to=${time_to}
    Verify Status Code As Expected    ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${error_code}    ${error_message}