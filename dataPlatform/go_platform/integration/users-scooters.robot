*** Settings ***
Documentation    Test suite of users scooters
Resource    ../init.robot

Force Tags    Users
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
users-scooters - get - get user all scooter
    [Setup]    Deliver Multiple Scooters To User    3
    ${resp} =    Users Scooters Get    ${user_Id}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['scooter_id']}    ${scooter0}
    Verify Response Contains Expected    ${resp.json()['data'][1]['scooter_id']}    ${scooter1}
    Verify Response Contains Expected    ${resp.json()['data'][2]['scooter_id']}    ${scooter2}
    Verify Schema    users-scooters.json    userScootersGet    ${resp.json()}

*** Keywords ***
Create User
    Setup User Variables
    ${resp} =    Users Post    ${company_code}    ${first_name}    ${gender}    ${email}    ${status}    ${enable_e_carrier}    gogoro_guid=${gogoro_guid}
    Set Test Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}

Deliver Multiple Scooters To User
    [Arguments]    ${count}
    Create User
    FOR    ${index}    IN RANGE    ${count}
        Deliver Scooter To User    ${index}
    END

Deliver Scooter To User
    [Arguments]    ${index}
    Setup Scooter Variables
    Setup Order Variables
    ${scooters_resp} =    Scooters Post    1300    TW    ${scooter_vin}    ${scooter_guid}    ${matnr}    ${atmel_key}    ${state}    ${es_state}    ${ecu_status}    ${keyfobs_status}    keyfobs_id=${keyfobs_id}
    ${order_resp} =       Orders Post     VEH_SALE_CR    ${order_number}    I    ${user_Id}    30001
    ${es_plan_resp} =     Get All Es Plans    1    1    0    ${current_timestamp}
    Set Test Variable    ${scooter_Id}         ${scooters_resp.json()['data'][0]['scooter_id']}
    Set Test Variable    ${scooter${index}}    ${scooter_Id}
    Set Test Variable    ${order_Id}           ${order_resp.json()['data'][0]['order_id']}
    Set Test Variable    ${owner_Id}           ${order_resp.json()['data'][0]['owner_id']}
    Set Test Variable    ${es_plan_Id}         ${es_plan_resp.json()['data'][0]['plan_id']}
    ${es_contract_resp} =    Es Contracts Post    ${order_Id}    ${user_Id}    1    ${owner_Id}    1    ${owner_Id}    ${es_plan_Id}    ${current_timestamp}    1    1    2
    Set Test Variable    ${es_contract_Id}    ${es_contract_resp.json()['data'][0]['es_contract_id']}
    Scooters Infos Update    ${order_number}    ${scooter_vin}    ${user_Id}    ${owner_Id}    ${gogoro_guid}    0    turn_light=1    brake_light=1    tpms=0    sport_mode=0

Setup Order Variables
    ${order_number} =    Generate Random String    8    [NUMBERS]
    Set Test Variable    ${order_number}    P0${order_number}

Setup Scooter Variables
    ${scooter_vin} =    Generate Random String    7    [UPPER][NUMBERS]
    ${scooter_guid} =    Generate Random UUID
    ${time} =    Evaluate    time.strftime("%Y%m%d%s")    time
    Set Test Variable    ${time}
    Set Test Variable    ${scooter_vin}    PINJMETERJ${scooter_vin}
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
    Set Suite Variable    ${company_code}    1300
    Set Suite Variable    ${current_timestamp}