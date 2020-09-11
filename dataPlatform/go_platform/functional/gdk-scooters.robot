*** Settings ***
Documentation    Test suite of gdk scooters
Resource    ../init.robot
Force Tags    GDK-Scooters
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
gdk-scooters - update - update scooter successfully
    [Setup]    Setup For GDK Scooter Update
    ${update_resp} =    GDK Scooters Update      scooter_id=${Scooter_first.scooter_id}  update_plate=${update_plate}  update_plate_date=${epoch_update_plate_date}

    Verify Status Code As Expected  ${update_resp}  200
    Verify Response Contains Expected    ${update_resp.json()['code']}    0

gdk-scooters - update - update scooter's assembled_date successfully
    Setup For GDK Scooter Update
    ${update_resp} =    GDK Scooters Update      scooter_id=${Scooter_first.scooter_id}  assembled_date=${int_epoch_assembled_date}

    Verify Status Code As Expected  ${update_resp}  200
    Verify Response Contains Expected    ${update_resp.json()['code']}    0

    ${scooters_maintenances_get_resp} =    Get Scooters By CS Portal    ${int_epoch_assembled_date}    ${int_epoch_assembled_date}
    Verify Status Code As Expected  ${scooters_maintenances_get_resp}  200
    Verify Response Contains Expected    ${scooters_maintenances_get_resp.json()['data'][0]['assembled_date']}    ${int_epoch_assembled_date}

gdk-scooters - update - update scooter error_list
    [Tags]    FET
    [Setup]   Setup For GDK Scooter Update
    [Template]    Verify GDK Scooters Update Error Message
    9    The update_plate_date must be provided when the update_plate be provided    scooter_id=${Scooter_first.scooter_id}  update_plate=${update_plate}
    3    Invalid input                                                               scooter_id=None
    3    Invalid input                                                               scooter_id=${EMPTY}
    1    Scooter vin is duplicate                                                    scooter_id=${Scooter_first.scooter_id}  vin=${Scooter_second.vin}
    10   The scooter model does not exist for the model_code                         scooter_id=${Scooter_first.scooter_id}  vin=${Scooter_second.vin}  model_code=abc

gdk-scooters - update - update scooter error
    [Tags]    FET
    [Setup]   Setup For GDK Scooter Update
    [Template]    Verify GDK Scooters Update Swagger Error
    402010006    size must be between 0 and 4                scooter_id=${Scooter_first.scooter_id}  color_code=AAAAA
    402010006    must be greater than or equal to 0          scooter_id=${Scooter_first.scooter_id}  update_plate=${update_plate}  update_plate_date=-1
    402010006    must be greater than or equal to 0          scooter_id=${Scooter_first.scooter_id}  manufacture_time=-1
    402010006    must be greater than or equal to 0          scooter_id=${Scooter_first.scooter_id}  tpms=-1
    402010006    must be less than or equal to 1             scooter_id=${Scooter_first.scooter_id}  tpms=2
    402010006    must be greater than or equal to 0          scooter_id=${Scooter_first.scooter_id}  assist_light=-1
    402010006    must be less than or equal to 1             scooter_id=${Scooter_first.scooter_id}  assist_light=2
    402010006    must be greater than or equal to 0          scooter_id=${Scooter_first.scooter_id}  onboard_charger=-1
    402010006    must be less than or equal to 1             scooter_id=${Scooter_first.scooter_id}  onboard_charger=2
    402010006    size must be between 0 and 16               scooter_id=${Scooter_first.scooter_id}  model_code=12345678901234567

*** Keywords ***
Create Scooter
    Set Test Variable    ${Scooter_first}     ${Scooters(1500, 'AZ2')}
    Set Test Variable    ${Scooter_second}    ${Scooters(1500, 'AZ2')}
    ${Scooter_first.scooter_id} =     Create Scooters    ${Scooter_first}
    ${Scooter_second.scooter_id} =    Create Scooters    ${Scooter_second}

Setup For GDK Scooter Update
    Create Scooter
    Setup Update Variable

Setup Update Variable
    ${date} =                        Evaluate    time.strftime("%Y-%m-%d")    time
    ${update_plate} =                Generate Random String    24     [UPPER][NUMBERS]
    ${epoch_update_plate_date} =     Convert Date    ${date}    epoch
    ${epoch_assembled_date} =        Convert Date    ${date}    epoch
    ${int_epoch_assembled_date} =    Convert To Integer    ${epoch_assembled_date}

    Set Test Variable    ${update_plate}
    Set Test Variable    ${epoch_update_plate_date}
    Set Test Variable    ${epoch_assembled_date}
    Set Test Variable    ${int_epoch_assembled_date}

Verify GDK Scooters Update Error Message
    [Arguments]    ${error_code}    ${err_msg}=${None}    &{fields}
    ${resp} =    GDK Scooters Update    &{fields}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['code']}       ${error_code}
    Should Contain                       ${resp.json()['error_list'][0]['message']}    ${err_msg}

Verify GDK Scooters Update Swagger Error
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    GDK Scooters Update    &{fields}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}

