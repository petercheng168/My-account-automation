# TODO company_group_id, create_time, update_time should be verified by some way. To update company when both company_id and company code are empty
*** Settings ***
Documentation    Functional test suite for /companies
Variables        ../../../env.py
Variables        ${PROJECT_ROOT}/setting.py   dev
Library          ${GP_API_ROOT}/LibCompanies.py
Resource         ${DP_ROOT}/standard_library_init.robot
Resource         ${PROJECT_ROOT}/lib/keywords_common.robot
Resource         ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource         ${GP_KEYWORD_ROOT}/keywords_companies.robot
Force Tags       Companies
Test Timeout     ${TEST_TIMEOUT}
Test Setup       Setup Variables

*** Test Cases ***
companies - add - invalid - create company without required fields
    [Tags]    FET
    [Template]    Verify Company Add When Field Is Invalid Value
    company_code can't be null       company_code=${None}
    company_name can't be null       company_name=${None}
    country_code can't be null       country_code=${None}
    company_type must not be null    company_type=${None}
    company_sub_type must not be null    company_sub_type=${None}
    'status' cannot be null            status=${None}

companies - add - invalid - create company with invalid fields
    [Tags]    FET
    [Template]    Verify Company Add When Field Is Invalid Value
    company_code length cannot more than 36                company_code=${x_company_code}
    company_name length cannot more than 128               company_name=${x_company_name}
    brand_name length cannot more than 36                  brand_name=${x_brand_name}
    address length cannot more than 128                    address=${x_address}
    zip length cannot more than 20                         zip=${x_zip}
    country_code length cannot more than 2                 country_code=${x_country_code}
    contact_person_firstname length cannot more than 36    contact_person_firstname=${x_contact_person_firstname}
    contact_person_lastname length cannot more than 30     contact_person_lastname=${x_contact_person_lastname}
    contact_email length cannot more than 256              contact_email=${x_contact_email}
    contact_phone1 length cannot more than 24              contact_phone1=${x_contact_phone1}
    contact_phone2 length cannot more than 24              contact_phone2=${x_contact_phone2}
    company_type must between 0 to 11                      company_type=${-1}
    company_type must between 0 to 11                      company_type=${12}
    company_sub_type must between 0 to 11                  company_sub_type=${-1}
    company_sub_type must between 0 to 11                  company_sub_type=${12}
    status cannot less than 0                              status=${-1}
    status cannot more than 1                              status=${ 2}

companies - add - valid - create company with all fields
	${resp} =    Company Add Applying Variables
   	Verify Status Code As Expected    ${resp}    200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    company_id
	Set Variable By Name Value    company_id    ${resp.json()['data'][0]['company_id']}
    ${resp} =    Company Get By Company Id And Super Account
  	Verify Status Code As Expected    ${resp}    200
    Verify Response For All Fields    ${resp}

companies - add - valid - create company with only required fields
    Update Optional Fields As    ${None}
	${resp} =    Company Add Applying Variables
	Verify Status Code As Expected    ${resp}    200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    company_id
    Set Variable By Name Value    company_id    ${resp.json()['data'][0]['company_id']}
    ${resp} =    Company Get By Company Id And Super Account
	Verify Status Code As Expected    ${resp}    200
    Verify Response For Required Fields    ${resp}

companies - add - valid - create company by company group admin account with only required fields 
    Update Optional Fields As    ${None}
	${resp} =    Company Add Applying Variables    ${CIPHER_GROUP_ACCOUNT}
	Verify Status Code As Expected    ${resp}    200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    company_id
    Set Variable By Name Value    company_id    ${resp.json()['data'][0]['company_id']}
    ${resp} =    Company Get By Company Id And Group Admin Account
	Verify Status Code As Expected    ${resp}    200
    Verify Response For Required Fields    ${resp}

companies - add - valid - create company with parameter address_city and address_state
    Update Optional Fields As    ${None}
	${resp} =    Company Add Applying Variables
	Verify Status Code As Expected    ${resp}    200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    company_id
    Set Variable By Name Value    company_id    ${resp.json()['data'][0]['company_id']}
    ${resp} =    Company Get By Company Id And Super Account
	Verify Status Code As Expected    ${resp}    200
    Verify Response For Required Fields    ${resp}
    Verify Response Contains Expected Variable Value    ${resp}    address_city     address_city
    Verify Response Contains Expected Variable Value    ${resp}    address_state    address_state

