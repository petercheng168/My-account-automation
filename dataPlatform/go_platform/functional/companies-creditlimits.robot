*** Settings ***
Documentation    API baseline of companies credit-limits

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GP_API_ROOT}/LibCompaniesCreditLimits.py

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot

Force Tags      Companies
Suite Setup     Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variable ***
${CREDIT_LIMITS_ADD_OR_UPDATE_DATA_DICT_TEMPLATE}=        
...     {
...          "company_code": "1500",
...          "parts_limit": ${1},
...          "scooter_limit": ${1},
...          "customer_care_limit": ${1},
...          "currency": "TWD"
...     }

*** Test Cases ***
companies-creditlimits - add - valid create companies creditlimits
    ${resp} =   Companies Creditlimits Post
    ...     company_code=1500               parts_limit=101.00      scooter_limit=201.00
    ...     customer_care_limit=301.00      currency=TWD
    Verify Status Code As Expected      ${resp}                     200
    Should Be Equal As Numbers          ${resp.json()['code']}      0

companies-creditlimits - add - invalid create companies creditlimits
    [Tags]  FET
    ${resp} =   Companies Creditlimits Post
    ...     company_code=1500    parts_limit=101.00  scooter_limit=201.00
    ...     customer_care_limit=301.00    currency=TW
    Verify Status Code As Expected         ${resp}      200
    Should Be Equal As Numbers       ${resp.json()['code']}    -1
    Should Be Equal As Strings       ${resp.json()['error_list'][0]['key']}  1500
    Should Be Equal As Strings       ${resp.json()['error_list'][0]['message']}  ERROR: Unable to find the specified currency code: TW

companies-creditlimits - add - create companies creditlimits with multiple add data (partial add)
    [Tags]  FET
    Add Or Update Data List Setup
    ${resp} =    Companies Creditlimits Post Batch    ${add_or_update_data_list}

    Should Be Equal As Numbers       ${resp.json()["code"]}      -1
    Should Be Equal As Strings       ${resp.json()['error_list'][0]["key"]}    ${add_or_update_data_list[1]["company_code"]}

companies-creditlimits - update - update companies creditlimits with multiple update data (partial update)
    [Tags]  FET
    Add Or Update Data List Setup
    ${resp} =    Companies Creditlimits Post Batch    ${add_or_update_data_list}

    Should Be Equal As Numbers       ${resp.json()["code"]}      -1
    Should Be Equal As Strings       ${resp.json()['error_list'][0]["key"]}    ${add_or_update_data_list[1]["company_code"]}

companies-creditlimits - update - valid update companies creditlimits
    ${resp} =   Companies Creditlimits Update
    ...     company_code=1500    parts_limit=101000.00  scooter_limit=201000.00
    ...     customer_care_limit=301000.00    currency=USD
    Verify Status Code As Expected         ${resp}      200
    Should Be Equal As Numbers      ${resp.json()['code']}    0

companies-creditlimits - update - invalid update companies creditlimits
    [Tags]  FET
    ${resp} =   Companies Creditlimits Update
    ...     company_code=1500    parts_limit=101000.00  scooter_limit=201000.00
    ...     customer_care_limit=301000.00    currency=US
    Verify Status Code As Expected   ${resp}                                        200
    Should Be Equal As Numbers       ${resp.json()['code']}                         -1
    Should Be Equal As Strings       ${resp.json()['error_list'][0]['key']}         1500
    Should Be Equal As Strings       ${resp.json()['error_list'][0]['message']}     ERROR: Unable to find the specified currency code: US

companies-creditlimits - add - create companies creditlimits with null required fields
    [Tags]  FET
    [Template]   Verify Companies Creditlimits Create With Invalid Fields
    company_code must not be null                           company_code=${None}      parts_limit=101.00      scooter_limit=201.00        customer_care_limit=301.00      currency=TW
    None of the credit limit parameters can be NULL.         company_code=1500      parts_limit=101.00      scooter_limit=201.00        customer_care_limit=301.00      currency=${None}

