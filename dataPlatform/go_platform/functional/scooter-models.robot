*** Settings ***
Documentation    API baseline of scooter-models

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GP_API_ROOT}/LibScootersModels.py

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_plans.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_scooter_model.robot

Force Tags      Scooter-Models
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
scooter-models - add - invalid - create scooter models with invalid required fields
    [Tags]    FET
    [Template]    Verify Scooter Model Post With Invalid Fields
    402010006     [addData[0].retailerFlag],1]; default message [must be less than or equal to 1]]       retailer_flag=2
    402010006     [addData[0].retailerFlag],0]; default message [must be greater than or equal to 0]]    retailer_flag=-1
    604040002     Unable to find the company using the brand company code                                retailer_flag=1     scooter_model_guid=${scooter_model_guid}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    brand_company_code=9999    status=0
    803010003     decode failed                                                                          retailer_flag=1     scooter_model_guid=${scooter_model_guid}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    brand_company_id=6066      status=0
    604040002     Unable to find the company using the brand company id                                  retailer_flag=1     scooter_model_guid=${scooter_model_guid}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    brand_company_id=Jm45ae5L  status=0


scooter-models - add - invalid - create scooter models with null required fields
    [Tags]    FET
    [Template]    Verify Scooter Model Post With Invalid Fields
    402010006    [addData[0].retailerFlag]]; default message [must not be null]]   retailer_flag=${None}    scooter_model_guid=${scooter_model_guid}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37
    402010003    scooter_model_guid must not be null or empty                      retailer_flag=1          scooter_model_guid=${None}                  category=AppFeatures    key=AppFeatureBits    value=0xFFFE37


scooter-models - add - valid - create scooter models with required fields
    ${resp_add} =    Scooters Models Add
    ...    retailer_flag=1         brand_company_code=${None}    scooter_model_guid=${scooter_model_guid}    marketing_name=test_model_name
    ...    category=AppFeatures    key=AppFeatureBits         value=0xFFFE37    status=1

    ${scooter_model_id} =    Set Variable             ${resp_add.json()['data'][0]['scooter_model_id']}
    ${resp_get} =            Scooters Models Get      ${scooter_model_id}    offset=0    limit=10
    keywords_common.Verify Status Code As Expected    ${resp_add}                                                     200
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['retailer_flag']}                  1
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['scooter_model_id']}               ${scooter_model_id}
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['scooter_model_guid']}             ${scooter_model_guid}
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['marketing_name']}                 test_model_name
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['sw_configurable_feature_bits']}   0xFFFE37
    Should not be empty                               ${resp_get.json()['data'][0]['brand_company_id']}

scooter-models - add - valid - create scooter models with required fields and all values in param can be set as n/a
    Setup Params
    ${resp_add} =    Scooters Models Add With Params
    ...    retailer_flag=1         brand_company_code=1300    scooter_model_guid=${scooter_model_guid}    marketing_name=test_model_name
    ...    params=${params}        status=1

    ${scooter_model_id} =    Set Variable             ${resp_add.json()['data'][0]['scooter_model_id']}
    ${resp_get} =            Scooters Models Get      ${scooter_model_id}    offset=0    limit=10
    keywords_common.Verify Status Code As Expected    ${resp_add}                                                     200
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['retailer_flag']}                  1
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['scooter_model_id']}               ${scooter_model_id}
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['scooter_model_guid']}             ${scooter_model_guid}
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['marketing_name']}                 test_model_name
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['sw_configurable_feature_bits']}   0xFFFE37 

scooter-models - udpate - invalid - update scooter models with invalid required fields
    [Tags]    FET
    [Template]    Verify Scooter Model Update With Invalid Fields
    402010006     [updateData[0].retailerFlag],1]; default message [must be less than or equal to 1]]       retailer_flag=2
    402010006     [updateData[0].retailerFlag],0]; default message [must be greater than or equal to 0]]    retailer_flag=-1
    604040002     The scooter model does not exist for id: 999999                                           retailer_flag=1     scooter_model_id=Jm45ae5L                   category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    brand_company_code=1300
    604040002     the scooter_model is not exist for guid                                                   retailer_flag=1     scooter_model_guid=${scooter_model_guid}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37
    604040002     Unable to find the company using the brand company code                                   retailer_flag=1     scooter_model_guid=${scooter_model_guid}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    brand_company_code=9999
    803010003     decode failed                                                                             retailer_flag=1     scooter_model_guid=${scooter_model_guid}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    brand_company_id=6066
    604040002     Unable to find the company using the brand company id                                     retailer_flag=1     scooter_model_guid=${scooter_model_guid}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    brand_company_id=Jm45ae5L


scooter-models - udpate - invalid - update scooter models with null required fields
    [Tags]    FET
    [Template]    Verify Scooter Model Update With Invalid Fields
    402010006    [updateData[0].retailerFlag]]; default message [must not be null]]
    402010003    scooter_model_guid or scooter_model_id must not be null or empty    retailer_flag=1    scooter_model_guid=${None}    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37


scooter-models - udpate - valid - update scooter models with required fields
    ${resp_add} =    Scooters Models Add
    ...    retailer_flag=1     brand_company_code=1300    scooter_model_guid=${scooter_model_guid}
    ...    marketing_name=test_model_name    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    status=0

    ${scooter_model_id} =    Set Variable             ${resp_add.json()['data'][0]['scooter_model_id']}
    ${resp_update} =         Scooters Models Update    scooter_model_id=${scooter_model_id}     brand_company_code=${None}    retailer_flag=0    marketing_name=name_updated    category=AppFeatures    key=AppFeatureBits    value=0xFFFE36
    keywords_common.Verify Status Code As Expected    ${resp_update}    200
    Verify Response Contains Expected                 ${resp_update.json()['code']}    0

    ${resp_get} =    Scooters Models Get     ${scooter_model_id}    offset=0    limit=10
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['retailer_flag']}     0
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['marketing_name']}    name_updated

