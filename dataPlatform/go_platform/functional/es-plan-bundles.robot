*** Settings ***
Documentation    API baseline of es-plan-bundles

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GP_API_ROOT}/LibEsAddons.py
Library           ${GP_API_ROOT}/LibEsPlans.py
Library           ${GP_API_ROOT}/LibPromotions.py
Library           ${GP_API_ROOT}/LibEsPlanBundles.py
Library           Collections

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_contracts_addons.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_promotions.robot

Force Tags      Es-Plan-Bundles
Suite Setup     Suite Setup
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-plan-bundle - add - invalid - create es_plan_bundle with invalid required fields
    [Tags]    FET
    [Template]   Verify Es Plan Bundle Create With Invalid Fields
    803010003   decode failed                                                                            es_plan_id='1'             es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1
    402010001   Cannot deserialize                                                                       es_plan_id=${es_plan_id}   es_plan_bundle='1'              apply_bundle_at_selection=1
    402010006   [addData.applyBundleAtSelection],1]; default message [must be less than or equal to 1]   es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=2

es-plan-bundle - add - invalid - create es_plan_bundle with null required fields
    [Tags]    FET
    [Template]   Verify Es Plan Bundle Create With Invalid Fields
    402010006    [addData.esPlanId]]; default message [must not be null]                 es_plan_id=${None}         es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1
    402010003    plan_bundle must not be null or empty                                   es_plan_id=${es_plan_id}   es_plan_bundle=${None}          apply_bundle_at_selection=1
    402010006    [addData.applyBundleAtSelection]]; default message [must not be null]   es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=${None}

es-plan-bundle - add - valid - create es_plan_bundle with correct fields
    ${resp} =    Es Plan Bundle Add
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1
    ...  valid_from=123   valid_to=456

    ${resp_get} =    Es Plan Bundle Get
    ...  es_plan_id=${es_plan_id}

    Verify Status Code As Expected        ${resp}    200
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['es_plan_id']}	${es_plan_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_id']}	${promotion_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['apply_bundle_at_selection']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_from']}	123
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_to']}	456

    Verify Response Contains Expected     ${resp_get.json()['data'][1]['es_plan_id']}	${es_plan_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['bundle_type']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['bundle_id']}	${addon_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['apply_bundle_at_selection']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['valid_from']}	123
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['valid_to']}	456

es-plan-bundle - add - valid - create es_plan_bundle with required fields
    ${promotion_bundle}=    Create Dictionary    bundle_type=1    bundle_id=${promotion_id}
    ${addon_bundle}=        Create Dictionary    bundle_type=2    bundle_id=${addon_id}
    ${bundle_list}=         Create List          ${promotion_bundle}       ${addon_bundle}

    ${resp} =    Es Plan Bundle Add
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1

    ${resp_get} =    Es Plan Bundle Get
    ...  es_plan_id=${es_plan_id}

    Verify Status Code As Expected        ${resp}    200
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['es_plan_id']}	${es_plan_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_id']}	${promotion_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['apply_bundle_at_selection']}	1
    Dictionary Should Contain Key         ${resp_get.json()['data'][0]}    valid_from

    Verify Response Contains Expected     ${resp_get.json()['data'][1]['es_plan_id']}	${es_plan_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['bundle_type']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['bundle_id']}	${addon_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['apply_bundle_at_selection']}	1
    Dictionary Should Contain Key         ${resp_get.json()['data'][1]}    valid_from

es-plan-bundle - update - invalid - update es_plan_bundle with invalid required fields
    [Tags]    FET
    [Template]   Verify Es Plan Bundle Update With Invalid Fields
    803010003   decode failed                                                                               es_plan_id='1'             es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1
    402010001   Cannot deserialize                                                                          es_plan_id=${es_plan_id}   es_plan_bundle='1'              apply_bundle_at_selection=1
    402010006   [updateData.applyBundleAtSelection],1]; default message [must be less than or equal to 1]   es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=2


es-plan-bundle - update - invalid - update es_plan_bundle with null required fields
    [Tags]    FET
    [Template]   Verify Es Plan Bundle Update With Invalid Fields
    402010006    [updateData.esPlanId]]; default message [must not be null]                 es_plan_id=${None}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1
    402010006    [updateData.applyBundleAtSelection]]; default message [must not be null]   es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=${None}


es-plan-bundle - update - valid - update es_plan_bundle with correct fields
    ${promotion_bundle}=    Create Dictionary    bundle_type=1    bundle_id=${promotion_id}
    ${addon_bundle}=        Create Dictionary    bundle_type=2    bundle_id=${addon_id}
    ${bundle_list}=         Create List          ${promotion_bundle}       ${addon_bundle}
    ${bundle_list_one_item}=         Create List          ${addon_bundle}

    ${resp_create} =    Es Plan Bundle Add
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1

    ${resp_update} =    Es Plan Bundle Update
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list_one_item}   apply_bundle_at_selection=0
    ...  valid_from=123   valid_to=456

    ${resp_get} =    Es Plan Bundle Get
    ...  es_plan_id=${es_plan_id}

    Verify Status Code As Expected        ${resp_get}    200
    Verify Response Data Length Expected  ${resp_get.json()['data']}   1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['es_plan_id']}	${es_plan_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_type']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_id']}	${addon_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['apply_bundle_at_selection']}	0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_from']}	123
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_to']}	456