companies - update - invalid - update company without required fields
    [Tags]    FET
    [Template]    Verify Company Update When Field Is Invalid Value
    company_id and to_update_by_company_code cannot both be empty    company_id=${None}       company_code_key=${None}
    company_name can't be empty                                      company_name=${EMPTY}
    country_code can't be empty                                      country_code=${EMPTY}

companies - update - invalid - update company with invalid fields
    [Tags]    FET
    [Template]    Verify Company Update When Field Is Invalid Value
    company_name length cannot more than 128               company_name=${x_company_name}
    brand_name length cannot more than 36                  brand_name=${x_brand_name}
    address length cannot more than 128                    address=${x_address}    
    zip length cannot more than 20                         zip=${x_zip}
    country_code length cannot more than 2                 country_code=${x_country_code}
    contact_person_firstname length cannot more than 36    contact_person_firstname=${x_contact_person_firstname}
    contact_person_lastname length cannot more than 30     contact_person_lastname=${x_contact_person_lastname}
    contact_email length cannot more than 256              contact_email=${x_contact_email}
    contact_phone1 length cannot more than 24              contact_phone1=${x_contact_phone1}
    contact_phone2 length cannot more than 24              contact_phone2=${x_contact_phone2}
    company_type must between 0 to 11                      company_type=${-1}
    company_type must between 0 to 11                      company_type=${12}
    company_sub_type must between 0 to 11                  company_sub_type=${-1}
    company_sub_type must between 0 to 11                  company_sub_type=${12}
    status cannot less than 0                              status=${-1}
    status cannot more than 1                              status=${ 2}

companies - update - valid - update company with all fields
    Setup New Company And Keep Identifiers

    Update All Editable Fields
    ${resp} =    Company Update Applying Variables By Company Id
   	Verify Status Code As Expected    ${resp}    200
    ${resp} =    Company Get By Company Id And Super Account
  	Verify Status Code As Expected    ${resp}    200
  	Set Variable By Name Value    company_code    ${company_code_key}
  	Verify Response For All Fields    ${resp}

    Update All Editable Fields
    ${resp} =    Company Update Applying Variables By Company Code
   	Verify Status Code As Expected    ${resp}    200
    ${resp} =    Company Get By Company Id And Super Account
  	Verify Status Code As Expected    ${resp}    200
  	Set Variable By Name Value    company_code    ${company_code_key}
  	Verify Response For All Fields    ${resp}

companies - update - valid - update company with only required fields
    Setup New Company And Keep Identifiers

    Update All Editable Fields And Set Optional Fields As    ${EMPTY}
    ${resp} =    Company Update Applying Variables By Company Id
   	Verify Status Code As Expected    ${resp}    200
    ${resp} =    Company Get By Company Id And Super Account
  	Verify Status Code As Expected    ${resp}    200
  	Set Variable By Name Value    company_code    ${company_code_key}
  	Verify Response For All Fields    ${resp}

    Update All Editable Fields And Set Optional Fields As    ${EMPTY}
    ${resp} =    Company Update Applying Variables By Company Code
   	Verify Status Code As Expected    ${resp}    200
    ${resp} =    Company Get By Company Id And Super Account
  	Verify Status Code As Expected    ${resp}    200
  	Set Variable By Name Value    company_code    ${company_code_key}
  	Verify Response For All Fields    ${resp}

*** Keywords ***
Set Variable Random String By Name Length
    [Arguments]    ${name}    ${length}
    ${var_name} =	Set Variable    \${${name}}
    ${var_value} =    Generate Random String    ${length}    [STRINGS]
    Set Test Variable    ${var_name}    ${var_value}

Set Variable By Name Value
    [Arguments]    ${name}    ${value}
    ${var_name} =	Set Variable    \${${name}}
    ${var_value} =    Set Variable    ${value}
    Set Test Variable    ${var_name}    ${var_value}

Set Variables By Dict
    [Arguments]    &{dict}
    FOR    ${var_name}    IN    @{dict.keys()}
        Set Variable By Name Value    ${var_name}    ${dict["${var_name}"]}
    END

Setup Variables
    Setup Valid Variables
    Setup Invalid Variables

