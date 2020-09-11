*** Settings ***
Documentation    API baseline of scooters owners

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GP_API_ROOT}/LibScootersOwners.py

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot

Test Timeout      ${TEST_TIMEOUT}

*** Variable ***
@{empty_list}     
@{scooter_ids}    4Rgb6vaL
${scooter_id}     4Rgb6vaL


*** Test Case ***
scooter-owners - get - invalid - get scooter owners with invalid required fields
    [Tags]    FET
    [Template]    Verify Scooter Owner Get With Invalid Fields
    402010006    default message [getData.requestDataType]]; default message [must not be null]]   
    402010005    request data type should be 1 or 2                                                 request_data_type=3    scooter_ids=${scooter_ids}
    402010005    request data type should be 1 or 2                                                 request_data_type=0    scooter_ids=${scooter_ids}
    402010006    default message [getData.ownerIds],1000,1]                                         request_data_type=1    owner_ids=${empty_list}
    402010006    default message [getData.scooterIds],1000,1]                                       request_data_type=1    scooter_ids=${empty_list}
    402010006    default message [getData.scooterPlates],1000,1]                                    request_data_type=1    scooter_plates=${empty_list}
    402010006    default message [getData.scooterVins],1000,1]                                      request_data_type=1    scooter_vins=${empty_list}  
    402010006    default message [getData.scooterGuids],1000,1]                                     request_data_type=1    scooter_guids=${empty_list}


scooter-owners - get - valid - get scooter owners with invalid required fields
    ${resp_get} =    Scooters Owners Get      request_data_type=1    scooter_ids=${scooter_ids}
    keywords_common.Verify Status Code As Expected    ${resp_get}    200
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['scooter_id']}    ${scooter_id}
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     gender
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     invoice_address
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     invoice_district
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     invoice_city
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     invoice_zip


*** Keywords ***
Verify Scooter Owner Get With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Scooters Owners Get     &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}