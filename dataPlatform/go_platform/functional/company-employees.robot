*** Settings ***
Documentation    Test suite of Employee
Resource    ../init.robot

Force Tags    Employees
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${CREATE_EMPLOYEE_SUCCESS_WITH_EMP_CODE}=
...     {
...         "department_id": "jrLOPvRO",
...         "emp_code": "SWQA",
...         "first_name": "first",
...         "middle_name": "middle",
...         "last_name": "last",
...         "legal_first_name": "legal_first",
...         "legal_middle_name": "legal_middle",
...         "legal_last_name": "legal_last",
...         "profile_id": "SWQA",
...         "mobile_phone": "0912345678",
...         "email": "sw.verify",
...         "password": "password",
...         "contact_address": "contact_address",
...         "contact_zip": "contact_zip",
...         "job_title": "job_title",
...         "job_duty": "job_duty",
...         "job_code": 20,
...         "gender": "M",
...         "emp_date": null,
...         "terminate_date": null,
...         "password_force_update": 0
...     }

${CREATE_EMPLOYEE_SUCCESS_WITHOUT_EMP_CODE}=
...     {
...         "department_id": "jrLOPvRO",
...         "emp_code": null,
...         "first_name": "first",
...         "middle_name": "middle",
...         "last_name": "last",
...         "legal_first_name": "legal_first",
...         "legal_middle_name": "legal_middle",
...         "legal_last_name": "legal_last",
...         "profile_id": "SWQA",
...         "mobile_phone": "0912345678",
...         "email": "sw.verify",
...         "password": "password",
...         "contact_address": "contact_address",
...         "contact_zip": "contact_zip",
...         "job_title": "job_title",
...         "job_duty": "job_duty",
...         "job_code": 10,
...         "gender": "M",
...         "emp_date": null,
...         "terminate_date": null,
...         "password_force_update": 0
...     }

${CREATE_EMPLOYEE_FAIL_WITH_DUPLICATE_EMP_CODE}=
...     {
...         "department_id": "jrLOPvRO",
...         "emp_code": "DEV99001",
...         "first_name": "first",
...         "middle_name": "middle",
...         "last_name": "last",
...         "legal_first_name": "legal_first",
...         "legal_middle_name": "legal_middle",
...         "legal_last_name": "legal_last",
...         "profile_id": "SWQA",
...         "mobile_phone": "0912345678",
...         "email": "sw.verify",
...         "password": "password",
...         "contact_address": "contact_address",
...         "contact_zip": "contact_zip",
...         "job_title": "job_title",
...         "job_duty": "job_duty",
...         "job_code": 10,
...         "gender": "M",
...         "emp_date": null,
...         "terminate_date": null,
...         "password_force_update": 0
...     }

${UPDATE_EMPLOYEE}=
...     {
...         "emp_id": null,
...         "new_company_id": null,
...         "department_id": null,
...         "first_name": null,
...         "middle_name": null,
...         "last_name": null,
...         "legal_first_name": null,
...         "legal_middle_name": null,
...         "legal_last_name": null,
...         "profile_id": null,
...         "mobile_phone": null,
...         "email": null,
...         "password": null,
...         "contact_address": null,
...         "contact_zip": null,
...         "job_title": null,
...         "job_duty": null,
...         "job_code": null,
...         "gender": null,
...         "emp_date": null,
...         "terminate_date": null,
...         "security_key": null,
...         "status": null,
...         "password_force_update": 1
...     }

${GET_EMPLOYEE}=
...     {
...         "department_id": null,
...         "emp_id": null,
...         "emp_code": null,
...         "emp_job_code": null,
...         "first_name": null,
...         "middle_name": null,
...         "last_name": null,
...         "legal_first_name": null,
...         "legal_middle_name": null,
...         "legal_last_name": null,
...         "profile_id": null,
...         "mobile_phone": null,
...         "email": null,
...         "job_title": null,
...         "job_code": null,
...         "gender": null,
...         "status": null,
...         "since_last_update": null,
...         "pagination_criteria": null
...     }