Setup Valid Variables
    Set Variable Random String By Name Length    company_code                36
	Set Variable Random String By Name Length    company_name               128
	Set Variable Random String By Name Length    brand_name                  36
	Set Variable Random String By Name Length    address                    128
    Set Variable Random String By Name Length    address_city                30
    Set Variable Random String By Name Length    address_state               30
	Set Variable Random String By Name Length    zip                         20
	Set Variable Random String By Name Length    country_code                 2
	Set Variable Random String By Name Length    contact_person_firstname    36
	Set Variable Random String By Name Length    contact_person_lastname     30
	Set Variable Random String By Name Length    contact_email              256
	Set Variable Random String By Name Length    contact_phone1              24
	Set Variable Random String By Name Length    contact_phone2              24
    Set Variable By Name Value                   status                     ${0}
    Set Variable By Name Value                   company_type               ${0}
    Set Variable By Name Value                   company_sub_type           ${0}
    Set Variable By Name Value                   company_group_id        ${None}

Setup Invalid Variables
    Set Variable Random String By Name Length    x_company_code                37
	Set Variable Random String By Name Length    x_company_name               129
	Set Variable Random String By Name Length    x_brand_name                  37
	Set Variable Random String By Name Length    x_address                    129
	Set Variable Random String By Name Length    x_zip                         21
	Set Variable Random String By Name Length    x_country_code                 3
	Set Variable Random String By Name Length    x_contact_person_firstname    37
	Set Variable Random String By Name Length    x_contact_person_lastname     31
	Set Variable Random String By Name Length    x_contact_email              257
	Set Variable Random String By Name Length    x_contact_phone1              25
	Set Variable Random String By Name Length    x_contact_phone2              25
    Set Variable Random String By Name Length    x_company_code                37

Setup New Company And Keep Identifiers
    ${resp} =    Company Add Applying Variables
	Set Variable By Name Value    company_id    ${resp.json()['data'][0]['company_id']}
    ${resp} =    Company Get By Company Id And Super Account
	Set Variable By Name Value    company_code_key    ${resp.json()['data'][0]['code']}

Update Optional Fields As
    [Arguments]    ${value_for_optional_fields}
	Set Variable By Name Value    brand_name                  ${value_for_optional_fields}
	Set Variable By Name Value    address                     ${value_for_optional_fields}
	Set Variable By Name Value    zip                         ${value_for_optional_fields}
	Set Variable By Name Value    contact_person_firstname    ${value_for_optional_fields}
	Set Variable By Name Value    contact_person_lastname     ${value_for_optional_fields}
	Set Variable By Name Value    contact_email               ${value_for_optional_fields}
	Set Variable By Name Value    contact_phone1              ${value_for_optional_fields}
	Set Variable By Name Value    contact_phone2              ${value_for_optional_fields}

Update All Editable Fields
    [Documentation]    This is to change all test variable values for update scenario.
    Setup Valid Variables
    Set Variable By Name Value                   company_code           ${None}
    Set Variable By Name Value                   status                    ${1}
    Set Variable By Name Value                   company_type             ${11}
    Set Variable By Name Value                   company_sub_type         ${11}
    Set Variable By Name Value                   company_group_id       ${None}
    Log Variables

Update All Editable Fields And Set Optional Fields As
    [Arguments]    ${value_for_optional_fields}
    Update All Editable Fields
    Update Optional Fields As    ${value_for_optional_fields}

Company Get By Company Id And Super Account
    ${resp} =    Companies Get
    ...    company_id=${company_id}
    ...    account=${CIPHER_SUPER_ACCOUNT}
    [Return]    ${resp}

Company Get By Company Id And Group Admin Account
    ${resp} =    Companies Get
    ...    company_id=${company_id}
    ...    account=${CIPHER_GROUP_ACCOUNT}
    [Return]    ${resp}

Company Add Applying Variables
    [Arguments]    ${account}=None
	${resp} =    Companies Post
    ...    company_code=${company_code}
    ...    company_name=${company_name}
    ...    brand_name=${brand_name}
    ...    address=${address}
    ...    address_city=${address_city}
    ...    address_state=${address_state}
    ...    zip_code=${zip}
    ...    country_code=${country_code}
    ...    contact_person_firstname=${contact_person_firstname}
    ...    contact_person_lastname=${contact_person_lastname}
    ...    contact_email=${contact_email}
    ...    contact_phone1=${contact_phone1}
    ...    contact_phone2=${contact_phone2}
    ...    company_type=${company_type}
    ...    company_sub_type=${company_sub_type}
    ...    company_group_id=${company_group_id}
    ...    status=${status}
    ...    account=${account}
    [Return]    ${resp}

