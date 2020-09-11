*** Settings ***
Documentation    Functional test suite for /company-groups
Variables        ../../../env.py
Variables        ${PROJECT_ROOT}/setting.py   dev
Library          ${GP_API_ROOT}/LibCompanyGroups.py
Library          ${GP_API_ROOT}/LibCompanies.py
Library          ${GP_API_ROOT}/LibCompanyGroupCompanies.py
Resource         ${DP_ROOT}/standard_library_init.robot
Resource         ${PROJECT_ROOT}/lib/keywords_common.robot
Resource         ${GP_KEYWORD_ROOT}/keywords_common.robot
Force Tags       Company-Groups
Test Timeout     ${TEST_TIMEOUT}

*** Test Cases ***
company groups - get - invalid - get company group by invalid id
    [Tags]        FET
    [Setup]       Test Setup For Get
    [Template]    Verify Company Group Get With Invalid Fields
    803010003    decode failed                                        id=arbitrary-company-group-id    name=${None}
    402010005    company_group_name must be less than 64 character    id=${None}                       name=${x_too_long_company_group_name}

company groups - get - invalid - get company group by arbitrary name
    [Setup]    Test Setup For Get
    ${resp} =    Company Group Get By Fields    ${None}    arbitrary-company-group-name
    Verify Status Code As Expected     ${resp}    200
    Length Should Be    ${resp.json()['data']}    0

company groups - get - valid - get company group
    [Setup]       Test Setup For Get
    [Template]    Verify Company Group Get With Valid Fields
    id=${company_group_id}    name=${None}
    id=${company_group_id}    name=${company_group_name}
    id=${None}                name=${company_group_name}

company groups - add - invalid - create company group without required fields
    [Tags]    FET
    [Setup]    Test Setup For Add
    [Template]    Verify Company Group Add With Invalid Fields
    402010003    company_group_name must not be null    company_group_name=${None}
    402010003    company_group_code must not be null    company_group_code=${None}
    402010003    data_company_code must not be null     data_company_code=${None}
    402010003    company_list must not be null          company_list=${None}

company groups - add - invalid - create company group with invalid fields
    [Tags]    FET
    [Setup]    Test Setup For Add
    [Template]    Verify Company Group Add With Invalid Fields
    402010005    company_group_name must be less than 64 character       company_group_name=${x_too_long_company_group_name}
    402010005    company_group_code must be less than 3 character        company_group_code=${x_too_long_company_group_code}
    604040002    Unable to find the data company.                        data_company_code=arbitrary-company-code-d    company_list=arbitrary-company-code-d,${company_code_1}
    604040002    Unable to find the company in the group company list    company_list=${company_code_d},arbitrary-company-code-1
    604040002    The data company is not in the company group list       company_list=${company_code_1}

company groups - add - valid - create company group with all fields which are all required
    [Setup]    Test Setup For Add
    Set Variable By Name Value                   data_company_code     ${company_code_d}
    Set Variable By Name Value                   company_list          ${company_code_d},${company_code_1}

	${resp} =    Company Group Add Applying Variables
   	Verify Status Code As Expected    ${resp}    200
    Verify Response Should Contains Key    ${resp.json()['data'][0]}    company_group_id
	Set Variable By Name Value    company_group_id    ${resp.json()['data'][0]['company_group_id']}
    ${resp} =    Company Group Get By Company Group Id
  	Verify Status Code As Expected    ${resp}    200
    Verify Response For All Fields    ${resp}

    ${resp} =    Company Group Companies Get By Company Group Id
    Verify Response Should Contain Company Code    ${resp}    ${company_code_d}
    Verify Response Should Contain Company Code    ${resp}    ${company_code_1}

company groups - update - invalid - update company group without required fields
    [Tags]    FET
    [Setup]   Test Setup For Update
    [Template]    Verify Company Group Update With Invalid Fields
    402010004    company_group_name must not be empty                            company_group_name=${EMPTY}

company groups - update - invalid - update company group with invalid fields
    [Tags]    FET
    [Setup]   Test Setup For Update
    [Template]    Verify Company Group Update With Invalid Fields
    402010005    company_group_name must be less than 64 character                      company_group_name=${x_too_long_company_group_name}
    604040002    Unable to find the company in the group company list                   company_list_add=arbitrary-company-code-2,${company_code_2}    company_list_remove=${None}
    604040002    Unable to find the company in the group company list                   company_list_add=${None}                                       company_list_remove=arbitrary-company-code-1,${company_code_1}
    604040002    This company already belongs to other company group                    company_list_add=${company_code_1}                             company_list_remove=${None}
    604040002    This company been removed does not belong to the company group         company_list_add=${None}                                       company_list_remove=${company_code_2}
    604040002    Cannot remove the root company of the company_group from this group    company_list_add=${None}                                       company_list_remove=${company_code_d}

