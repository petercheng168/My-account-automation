*** Settings ***
Documentation    API baseline of es-plans

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GP_API_ROOT}/LibEsPlans.py

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_plans.robot

Force Tags      Es-Contracts    Es-Plans
Suite Setup     Suite Setup
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-plans - add - invalid - create es_plan with invalid required fields
    [Tags]    FET
    [Template]    Verify Es Plan Post With Invalid Fields
    402010006    [must be less than or equal to 100000]     plan_name=${plan_name}  country_code=TW  payment_freq=1  plan_price=599  plan_target=1  unit_base=1  unit_threshold=100001  over_unit_price=100  	 unit_threshold_1=100  over_unit_price_1=100  valid_time_from=0  status=0  published=0  plan_price_reward=1  plan_price_usage=1
    402010006    [must be greater than or equal to 0]       plan_name=${plan_name}  country_code=TW  payment_freq=1  plan_price=599  plan_target=1  unit_base=1  unit_threshold=-1      over_unit_price=100  	 unit_threshold_1=100  over_unit_price_1=100  valid_time_from=0  status=0  published=0  plan_price_reward=1  plan_price_usage=1
    402010006    [must be less than or equal to 1000000]    plan_name=${plan_name}  country_code=TW  payment_freq=1  plan_price=599  plan_target=1  unit_base=1  unit_threshold=1  		over_unit_price=1000001  unit_threshold_1=100  over_unit_price_1=100  valid_time_from=0  status=0  published=0  plan_price_reward=1  plan_price_usage=1
    402010006    [must be greater than or equal to 0]       plan_name=${plan_name}  country_code=TW  payment_freq=1  plan_price=599  plan_target=1  unit_base=1  unit_threshold=1  		over_unit_price=-1  	 unit_threshold_1=100  over_unit_price_1=100  valid_time_from=0  status=0  published=0  plan_price_reward=1  plan_price_usage=1
    402010006    [must be less than or equal to 1]]         plan_name=${plan_name}  country_code=TW  payment_freq=1  plan_price=599  plan_target=1  unit_base=1  unit_threshold=1  		over_unit_price=100  	 unit_threshold_1=100  over_unit_price_1=100  valid_time_from=0  status=0  published=0  plan_price_reward=1  plan_price_usage=1    include_free_regular_maintenance=2

es-plans - add - invalid - create es_plan with null required fields
	[Tags]    FET
	[Template]    Verify Es Plan Post With Invalid Fields
	402010006    [addData[0].planName]]; default message [must not be null]]       plan_name=${None}        country_code=TW   	  payment_freq=1        plan_price=599      plan_target=1        unit_base=1         unit_threshold=100         over_unit_price=100      unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010006    [addData[0].countryCode]]; default message [must not be null]]    plan_name=${plan_name}   country_code=${None}  payment_freq=1        plan_price=599      plan_target=1        unit_base=1         unit_threshold=100         over_unit_price=100      unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
    402010003    Payment_freq must not be null    								   plan_name=${plan_name}   country_code=TW   	  payment_freq=${None}  plan_price=599      plan_target=1        unit_base=1         unit_threshold=100         over_unit_price=100      unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010003    Plan_price must not be null    								   plan_name=${plan_name}   country_code=TW   	  payment_freq=1        plan_price=${None}  plan_target=1        unit_base=1         unit_threshold=100         over_unit_price=100      unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010006    [addData[0].planTarget]]; default message [must not be null]]     plan_name=${plan_name}   country_code=TW   	  payment_freq=1        plan_price=599  	plan_target=${None}  unit_base=1         unit_threshold=100         over_unit_price=100      unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010003    Unit_base must not be null     								   plan_name=${plan_name}   country_code=TW   	  payment_freq=1        plan_price=599  	plan_target=1        unit_base=${None}   unit_threshold=100         over_unit_price=100      unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010003    Unit_threshold1 price must not be null     					   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=${None}  	over_unit_price=100      unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010003    Over_unit_price must not be null     							   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=100  		over_unit_price=${None}  unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010003    Unit_threshold1 price must not be null     					   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=100  		over_unit_price=100  	 unit_threshold_1=${None}  over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010003    Over_unit_price1 must not be null     							   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=100  		over_unit_price=100  	 unit_threshold_1=100      over_unit_price_1=${None}  valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010006    valid_time_from is invalid     								   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=100  		over_unit_price=100  	 unit_threshold_1=100      over_unit_price_1=100      valid_time_from=${None}  status=0        published=0        plan_price_reward=1        plan_price_usage=1
	402010003    Status must not be null     									   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=100  		over_unit_price=100  	 unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=${None}  published=0        plan_price_reward=1        plan_price_usage=1
	402010003    Published must not be null     								   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=100  		over_unit_price=100  	 unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=${None}  plan_price_reward=1        plan_price_usage=1
	402010003    plan_price_reward must not be null     						   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=100  		over_unit_price=100  	 unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=${None}  plan_price_usage=1
	402010003    plan_price_usage must not be null     							   plan_name=${plan_name}   country_code=TW   	  payment_freq=1  		plan_price=599  	plan_target=1        unit_base=1         unit_threshold=100  		over_unit_price=100  	 unit_threshold_1=100      over_unit_price_1=100      valid_time_from=0        status=0        published=0        plan_price_reward=1        plan_price_usage=${None}

es-plans - add - valid - create es_plan with required fields
	${resp} =    Es Plans Post
    ...    plan_name=${plan_name}    country_code=TW    	  payment_freq=1           plan_price=599
    ...    plan_target=1    		 unit_base=1              unit_threshold=100       over_unit_price=100
    ...    unit_threshold_1=100      over_unit_price_1=100    valid_time_from=0        status=0
	...    published=0        	     plan_price_reward=1      plan_price_usage=1
    ${resp_get} =    Es Plans Get    plan_id=${resp.json()['data'][0]['plan_id']}
	Verify Status Code As Expected         ${resp}                        				200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}      				plan_id
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['plan_name']}	${plan_name}

es-plans - add - valid - create es_plan with correct value
	[Template]   Verify Es Plan Post With Valid Fields
	plan_terms=36    				      include_free_regular_maintenance=0
	valid_time_to=${furture_timestamp}    include_free_regular_maintenance=0

*** Keywords ***
Suite Setup
	${timestamp} =    Evaluate    int(time.time())   time
	${furture_timestamp} =    Evaluate    int(time.time() + 86400)   time
	Set Suite Variable    ${timestamp}
	Set Suite Variable    ${furture_timestamp}

Test Setup
	${plan_name} =     Generate Random String    5    [UPPER]
	Set Test Variable    ${plan_name}    SWQA_${plan_name}

Verify Es Plan Post With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Es Plans Post    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Es Plan Post With Valid Fields
    [Arguments]    &{fields}
    ${resp} =    Es Plans Post
    ...    plan_name=${plan_name}    country_code=TW    	  payment_freq=1        plan_price=599
    ...    plan_target=1    		 unit_base=1              unit_threshold=100    over_unit_price=100
    ...    unit_threshold_1=100      over_unit_price_1=100    valid_time_from=0     status=0
	...    published=0        	     plan_price_reward=1      plan_price_usage=1
	...    &{fields}
	${resp_get} =    Es Plans Get    plan_id=${resp.json()['data'][0]['plan_id']}
    Verify Status Code As Expected         ${resp}                        				200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}      				plan_id
	Verify Response Contains Expected      ${resp_get.json()['data'][0]['plan_name']}	${plan_name}