*** Test Cases ***
employees - create success with specify emp_code
    [Setup]    Test Setup
    ${emp_code}=      Format String    {}{}                ${SUCCESS_EMPLOYEE_WITH_EMP_CODE['emp_code']}         ${TIME_STAMP}
    ${email}=         Format String    {}+{}@gogoro.com    ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE['email']}         ${TIME_STAMP}
    ${profile_id}=    Format String    {}{}                ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE['profile_id']}    ${TIME_STAMP}    
    Set To Dictionary    ${SUCCESS_EMPLOYEE_WITH_EMP_CODE}    
    ...    emp_code=${emp_code}
    ...    email=${email}
    ...    profile_id=${profile_id}
    ...    emp_date=${TIME_STAMP}

    ${create_resp}=    Create Employees    ${SUCCESS_EMPLOYEE_WITH_EMP_CODE}
    Verify Status Code As Expected  ${create_resp}  200

    ${emp_id}=    Set Variable    ${create_resp.json()['data'][0]['emp_id']}
    Verify Response Data Not None    ${emp_id}

    ${get_resp} =    Get Employees By Emp Id    ${emp_id}
    Verify Status Code As Expected  ${get_resp}  200
    Verify Create Employee As Expected With Admin Account    ${get_resp.json()["data"][0]}    ${SUCCESS_EMPLOYEE_WITH_EMP_CODE}

employees - create success without emp_code
    [Setup]    Test Setup
    ${email}=        Format String    {}+{}@gogoro.com    ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE['email']}         ${TIME_STAMP}
    ${profile_id}=   Format String    {}{}                ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE['profile_id']}    ${TIME_STAMP}
    Set To Dictionary    ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE}    
    ...    email=${email}
    ...    profile_id=${profile_id}
    ...    emp_date=${TIME_STAMP}

    ${create_resp}=    Create Employees    ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE}
    Verify Status Code As Expected  ${create_resp}  200

    ${emp_id}=    Set Variable    ${create_resp.json()['data'][0]['emp_id']}
    Verify Response Data Not None    ${emp_id}

    ${get_resp} =    Get Employees By Emp Id    ${emp_id}
    Verify Status Code As Expected  ${get_resp}  200
    Verify Create Employee As Expected With Admin Account    ${get_resp.json()["data"][0]}    ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE}

employees - create fail without duplicate emp_code
    [Tags]    FET
    [Setup]    Test Setup
    ${email}=         Format String    {}+{}@gogoro.com    ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE['email']}         ${TIME_STAMP}
    ${profile_id}=    Format String    {}{}                ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE['profile_id']}    ${TIME_STAMP}
    Set To Dictionary    ${FAIL_EMPLOYEE_WITH_DUPLICATE_EMP_CODE}    
    ...    email=${email}
    ...    profile_id=${profile_id}
    ...    emp_date=${TIME_STAMP}

    ${create_resp}=    Create Employees    ${FAIL_EMPLOYEE_WITH_DUPLICATE_EMP_CODE}
    Verify Status Code As Expected       ${create_resp}    200
    Verify GoPlatform Error Message      ${create_resp}    604040003    1674

employees - get success
    [Setup]    Setup Get Employee
    [Template]    Verify Employees Get By Argument
    ${get_emp_by_department_id}
    ${get_emp_by_department_id_list}
    ${get_emp_by_emp_id}
    ${get_emp_by_emp_code}
    ${get_emp_by_emp_job_code}
    ${get_emp_by_first_name}
    ${get_emp_by_middle_name}
    ${get_emp_by_last_name}
    ${get_emp_by_legal_first_name}
    ${get_emp_by_legal_middle_name}
    ${get_emp_by_legal_last_name}
    ${get_emp_by_profile_id}
    ${get_emp_by_mobile_phone}
    ${get_emp_by_email}
    ${get_emp_by_job_title}
    ${get_emp_by_job_code}
    ${get_emp_by_status}

employees - update fail - without required fields
    [Tags]    FET
    [Setup]    Test Setup
    [Template]    Verify Employees Update With Invalid Fields
    402010006    default message [updateData[0].empId]]; default message [must not be null]]    account=${None}                    emp_id=${None}

employees - update fail - with invalid fields
    [Tags]    FET
    [Setup]    Test Setup
    [Template]    Verify Employees Update With Invalid Fields
    604040007    Unauthorized                                                                   account=${CIPHER_SUPER_ACCOUNT}    status=${2}       terminate_date=${TIME_STAMP}
    604040002    in_terminate_date must not be null                                             account=${None}                    status=${2}

employees - update success - by different roles
    [Setup]    Test Setup
    [Template]    Verify Employees Update By Different Roles
    account=${CIPHER_GEN_ACCOUNT}
    account=${CIPHER_GROUP_ACCOUNT}

