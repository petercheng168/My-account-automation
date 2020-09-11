*** Settings ***
Documentation    Test suite of scooter
Resource    ../init.robot

Force Tags    Scooters
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Create scooter with required field
    [Setup]    TestSetupForCreateScooterVariable
    ${resp} =    Scooters Post    1300    TW    ${scooter_vin}    ${scooter_guid}    ${matnr}    ${atmel_key}    ${state}    ${es_state}    ${ecu_status}    ${keyfobs_status}    keyfobs_id=${keyfobs_id}
    Verify Scooter Is Existing    ${resp.json()['data'][0]['scooter_id']}    general

Get scooter information with default fields type
    [Setup]    Create Scooter
    ${resp} =    Get Scooter Info    ${scooterId}    default
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['scooter_id']}    ${scooterId}
    Verify Schema    scooters.json    scooterGetDefault    ${resp.json()}

Get scooter information with general fields type
    [Setup]    Create Scooter
    ${resp} =    Get Scooter Info    ${scooterId}    general
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data'][0]['scooter_id']}    ${scooterId}
    Verify Schema    scooters.json    scooterGetGeneral    ${resp.json()}

*** Keywords ***
Create Scooter
    TestSetupForCreateScooterVariable
    ${resp} =    Scooters Post    1300    TW    ${scooter_vin}    ${scooter_guid}    ${matnr}    ${atmel_key}    ${state}    ${es_state}    ${ecu_status}    ${keyfobs_status}    keyfobs_id=${keyfobs_id}
    Set Test Variable    ${scooterId}    ${resp.json()['data'][0]['scooter_id']}

SuiteSetup
    ${time} =    Evaluate    time.strftime("%Y-%m-%d")    time
    Set Suite Variable    ${time}

TestSetupForCreateScooterVariable
    ${scooter_vin} =    Generate Random String    7    [UPPER][NUMBERS]
    ${scooter_guid} =    Generate Random UUID
    Set Test Variable    ${scooter_vin}
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