es-plan-bundle - update - valid - update es_plan_bundle with required fields
    ${promotion_bundle}=    Create Dictionary    bundle_type=1    bundle_id=${promotion_id}
    ${addon_bundle}=        Create Dictionary    bundle_type=2    bundle_id=${addon_id}
    ${bundle_list}=         Create List          ${promotion_bundle}       ${addon_bundle}
    ${bundle_list_one_item}=         Create List          ${promotion_bundle}

    ${resp_create} =    Es Plan Bundle Add
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1

    ${resp_update} =    Es Plan Bundle Update
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${None}   apply_bundle_at_selection=0

    ${resp_get} =    Es Plan Bundle Get
    ...  es_plan_id=${es_plan_id}

    Verify Status Code As Expected        ${resp_create}    200
    Verify Status Code As Expected        ${resp_update}    200
    Verify Status Code As Expected        ${resp_get}    200
    Verify Response Data Length Expected  ${resp_get.json()['data']}   0

    ${resp_create} =    Es Plan Bundle Add
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1

    ${resp_update} =    Es Plan Bundle Update
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list_one_item}   apply_bundle_at_selection=0

    ${resp_get} =    Es Plan Bundle Get
    ...  es_plan_id=${es_plan_id}

    Verify Status Code As Expected        ${resp_create}    200
    Verify Status Code As Expected        ${resp_update}    200
    Verify Status Code As Expected        ${resp_get}    200
    Verify Response Data Length Expected  ${resp_get.json()['data']}   1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['es_plan_id']}	${es_plan_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_id']}	${promotion_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['apply_bundle_at_selection']}	0

# Get
es-plan-bundle - get - invalid - get es_plan_bundle with invalid required fields
    [Tags]  FET
    [Template]   Verify Es Plan Bundle Get With Invalid Fields
    803010003   decode failed    es_plan_id='1'

es-plan-bundle - get - invalid - get es_plan_bundle with null required fields
    [Tags]  FET
    [Template]   Verify Es Plan Bundle Get With Invalid Fields
    402010006   [getData.esPlanId]]; default message [must not be null]    es_plan_id=${None}

#es-plan-bundle - get - valid - get es_plan_bundle with correct fields
    # TODO The valid time cannnot be tested if the data set is not provided

es-plan-bundle - get - valid - get es_plan_bundle with required fields
    ${promotion_bundle}=    Create Dictionary    bundle_type=1    bundle_id=${promotion_id}
    ${addon_bundle}=        Create Dictionary    bundle_type=2    bundle_id=${addon_id}
    ${bundle_list}=         Create List          ${promotion_bundle}       ${addon_bundle}

    ${resp_create} =    Es Plan Bundle Add
    ...  es_plan_id=${es_plan_id}   es_plan_bundle=${bundle_list}   apply_bundle_at_selection=1

    ${resp_get} =    Es Plan Bundle Get
    ...  es_plan_id=${es_plan_id}

    Verify Response Contains Expected     ${resp_get.json()['data'][0]['es_plan_id']}	${es_plan_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['bundle_id']}	${promotion_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['apply_bundle_at_selection']}	1
    Dictionary Should Contain Key         ${resp_get.json()['data'][0]}    valid_from

    Verify Response Contains Expected     ${resp_get.json()['data'][1]['es_plan_id']}	${es_plan_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['bundle_type']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['bundle_id']}	${addon_id}
    Verify Response Contains Expected     ${resp_get.json()['data'][1]['apply_bundle_at_selection']}	1
    Dictionary Should Contain Key         ${resp_get.json()['data'][1]}    valid_from


*** Keywords ***
Suite Setup
    ${promotion_id}=  Get Promotion Id Via Promotion Code   ESB001
    ${addon_id} =    Get Addon Id Via Addon Code   SUBFEE-00002

    ${promotion_bundle}=    Create Dictionary    bundle_type=1    bundle_id=${promotion_id}
    ${addon_bundle}=        Create Dictionary    bundle_type=2    bundle_id=${addon_id}
    ${bundle_list}=         Create List          ${promotion_bundle}       ${addon_bundle}

    Set Suite Variable    ${promotion_id}
    Set Suite Variable    ${addon_id}
    Set Suite Variable    ${bundle_list}

Test Setup
    ${es_plan_id} =    Create Es Plan
    Set Test Variable    ${es_plan_id}

Create Es Plan
    ${resp_es_plan} =    Es Plans Post
    ...    plan_name=BundleTest      country_code=TW    	  payment_freq=1           plan_price=599
    ...    plan_target=1    		 unit_base=1              unit_threshold=100       over_unit_price=100
    ...    unit_threshold_1=100      over_unit_price_1=100    valid_time_from=0        status=0
    ...    published=0        	     plan_price_reward=1      plan_price_usage=1

    [Return]  ${resp_es_plan.json()['data'][0]['plan_id']}

Verify Es Plan Bundle Create With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =   Es Plan Bundle Add   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Es Plan Bundle Update With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =   Es Plan Bundle Update   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Es Plan Bundle Get With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =   Es Plan Bundle Get   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}