employees - update success - inactive employee
    [Setup]    Test Setup
    ${emp_id}=    Create Test Employee
    ${resp_add_data} =    Get Employees By Emp Id    ${emp_id}

    ${changed_fields} =    Create Dictionary
    ...    status=${TERMINATED}
    ...    terminate_date=${AFTER_7_DAYS}

    ${update_data} =    Create Dictionary    &{UPDATE_EMPLOYEE}    emp_id=${emp_id}    &{changed_fields}

    ${resp} =    Update employees    ${update_data}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected     ${resp.json()['code']}    0

    ${expected_result} =    Create Dictionary    &{resp_add_data.json()["data"][0]}    &{changed_fields}

    ${resp} =    Get Employees By Emp Id    ${emp_id}
    Verify Update Employee Basic Fields As Expected    ${resp.json()["data"][0]}    ${expected_result}
    Should Be Equal As Integers      ${resp.json()["data"][0]["terminate_date"]}         ${expected_result["terminate_date"]}

employees - update success - active an inactive employee
    [Setup]    Test Setup

    ${emp_id}=    Create Test Employee
    ${update_data} =    Create Dictionary    &{UPDATE_EMPLOYEE}
    ...    emp_id=${emp_id}
    ...    status=${TERMINATED}
    ...    terminate_date=${AFTER_7_DAYS}
    ${resp} =    Update employees    ${update_data}
    ${resp_add_data} =    Get Employees By Emp Id    ${emp_id}

    ${changed_fields} =    Create Dictionary
    ...    status=${ACTIVE}

    ${update_data} =    Create Dictionary    &{UPDATE_EMPLOYEE}    emp_id=${emp_id}    &{changed_fields}

    ${resp} =    Update employees    ${update_data}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected     ${resp.json()['code']}    0

    ${expected_result} =    Create Dictionary    &{resp_add_data.json()["data"][0]}    &{changed_fields}

    ${resp} =    Get Employees By Emp Id    ${emp_id}
    Verify Update Employee Basic Fields As Expected    ${resp.json()["data"][0]}    ${expected_result}
    Dictionary Should Not Contain Key    ${resp.json()["data"][0]}    terminate_date

employees - update success - enable security key
    [Setup]    Test Setup
    ${emp_id}=    Create Test Employee
    ${resp_add_data} =    Get Employees By Emp Id    ${emp_id}

    ${changed_fields} =    Create Dictionary
    ...    security_key=the-security-key

    ${update_data} =    Create Dictionary    &{UPDATE_EMPLOYEE}    emp_id=${emp_id}    &{changed_fields}

    ${resp} =    Update employees    ${update_data}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected     ${resp.json()['code']}    0

    ${expected_result} =    Create Dictionary    &{resp_add_data.json()["data"][0]}    &{changed_fields}
    ...    enable_security_key=${True}

    ${resp} =    Get Employees By Emp Id    ${emp_id}
    Verify Update Employee Basic Fields As Expected    ${resp.json()["data"][0]}    ${expected_result}
    Should Be Equal As Strings      ${resp.json()["data"][0]["security_key"]}         ${expected_result["security_key"]}

*** Keywords ***
Test Setup

    ${SUCCESS_EMPLOYEE_WITH_EMP_CODE}=           evaluate    json.loads('''${CREATE_EMPLOYEE_SUCCESS_WITH_EMP_CODE}''')    json
    ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE}=        evaluate    json.loads('''${CREATE_EMPLOYEE_SUCCESS_WITHOUT_EMP_CODE}''')    json
    ${FAIL_EMPLOYEE_WITH_DUPLICATE_EMP_CODE}=    evaluate    json.loads('''${CREATE_EMPLOYEE_FAIL_WITH_DUPLICATE_EMP_CODE}''')    json
    ${UPDATE_EMPLOYEE}=                          evaluate    json.loads('''${UPDATE_EMPLOYEE}''')    json
    ${GET_EMPLOYEE}=                             evaluate    json.loads('''${GET_EMPLOYEE}''')    json
    ${TIME_STAMP}=                               evaluate    int(round(time.time()))    time

    Set Test Variable    ${SUCCESS_EMPLOYEE_WITH_EMP_CODE}
    Set Test Variable    ${SUCCESS_EMPLOYEE_WITHOUT_EMP_CODE}
    Set Test Variable    ${FAIL_EMPLOYEE_WITH_DUPLICATE_EMP_CODE}
    Set Test Variable    ${UPDATE_EMPLOYEE}
    Set Test Variable    ${GET_EMPLOYEE}
    Set Test Variable    ${TIME_STAMP}
    Set Test Variable    ${BEFORE_7_DAYS}    ${TIME_STAMP-1000*60*60*24*7}
    Set Test Variable    ${AFTER_7_DAYS}     ${TIME_STAMP+1000*60*60*24*7}
    Set Test Variable    ${ACTIVE}           ${1}
    Set Test Variable    ${TERMINATED}       ${2}
    Set Test Variable    ${FEMALE}           F
    Set Test Variable    ${STORE_OWNER}      ${30}