companies-creditlimits - update - update companies creditlimits with null required fields
    [Tags]  FET
    [Template]   Verify Companies Creditlimits Update With Invalid Fields
    company_code must not be null                            company_code=${None}      parts_limit=101.00      scooter_limit=201.00        customer_care_limit=301.00      currency=TW
    None of the credit limit parameters can be NULL.         company_code=1500      parts_limit=101.00      scooter_limit=201.00        customer_care_limit=301.00      currency=${None}

*** Keywords ***
Suite Setup
    ${timestamp} =    Evaluate    int(time.time())   time
    ${furture_timestamp} =    Evaluate    int(time.time() + 86400)   time
	Set Suite Variable    ${timestamp}
	Set Suite Variable    ${furture_timestamp}

Create Companies Credit Limits
    Setup Companies Credit Limits Variables
    ${resp} =   Companies Creditlimits Post     ${company_code}     ${parts_limit}

Setup Companies Credit Limits Variables
    Set Test Variable ${company_code}           1500
    Set Test Variable ${parts_limit}            101.00
    Set Test Variable ${scooter_limit}          201.00
    Set Test Variable ${customer_care_limit}    301.00
    Set Test Variable ${currency}               TWD

Verify Companies Creditlimits Create With Invalid Fields
    [Arguments]    ${err_msg}    &{fields}
    ${resp} =   Companies Creditlimits Post   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Run Keyword If     ${fields["company_code"]} == ${None}    Should Contain      ${resp.json()['error_list'][0]['message']}     ${err_msg}
    ...    ELSE     Should Be Equal As Strings       ${resp.json()['error_list'][0]['key']}         ${fields["company_code"]}
                    Should Contain                   ${resp.json()['error_list'][0]['message']}     ${err_msg}


Verify Companies Creditlimits Update With Invalid Fields
    [Arguments]    ${err_msg}    &{fields}
    ${resp} =   Companies Creditlimits Post   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Run Keyword If     ${fields["company_code"]} == ${None}    Should Contain      ${resp.json()['error_list'][0]['message']}     ${err_msg}
    ...    ELSE     Should Be Equal As Strings       ${resp.json()['error_list'][0]['key']}         ${fields["company_code"]}
                    Should Contain                   ${resp.json()['error_list'][0]['message']}     ${err_msg}


Add Or Update Data List Setup
    ${CREDIT_LIMITS_ADD_OR_UPDATE_DATA1}=    evaluate    json.loads('''${CREDIT_LIMITS_ADD_OR_UPDATE_DATA_DICT_TEMPLATE}''')    json
    ${CREDIT_LIMITS_ADD_OR_UPDATE_DATA2}=    evaluate    json.loads('''${CREDIT_LIMITS_ADD_OR_UPDATE_DATA_DICT_TEMPLATE}''')    json
    ${CREDIT_LIMITS_ADD_OR_UPDATE_DATA3}=    evaluate    json.loads('''${CREDIT_LIMITS_ADD_OR_UPDATE_DATA_DICT_TEMPLATE}''')    json
    
    Set To Dictionary    ${CREDIT_LIMITS_ADD_OR_UPDATE_DATA1}    parts_limit=101.00\  
    ...     scooter_limit=201.00
    ...     customer_care_limit=301.00    
    ...     currency=TWD

    Set To Dictionary    ${CREDIT_LIMITS_ADD_OR_UPDATE_DATA2}    parts_limit=101.00\  
    ...     company_code=ABC
    ...     scooter_limit=201.00
    ...     customer_care_limit=301.00    
    ...     currency=TWD

    @{add_or_update_data_list} =    Create List    ${CREDIT_LIMITS_ADD_OR_UPDATE_DATA1}    ${CREDIT_LIMITS_ADD_OR_UPDATE_DATA2}

    Set Test Variable    @{add_or_update_data_list}


