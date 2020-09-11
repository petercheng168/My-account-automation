*** Settings ***
Documentation    Test suite of gdk scooters
Resource    ../init.robot
Force Tags    Scooters-Maintenance
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
scooters-maintenances - get - get scooter by assembled_date successfully
    Setup For GDK Scooter Update
     ${update_resp} =    GDK Scooters Update
     ...    scooter_id=${Scooter_first.scooter_id}
     ...    assembled_date=${int_epoch_assembled_date}

    ${scooters_maintenances_get} =    Get Scooters By CS Portal
    ...    ${int_epoch_assembled_date}
    ...    ${int_epoch_assembled_date}

    Verify Status Code As Expected       ${scooters_maintenances_get}    200
    Verify Response Contains Expected    ${scooters_maintenances_get.json()['data'][0]['assembled_date']}    ${int_epoch_assembled_date}

scooters-maintenances - get - get scooter by assembled_date with invalid fields
    [Tags]    FET
    [Template]    Verify Scooters Maintenances Get Error
    402010006    invalid assembled_date_from     assembled_date_from=-1    assembled_date_to=0     account=${CIPHER_CS_PORTAL_ACCOUNT}    go_client=${GO_CLIENT_HEADER_CS_PORTAL}
    402010006    invalid assembled_date_to       assembled_date_from=0     assembled_date_to=-1    account=${CIPHER_CS_PORTAL_ACCOUNT}    go_client=${GO_CLIENT_HEADER_CS_PORTAL}
    402010000    no permission, access denied    assembled_date_from=0     assembled_date_to=0

scooters-maintenances - get - get scooter by assembled_date with invalid auth
    [Tags]    FET
    [Template]    Verify Scooters Maintenances Get Auth Error
    101010001    Invalid resource request, access reject    assembled_date_from=0    assembled_date_to=0    go_client=${GO_CLIENT_HEADER_CS_PORTAL}    cipher_app=dev          cipher_resource=dev

*** Keywords ***
# -------- Setup  Keywords --------
Create Scooter
    Set Test Variable    ${Scooter_first}     ${Scooters(1500, 'AZ2')}
    Set Test Variable    ${Scooter_second}    ${Scooters(1500, 'AZ2')}
    ${Scooter_first.scooter_id} =     Create Scooters    ${Scooter_first}
    ${Scooter_second.scooter_id} =    Create Scooters    ${Scooter_second}

Setup For GDK Scooter Update
    Create Scooter
    Setup Update Variable

Setup Update Variable
    ${update_plate} =                Generate Random String    24     [UPPER][NUMBERS]
    ${date} =                        Evaluate    time.strftime("%Y-%m-%d")    time
    ${epoch_update_plate_date} =     Convert Date    ${date}    epoch
    ${epoch_assembled_date} =        Convert Date    ${date}    epoch
    ${int_epoch_assembled_date} =    Convert To Integer    ${epoch_assembled_date}

    Set Test Variable    ${update_plate}
    Set Test Variable    ${epoch_update_plate_date}
    Set Test Variable    ${epoch_assembled_date}
    Set Test Variable    ${int_epoch_assembled_date}

# -------- Gogoro  Keywords --------
# -------- Verify  Keywords --------
Verify Scooters Maintenances Get Auth Error
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    scooters_maintenances_get_via_assembled_date   &{fields}
    Verify Status Code As Expected     ${resp}    401
    Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}

Verify Scooters Maintenances Get Error
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Scooters Maintenances Get Via Assembled Date     &{fields}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}