scooter-models - udpate - valid - update scooter models with required fields and all values in param can be set as n/a
    Setup Params
    ${resp_add} =    Scooters Models Add
    ...    retailer_flag=1     brand_company_code=1300    scooter_model_guid=${scooter_model_guid}
    ...    marketing_name=test_model_name    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    status=0

    ${scooter_model_id} =    Set Variable             ${resp_add.json()['data'][0]['scooter_model_id']}
    ${resp_update} =         Scooters Models Update With Params    scooter_model_id=${scooter_model_id}     brand_company_code=${None}    retailer_flag=0    marketing_name=name_updated    params=${params}
    keywords_common.Verify Status Code As Expected    ${resp_update}    200
    Verify Response Contains Expected                 ${resp_update.json()['code']}    0

    ${resp_get} =    Scooters Models Get     ${scooter_model_id}    offset=0    limit=10
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['retailer_flag']}     0
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['marketing_name']}    name_updated


scooter-models - get - invalid - get scooter models with invalid required fields
    [Tags]    FET
    [Template]    Verify Scooter Model Get With Invalid Fields
    604040002    the scooter_model is not exist for guid   scooter_model_guid=11111111


scooter-models - get - valid - get scooter models with required fields
    ${resp_add} =    Scooters Models Add
    ...    retailer_flag=1     brand_company_code=1300    scooter_model_guid=${scooter_model_guid}
    ...    marketing_name=test_model_name    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    status=1

    ${resp_get} =    Scooters Models Get      scooter_model_id=${resp_add.json()['data'][0]['scooter_model_id']}
    keywords_common.Verify Status Code As Expected    ${resp_get}    200
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['retailer_flag']}                    1
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['sw_configurable_feature_bits']}     0xFFFE37
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     company_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     brand_company_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     updated_by_emp_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     update_time

scooter-models - get - valid - get scooter models by company group admin with required fields
    ${resp_add} =    Scooters Models Add
    ...    retailer_flag=1     brand_company_code=1300    scooter_model_guid=${scooter_model_guid}
    ...    marketing_name=test_model_name    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    status=1

    ${resp_get} =    Scooters Models Get      scooter_model_id=${resp_add.json()['data'][0]['scooter_model_id']}    account=${CIPHER_GROUP_ACCOUNT}
    keywords_common.Verify Status Code As Expected    ${resp_get}    200
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['retailer_flag']}                    1
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['sw_configurable_feature_bits']}     0xFFFE37
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     company_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     brand_company_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     updated_by_emp_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     update_time

scooter-models - get - valid - get scooter models with scooter_model_id and status
    ${resp_add} =    Scooters Models Add
    ...    retailer_flag=1     brand_company_code=1300    scooter_model_guid=${scooter_model_guid}
    ...    marketing_name=test_model_name    category=AppFeatures    key=AppFeatureBits    value=0xFFFE37    status=1

    ${resp_get} =    Scooters Models Get      scooter_model_id=${resp_add.json()['data'][0]['scooter_model_id']}    status=1
    keywords_common.Verify Status Code As Expected    ${resp_get}    200
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['retailer_flag']}                    1
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['sw_configurable_feature_bits']}     0xFFFE37
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     company_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     brand_company_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     updated_by_emp_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     update_time

    ${resp_get} =    Scooters Models Get      scooter_model_id=${resp_add.json()['data'][0]['scooter_model_id']}    status=0
    keywords_common.Verify Status Code As Expected    ${resp_get}    200
    Verify Response Contains Expected    ${resp_get.json()['total_count']}    0

scooter-models - get - valid - get scooter models with scooter_model_id and model_code_list
    Generate Model Code
    ${resp_add} =    Scooters Models Add
    ...    retailer_flag=1     brand_company_code=1300    scooter_model_guid=${scooter_model_guid}
    ...    marketing_name=test_model_name    key=Code    value=${model_code}    status=1

    ${model_code_list} =     Create List    ${model_code}
    ${resp_get} =    Scooters Models Get      model_code_list=${model_code_list}
    keywords_common.Verify Status Code As Expected    ${resp_get}    200
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['retailer_flag']}    1
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['model_code']}     ${model_code}
    Verify Response Contains Expected    ${resp_get.json()['data'][0]['scooter_model_guid']}     ${scooter_model_guid}
    Verify Response Contains Expected    ${resp_get.json()['total_count']}    1
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     company_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     brand_company_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     updated_by_emp_id
    Dictionary Should Contain Key        ${resp_get.json()['data'][0]}     update_time

    ${resp_get} =    Scooters Models Get      scooter_model_id=${resp_add.json()['data'][0]['scooter_model_id']}    status=0
    keywords_common.Verify Status Code As Expected    ${resp_get}    200
    Verify Response Contains Expected    ${resp_get.json()['total_count']}    0

*** Keywords ***
Verify Scooter Model Post With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Scooters Models Add     &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}


Verify Scooter Model Update With Invalid Fields
    [Arguments]    ${additional_code}      ${err_msg}    &{fields}
    ${resp} =    Scooters Models Update    &{fields}
	Verify Status Code As Expected         ${resp}    200
	Verify GoPlatform Error Message        ${resp}    ${additional_code}    ${err_msg}


Verify Scooter Model Get With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Scooters Models Get     &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Test Setup
    ${scooter_model_guid} =    Generate Random UUID
    Set Test Variable    ${scooter_model_guid}

Generate Model Code
    ${model_code} =    Generate Random String    16    [NUMBERS][LETTERS]
    Set Test Variable    ${model_code}