company groups - update - valid - update company group with all fields
    [Setup]   Test Setup For Update
    Setup Valid Editable Variables
    Set Variable By Name Value                   company_list_add      ${company_code_2}
    Set Variable By Name Value                   company_list_remove   ${company_code_1}

    ${resp} =    Company Group Update Applying Variables
   	Verify Status Code As Expected    ${resp}    200

   	${resp} =    Company Group Get By Company Group Id
  	Verify Status Code As Expected    ${resp}    200
  	Verify Response For All Fields    ${resp}

    ${resp} =    Company Group Companies Get By Company Group Id
    Verify Response Should Contain Company Code        ${resp}    ${company_code_d}
    Verify Response Should Not Contain Company Code    ${resp}    ${company_code_1}
    Verify Response Should Contain Company Code        ${resp}    ${company_code_2}

company groups - update - valid - update company group with only required fields
    [Setup]   Test Setup For Update
    Setup Valid Editable Variables
    Set Variable By Name Value                   company_list_add       ${company_code_2}
    Set Variable By Name Value                   company_list_remove    ${None}

    ${resp} =    Company Group Update Applying Variables
   	Verify Status Code As Expected    ${resp}    200

   	${resp} =    Company Group Get By Company Group Id
  	Verify Status Code As Expected    ${resp}    200
  	Verify Response For All Fields    ${resp}

    ${resp} =    Company Group Companies Get By Company Group Id
  	Verify Response Should Contain Company Code    ${resp}    ${company_code_d}
    Verify Response Should Contain Company Code    ${resp}    ${company_code_1}
    Verify Response Should Contain Company Code    ${resp}    ${company_code_2}

    Setup Valid Editable Variables
    Set Variable By Name Value                   company_list_add       ${None}
    Set Variable By Name Value                   company_list_remove    ${company_code_1}

    ${resp} =    Company Group Update Applying Variables
   	Verify Status Code As Expected    ${resp}    200

   	${resp} =    Company Group Get By Company Group Id
  	Verify Status Code As Expected    ${resp}    200
  	Verify Response For All Fields    ${resp}

    ${resp} =    Company Group Companies Get By Company Group Id
  	Verify Response Should Contain Company Code        ${resp}    ${company_code_d}
    Verify Response Should Not Contain Company Code    ${resp}    ${company_code_1}
    Verify Response Should Contain Company Code        ${resp}    ${company_code_2}

*** Keywords ***
Test Setup For Add
    Setup Valid Variables
    Setup Invalid Variables
    Setup Companies

Test Setup For Update
    Setup Valid Variables
    Setup Invalid Variables
    Setup Companies
    Create Company Group And Keep Identifiers

Test Setup For Get
    Setup Valid Variables
    Setup Invalid Variables
    Setup Companies
    Create Company Group And Keep Identifiers

Setup Valid Variables
    Set Variable Random String By Name Length    company_group_name    64
    Set Variable Random String By Name Length    company_group_code    3
    Set Variable By Name Value                   account               ${CIPHER_SUPER_ACCOUNT}

Setup Valid Editable Variables
    Set Variable Random String By Name Length    company_group_name    64

Setup Invalid Variables
    Set Variable Random String By Name Length    x_too_long_company_group_name    65
    Set Variable Random String By Name Length    x_too_long_company_group_code     4

Setup Companies
    Create Company And Keep Company Code In Variable    company_code_d
    Create Company And Keep Company Code In Variable    company_code_1
    Create Company And Keep Company Code In Variable    company_code_2

Create Company Group And Keep Identifiers
    Set Variable By Name Value                   data_company_code     ${company_code_d}
    Set Variable By Name Value                   company_list          ${company_code_d},${company_code_1}
    ${resp} =    Company Group Add Applying Variables
	Set Variable By Name Value    company_group_id    ${resp.json()['data'][0]['company_group_id']}

Create Company And Keep Company Code In Variable
    [Arguments]    ${company_code_var_name}
    ${company_code} =    Set Variable Random String By Name Length    ${company_code_var_name}    36
    ${company_name} =    Generate Random String    128   [STRINGS]
	${resp} =    Companies Post
    ...    company_code=${company_code}
    ...    company_name=${company_name}
    ...    country_code=TW
    ...    company_type=${0}
    ...    company_sub_type=${0}
    ...    status=${1}

Company Group Add Applying Variables
	${resp} =    Company Groups Add
    ...    company_group_name=${company_group_name}
    ...    company_group_code=${company_group_code}
    ...    data_company_code=${data_company_code}
    ...    company_list=${company_list}
    ...    account=${account}
    [Return]    ${resp}