Company Update Applying Variables By Company Id
	${resp} =    Companies Update
    ...    company_id=${company_id}
    ...    to_update_by_company_code=${company_code_key}
    ...    company_name=${company_name}
    ...    brand_name=${brand_name}
    ...    address=${address}
    ...    zip_code=${zip}
    ...    country_code=${country_code}
    ...    contact_person_firstname=${contact_person_firstname}
    ...    contact_person_lastname=${contact_person_lastname}
    ...    contact_email=${contact_email}
    ...    contact_phone1=${contact_phone1}
    ...    contact_phone2=${contact_phone2}
    ...    company_type=${company_type}
    ...    company_sub_type=${company_sub_type}
    ...    status=${status}
    [Return]    ${resp}

Company Update Applying Variables By Company Code
	${resp} =    Companies Update
    ...    to_update_by_company_code=${company_code_key}
    ...    company_name=${company_name}
    ...    brand_name=${brand_name}
    ...    address=${address}
    ...    zip_code=${zip}
    ...    country_code=${country_code}
    ...    contact_person_firstname=${contact_person_firstname}
    ...    contact_person_lastname=${contact_person_lastname}
    ...    contact_email=${contact_email}
    ...    contact_phone1=${contact_phone1}
    ...    contact_phone2=${contact_phone2}
    ...    company_type=${company_type}
    ...    company_sub_type=${company_sub_type}
    ...    status=${status}
    [Return]    ${resp}

Verify Response Contains Expected Variable Value
    [Arguments]    ${resp}    ${key_name}    ${var_name}
    ${var_value} =    Get Variable Value    \${${var_name}}
	Verify Response Contains Expected    ${resp.json()['data'][0]['${key_name}']}	${var_value}

Verify Response For Required Fields
    [Arguments]    ${resp}
    Verify Response Contains Expected Variable Value    ${resp}    company_id          company_id
    Verify Response Contains Expected Variable Value    ${resp}    code                company_code
    Verify Response Contains Expected Variable Value    ${resp}    name                company_name
    Verify Response Contains Expected Variable Value    ${resp}    country_code        country_code
    Verify Response Contains Expected Variable Value    ${resp}    company_type        company_type
    Verify Response Contains Expected Variable Value    ${resp}    company_sub_type    company_sub_type
    Verify Response Contains Expected Variable Value    ${resp}    status              status

Verify Response For Optional Fields
    [Arguments]    ${resp}
    Verify Response Contains Expected Variable Value    ${resp}    brand_name                  brand_name
    Verify Response Contains Expected Variable Value    ${resp}    address                     address
    Verify Response Contains Expected Variable Value    ${resp}    zip                         zip
    Verify Response Contains Expected Variable Value    ${resp}    contact_person_firstname    contact_person_firstname
    Verify Response Contains Expected Variable Value    ${resp}    contact_person_lastname     contact_person_lastname
    Verify Response Contains Expected Variable Value    ${resp}    contact_email               contact_email
    Verify Response Contains Expected Variable Value    ${resp}    contact_phone1              contact_phone1
    Verify Response Contains Expected Variable Value    ${resp}    contact_phone2              contact_phone2

Verify Response For All Fields
    [Arguments]    ${resp}
    Verify Response For Required Fields    ${resp}
    Verify Response For Optional Fields    ${resp}

Verify Company Add When Field Is Invalid Value
    [Arguments]    ${err_msg}    &{invalid_variables}
    Setup Variables
    Set Variables By Dict    &{invalid_variables}
    ${resp} =    Company Add Applying Variables
    Verify Status Code As Expected    ${resp}    200    
    Verify Error List Message         ${resp}    ${err_msg}

Verify Company Update When Field Is Invalid Value
    [Arguments]    ${err_msg}    &{invalid_variables}
    Setup Variables
    Setup New Company And Keep Identifiers
    Update All Editable Fields
    Set Variables By Dict    &{invalid_variables}
    ${resp} =    Company Update Applying Variables By Company Id
    Verify Status Code As Expected    ${resp}    200
    Verify Error List Message         ${resp}    ${err_msg}

Verify Error List Message
    [Arguments]    ${resp}    ${err_msg}
    Verify Response Contains Expected    ${resp.json()['code']}               -1
    Should Contain                       ${resp.json()['error_list'][0]['message']}    ${err_msg}