Create Test Employee
    ${sufix} =    Generate Random String    16    [STRINGS]

    ${emp_code}=      Format String    {}{}                ${SUCCESS_EMPLOYEE_WITH_EMP_CODE['emp_code']}      ${sufix}
    ${email}=         Format String    {}+{}@gogoro.com    ${SUCCESS_EMPLOYEE_WITH_EMP_CODE['email']}         ${sufix}
    ${profile_id}=    Format String    {}{}                ${SUCCESS_EMPLOYEE_WITH_EMP_CODE['profile_id']}    ${sufix}

    # Set to json
    ${add_data} =    Create Dictionary    &{SUCCESS_EMPLOYEE_WITH_EMP_CODE}
    ...    emp_code=${emp_code}
    ...    email=${emp_code}
    ...    profile_id=${emp_code}
    ...    emp_date=${TIME_STAMP}

    ${create_resp}=    Create Employees    ${add_data}
    Verify Status Code As Expected  ${create_resp}  200

    ${emp_id}=    Set Variable    ${create_resp.json()['data'][0]['emp_id']}
    Verify Response Data Not None    ${emp_id}
    [return]     ${emp_id}

Copy And Modify JSON
    [Arguments]    ${json}    ${key}    ${value}
    ${copy_json}=    Copy Dictionary    ${json}
    Set To Dictionary    ${copy_json}    ${key}=${value}
    [return]     ${copy_json}

Verify Employees Create With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    ${employee}
    ${resp} =   Create Employees   ${employee}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Employees Update With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    ${account}    &{fields}
    ${emp_id}=    Create Test Employee
    ${update_data} =    Create Dictionary    &{UPDATE_EMPLOYEE}    emp_id=${emp_id}    &{fields}
    ${resp} =    Update employees    ${update_data}    ${account}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Employees Update By Different Roles
    [Arguments]    ${account}
    ${emp_id}=    Create Test Employee
    ${resp_add_data} =    Get Employees By Emp Id    ${emp_id}

    ${random_string} =    Generate Random String    10    [STRINGS]
    ${changed_fields} =    Create Dictionary
    ...    first_name=${random_string}
    ...    middle_name=${random_string}
    ...    last_name=${random_string}
    ...    legal_first_name=${random_string}
    ...    legal_middle_name=${random_string}
    ...    legal_last_name=${random_string}
    ...    profile_id=${random_string}
    ...    mobile_phone=${random_string}
    ...    email=${random_string}
    ...    password=${random_string}
    ...    contact_address=${random_string}
    ...    contact_zip=${random_string}
    ...    job_title=${random_string}
    ...    job_duty=${random_string}
    ...    job_code=${STORE_OWNER}
    ...    gender=${FEMALE}
    ...    emp_date=${BEFORE_7_DAYS}
    ...    terminate_date=${AFTER_7_DAYS}
    ...    security_key=${random_string}
    ...    status=${TERMINATED}
    ...    password_force_update=1

    ${update_data} =    Create Dictionary    &{UPDATE_EMPLOYEE}    emp_id=${emp_id}    &{changed_fields}
    ${resp} =    Update employees    ${update_data}    account=${account}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected     ${resp.json()['code']}    0

    ${expected_result} =    Create Dictionary    &{resp_add_data.json()["data"][0]}    &{changed_fields}
    ...    contract_address=${changed_fields['contact_address']}
    ...    contract_zip=${changed_fields['contact_zip']}
    ...    employee_date=${changed_fields['emp_date']}
    ...    enable_security_key=${True}

    ${resp} =    Get Employees By Emp Id    ${emp_id}
    Verify Update Employee Basic Fields As Expected    ${resp.json()["data"][0]}    ${expected_result}
    Should Be Equal As Integers      ${resp.json()["data"][0]["terminate_date"]}         ${expected_result["terminate_date"]}