Company Group Update Applying Variables
	${resp} =    Company Groups Update
    ...    company_group_id=${company_group_id}
    ...    company_group_name=${company_group_name}
    ...    company_list_add=${company_list_add}
    ...    company_list_remove=${company_list_remove}
    ...    account=${account}
    [Return]    ${resp}

Company Group Get By Company Group Id
    ${resp} =    Company Groups Get
    ...    company_group_id=${company_group_id}
    ...    account=${CIPHER_SUPER_ACCOUNT}
    [Return]    ${resp}

Company Group Get By Fields
    [Arguments]    ${company_group_id}    ${company_group_name}
    ${resp} =    Company Groups Get
    ...    company_group_id=${company_group_id}
    ...    company_group_name=${company_group_name}
    ...    account=${CIPHER_SUPER_ACCOUNT}
    [Return]    ${resp}

Company Group Companies Get By Company Group Id
    ${resp} =    Company Group Companies Get
    ...    company_group_id=${company_group_id}
    ...    account=${account}
    [Return]    ${resp}

Verify Response For All Fields
    [Arguments]    ${resp}
    Verify Response Contains Expected Variable Value    ${resp}    company_group_id      company_group_id
    Verify Response Contains Expected Variable Value    ${resp}    company_group_name    company_group_name
    Verify Response Contains Expected Variable Value    ${resp}    company_group_code    company_group_code
    Verify Response Contains Expected Value             ${resp}    status                1

Verify Response Contains Expected Variable Value
    [Arguments]    ${resp}    ${field_name}    ${var_name}
    ${var_value} =    Get Variable Value    \${${var_name}}
    Verify Response Contains Expected Value    ${resp}    ${field_name}    ${var_value}

Verify Response Contains Expected Value
    [Arguments]    ${resp}    ${field_name}    ${var_value}
	Verify Response Contains Expected    ${resp.json()['data'][0]['${field_name}']}	${var_value}

Verify Company Group Add With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{invalid_variables}
    Setup Valid Variables
    Set Variable By Name Value                   data_company_code     ${company_code_d}
    Set Variable By Name Value                   company_list          ${company_code_d},${company_code_1}
    Set Variables By Dict    &{invalid_variables}

    ${resp} =    Company Group Add Applying Variables
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}

Verify Company Group Update With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{invalid_variables}
    Setup Valid Editable Variables
    Set Variable By Name Value    company_list_add      ${company_code_2}
    Set Variable By Name Value    company_list_remove   ${company_code_1}
    Set Variables By Dict    &{invalid_variables}

    ${resp} =    Company Group Update Applying Variables
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}

Verify Company Group Get With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{invalid_variables}
    ${resp} =    Company Group Get By Fields    ${invalid_variables['id']}    ${invalid_variables['name']}
    Verify Status Code As Expected     ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}

Verify Company Group Get With Valid Fields
    [Arguments]    &{valid_variables}
    ${resp} =    Company Group Get By Fields    ${valid_variables['id']}    ${valid_variables['name']}
    Verify Status Code As Expected    ${resp}    200
    Verify Response For All Fields    ${resp}

Verify Response Should Contain Company Code
    [Arguments]    ${resp}    ${company_code_value}
    Verify Response By Company Code And Length    ${resp}    ${company_code_value}    1

Verify Response Should Not Contain Company Code
    [Arguments]    ${resp}    ${company_code_value}
    Verify Response By Company Code And Length    ${resp}    ${company_code_value}    0

Verify Response By Company Code And Length
    [Arguments]    ${resp}    ${company_code_value}    ${expected_length}
    ${list} =    Evaluate    list(filter((lambda i: 'company_code' in i.keys() and "${company_code_value}" == i["company_code"]), ${resp.json()['data']}))    re
    Length Should Be    ${list}    ${expected_length}

Set Variables By Dict
    [Arguments]    &{dict}
    FOR    ${var_name}    IN    @{dict.keys()}
        Set Variable By Name Value    ${var_name}    ${dict["${var_name}"]}
    END

Set Variable Random String By Name Length
    [Arguments]    ${name}    ${length}
    ${var_name} =	Set Variable    \${${name}}
    ${var_value} =    Generate Random String    ${length}    [STRINGS]
    Set Test Variable    ${var_name}    ${var_value}
    [Return]    ${var_value}

Set Variable By Name Value
    [Arguments]    ${name}    ${value}
    ${var_name} =	Set Variable    \${${name}}
    ${var_value} =    Set Variable    ${value}
    Set Test Variable    ${var_name}    ${var_value}