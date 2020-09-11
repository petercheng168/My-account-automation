*** Settings ***
Documentation    Test suite of parts categories

Library      ../api/LibPartsCategories.py

Resource     ../init.robot

Suite Setup     Suite Setup
Force Tags      Parts    Parts-Categories
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
parts-categories - add - invalid - create parts_categories with invalid required fields
    [Tags]    FET    parts_categories_001
    [Template]    Verify Part Category Post With Invalid Fields
    40    type must be in 1 2 3 4                               category_type=0    sub_type=1    names=${name_list}
    40    addData[0].type must be less than or equal to 4       category_type=5    sub_type=1    names=${name_list}
    40    Invalid Input, Cannot deserialize instance            category_type=1    sub_type=1    names=not a json

parts-categories - add - invalid - create parts_categories with null required fields
    [Tags]    FET
    [Template]    Verify Part Category Post With Invalid Fields
    40    addData[0].subType must not be null     category_type=1    names=${name_list}
    40    addData[0].type must not be null        sub_type=1         names=${name_list}
    40    addData[0].nameList must not be null    category_type=1    sub_type=1

parts-categories - add - valid - create parts_categories with required fields
    ${resp_get}    Parts Categories Get    part_category_id_list=${add_part_category_id}
    keywords_common.Verify Status Code As Expected    ${add_resp}                                          200
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['part_category_id']}    ${add_part_category_id}
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['name']}                ${add_category_en_name}

parts-categories - update - invalid - create parts_categories with invalid required fields
    [Tags]    FET
    [Template]    Verify Part Category Update With Invalid Fields
    60    in_parts_category_id must not be null    category_type=0    sub_type=1    names=${name_list}

parts-categories - update - valid - update parts_categories with required fields
    ${dict_name_en_update} =     Create Dictionary          lang=en-US         value=updated_en_name
    ${name_list} =      Create List                ${dict_name_en_update}
    ${resp_get} =       Parts Categories Get       part_category_id_list=${add_part_category_id}
    ${resp_update} =    Parts Categories Update    part_category_id=${add_part_category_id}    sub_type=${resp_get.json()['data'][0]['sub_type']+1}    names=${name_list}
    ${resp_get_after_update} =    Parts Categories Get       part_category_id_list=${add_part_category_id}
    Verify Response Contains Expected    ${resp_get_after_update.json()['data'][0]['name']}          updated_en_name
    Verify Response Contains Expected    ${resp_get_after_update.json()['data'][0]['sub_type']}      ${resp_get.json()['data'][0]['sub_type']+1}

parts-categories - get - invalid - get parts_categories with invalid required fields
    [Tags]    FET    parts_categories_002
    [Template]    Verify Part Category Get With Invalid Fields
    40    must provide at least one query criteria
    60    Unable to find the parts category with the specified parts category id      part_category_id_list=kLEk3aN8
    40    getData.type must be greater than or equal to 1                                    category_type=0
    40    getData.subType must be greater than or equal to 0                          sub_type=-1
    40    must provide at least one query criteria                                    language_code=en-US
    60    invalid language code                                                       category_type=1                   language_code=NN

parts-categories - get - valid - get parts_categories with valid required fields
    ${resp_get} =    Parts Categories Get    part_category_id_list=${add_part_category_id}     language_code=en-US
    keywords_common.Verify Status Code As Expected    ${resp_get}    200
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['part_category_id']}    ${add_part_category_id}
    Verify Response Contains Expected                 ${resp_get.json()['data'][0]['name']}    updated_en_name
    Verify Response Should Contains Key               ${resp_get.json()['data'][0]}    type
    Verify Response Should Contains Key               ${resp_get.json()['data'][0]}    sub_type
    Verify Response Should Contains Key               ${resp_get.json()['data'][0]}    create_time


*** Keywords ***
Suite Setup
    [Documentation]    Since Parts Categories type and sub_type is unique, and sub_type's range is 65536.
    ...                In case sub_type will be duplicated someday,
    ...                here we add a new parts category in suite setup, and reuse this part category record in all test cases.
    Set Suite Variable    ${add_category_en_name}    en_name
    ${dict_name_en} =     Create Dictionary          lang=en-US         value=${add_category_en_name}
    ${dict_name_tw} =     Create Dictionary          lang=zh-TW         value=料件
    ${name_list} =        Create List                ${dict_name_en}    ${dict_name_tw}
    Set Suite Variable    ${name_list}
    Set Suite Variable    ${PartsCategories}         ${PartsCategories(${name_list})}
    ${add_resp} =         Parts Categories Add       ${PartsCategories.type}             ${PartsCategories.sub_type}    ${PartsCategories.names}
    Set Suite Variable    ${add_resp}
    Set Suite Variable    ${add_part_category_id}    ${add_resp.json()['data'][0]['part_category_id']}


Verify Part Category Post With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Parts Categories Add    &{fields}
    Verify Status Code As Expected       ${resp}       200
    Verify GoPlatform Error Message      ${resp}       ${additional_code}    ${err_msg}


Verify Part Category Update With Invalid Fields
    [Arguments]    ${additional_code}       ${err_msg}    &{fields}
    ${resp} =    Parts Categories Update    &{fields}
    Verify Status Code As Expected       ${resp}       200
    Verify GoPlatform Error Message      ${resp}       ${additional_code}    ${err_msg}


Verify Part Category Get With Invalid Fields
    [Arguments]    ${additional_code}       ${err_msg}    &{fields}
    ${resp} =    Parts Categories Get    &{fields}
    Verify Status Code As Expected       ${resp}       200
    Verify GoPlatform Error Message      ${resp}       ${additional_code}    ${err_msg}