Verify Employees Get By Argument
    [Arguments]    ${employee}
    ${get_resp}=    Get Employees    ${employee}
    Verify Get Employees    ${get_resp}

Setup Get Employee
    Test Setup
    ${emp_id} =           Create Test Employee
    ${test_employee} =    Get Employees By Emp Id    ${emp_id}

    ${get_emp_by_department_id} =        Copy And Modify JSON    ${GET_EMPLOYEE}    department_id         ${test_employee.json()['data'][0]['department_id']}

    ${department_id_list} =    Create List    ${test_employee.json()['data'][0]['department_id']}
    Set Test Variable    ${department_id_list}
    ${get_emp_by_department_id_list} =   Copy And Modify JSON    ${GET_EMPLOYEE}    department_id_list    ${department_id_list}
    
    ${get_emp_by_emp_id} =               Copy And Modify JSON    ${GET_EMPLOYEE}    emp_id                ${test_employee.json()['data'][0]['emp_id']}
    ${get_emp_by_emp_code} =             Copy And Modify JSON    ${GET_EMPLOYEE}    emp_code              ${test_employee.json()['data'][0]['emp_code']}
    ${get_emp_by_emp_job_code} =         Copy And Modify JSON    ${GET_EMPLOYEE}    emp_job_code          ${test_employee.json()['data'][0]['job_code']}
    ${get_emp_by_first_name} =           Copy And Modify JSON    ${GET_EMPLOYEE}    first_name            ${test_employee.json()['data'][0]['first_name']}
    ${get_emp_by_middle_name} =          Copy And Modify JSON    ${GET_EMPLOYEE}    middle_name           ${test_employee.json()['data'][0]['middle_name']}
    ${get_emp_by_last_name} =            Copy And Modify JSON    ${GET_EMPLOYEE}    last_name             ${test_employee.json()['data'][0]['last_name']}
    ${get_emp_by_legal_first_name} =     Copy And Modify JSON    ${GET_EMPLOYEE}    legal_first_name      ${test_employee.json()['data'][0]['legal_first_name']}
    ${get_emp_by_legal_middle_name} =    Copy And Modify JSON    ${GET_EMPLOYEE}    legal_middle_name     ${test_employee.json()['data'][0]['legal_middle_name']}
    ${get_emp_by_legal_last_name} =      Copy And Modify JSON    ${GET_EMPLOYEE}    legal_last_name       ${test_employee.json()['data'][0]['legal_last_name']}
    ${get_emp_by_profile_id} =           Copy And Modify JSON    ${GET_EMPLOYEE}    profile_id            ${test_employee.json()['data'][0]['profile_id']}
    ${get_emp_by_mobile_phone} =         Copy And Modify JSON    ${GET_EMPLOYEE}    mobile_phone          ${test_employee.json()['data'][0]['mobile_phone']}
    ${get_emp_by_email} =                Copy And Modify JSON    ${GET_EMPLOYEE}    email                 ${test_employee.json()['data'][0]['email']}
    ${get_emp_by_job_title} =            Copy And Modify JSON    ${GET_EMPLOYEE}    job_title             ${test_employee.json()['data'][0]['job_title']}
    ${get_emp_by_job_code} =             Copy And Modify JSON    ${GET_EMPLOYEE}    job_code              ${test_employee.json()['data'][0]['job_code']}
    ${get_emp_by_status} =               Copy And Modify JSON    ${GET_EMPLOYEE}    status                ${test_employee.json()['data'][0]['status']}

    Set Test Variable    ${get_emp_by_department_id}
    Set Test Variable    ${get_emp_by_department_id_list}
    Set Test Variable    ${get_emp_by_emp_id}
    Set Test Variable    ${get_emp_by_emp_code}
    Set Test Variable    ${get_emp_by_emp_job_code}
    Set Test Variable    ${get_emp_by_first_name}
    Set Test Variable    ${get_emp_by_middle_name}
    Set Test Variable    ${get_emp_by_last_name}
    Set Test Variable    ${get_emp_by_legal_first_name}
    Set Test Variable    ${get_emp_by_legal_middle_name}
    Set Test Variable    ${get_emp_by_legal_last_name}
    Set Test Variable    ${get_emp_by_profile_id}
    Set Test Variable    ${get_emp_by_mobile_phone}
    Set Test Variable    ${get_emp_by_email}
    Set Test Variable    ${get_emp_by_job_title}
    Set Test Variable    ${get_emp_by_job_code}
    Set Test Variable    ${get_emp_by_status}
