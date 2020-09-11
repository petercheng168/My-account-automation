*** Settings ***
Documentation    Test suite of department-hierarchy
Resource    ../init.robot

Force Tags    Department-hierarchy
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${CREATE_DEPARTMENT_SUCCESS}= 
...     {
...       "department_code": "DH_",
...       "department_name": "DH_",
...       "owner_company_id": null,
...       "department_type": "1",
...       "contact_address": null,
...       "contact_zip": null,
...       "contact_person": null,
...       "contact_email": null,
...       "contact_phone1": null,
...       "contact_phone2": null,
...       "country_code": "TW",
...       "status": 1
...     }

${GET_DEPARTMENT_HIERARCHY}=
...     {
...       "target_company_id": null,
...       "underneath_department_id": null,
...       "department_type": null
...     }

${DEFAULT_DEPARTMENT_HIERARCHY}=
...     {
...       "department_id": null,
...       "origin_parent_department_id": null,
...       "target_parent_department_id": null
...     }

*** Test Cases ***
department-hierarchy - create - success case
    [Setup]    Test Setup
    
    ${add_resp}=    Create Test Department Hierarchy
    
    Verify Status Code As Expected  ${add_resp}  200
    Verify Create Department Hierarchy As Expected    ${add_resp.json()['data'][0]}    ${SUCCESS_CREATE_DEPARTMENT_HIERARCHY}
    
department-hierarchy - get - success case
    [Setup]    Setup Get Department Hierarchy
    
    [Template]   Verify Department Hierarchy Get By Argument
    ${get_Department_Hierarchy_by_company_id}
    #${get_Department_Hierarchy_by_underneath_department_id}
    #${get_Department_Hierarchy_by_department_type}    
    
department-hierarchy - delete - success case
    [Setup]    Test Setup
    
    ${add_resp}=    Create Test Department Hierarchy
    
    Verify Status Code As Expected  ${add_resp}  200
    Verify Create Department Hierarchy As Expected    ${add_resp.json()['data'][0]}    ${SUCCESS_CREATE_DEPARTMENT_HIERARCHY}
    
    Set To Dictionary    ${SUCCESS_DELETE_DEPARTMENT_HIERARCHY}   department_id=${SUCCESS_CREATE_DEPARTMENT_HIERARCHY['department_id']}\
    ...    origin_parent_department_id=${SUCCESS_CREATE_DEPARTMENT_HIERARCHY['target_parent_department_id']}\
    
    ${delete_resp}=    Update Department Hierarchy    ${SUCCESS_DELETE_DEPARTMENT_HIERARCHY}
    Verify Status Code As Expected  ${delete_resp}  200
    
    
*** Keywords ***
Test Setup
    
    ${SUCCESS_DEPARTMENT}=    evaluate    json.loads('''${CREATE_DEPARTMENT_SUCCESS}''')    json
    ${SUCCESS_GET_DEPARTMENT_HIERARCHY}=    evaluate    json.loads('''${GET_DEPARTMENT_HIERARCHY}''')    json
    ${SUCCESS_CREATE_DEPARTMENT_HIERARCHY}=    evaluate    json.loads('''${DEFAULT_DEPARTMENT_HIERARCHY}''')    json
    ${SUCCESS_DELETE_DEPARTMENT_HIERARCHY}=     evaluate    json.loads('''${DEFAULT_DEPARTMENT_HIERARCHY}''')    json
    ${SUCCESS_UPDATE_DEPARTMENT_HIERARCHY}=     evaluate    json.loads('''${DEFAULT_DEPARTMENT_HIERARCHY}''')    json
    
    Set Test Variable    ${SUCCESS_DEPARTMENT}
    Set Test Variable    ${SUCCESS_CREATE_DEPARTMENT_HIERARCHY}
    Set Test Variable    ${SUCCESS_GET_DEPARTMENT_HIERARCHY}
    Set Test Variable    ${SUCCESS_DELETE_DEPARTMENT_HIERARCHY}
    Set Test Variable    ${SUCCESS_UPDATE_DEPARTMENT_HIERARCHY}
    
Create Test Department
    Test Setup
    
    ${time_stamp}=    evaluate    int(round(time.time() * 1000))    time
    ${department_code}=    Format String    {}{}    ${SUCCESS_DEPARTMENT['department_code']}    ${time_stamp}
    ${department_name}=    Format String    {}{}   ${SUCCESS_DEPARTMENT['department_name']}    ${time_stamp}
    ${contact_email}=    Format String    {}+{}@gogoro.com   ${SUCCESS_DEPARTMENT['contact_email']}    ${time_stamp}
    ${contract_expiration_date}=    evaluate    int(round(time.time() * 1000 + 60000))    time
    
    Set To Dictionary    ${SUCCESS_DEPARTMENT}    department_code=${department_code}\
    ...     department_name=${department_name}\
    ...     contact_email=${contact_email}\
    ...     contract_start_date=${time_stamp}
    ...     contract_expiration_date=${contract_expiration_date}
    
    ${create_resp}=    Create Departments    ${SUCCESS_DEPARTMENT}
    Verify Status Code As Expected  ${create_resp}  200
    
    ${department_id}=    Set Variable    ${create_resp.json()['data'][0]['department_id']}
    [return]     ${department_id}

Create Test Department Hierarchy
    Test Setup
    
    ${parent_department_id}=    Create Test Department
    ${child_department_id}=    Create Test Department
    
    Set To Dictionary    ${SUCCESS_CREATE_DEPARTMENT_HIERARCHY}    target_parent_department_id=${parent_department_id}\
    ...    department_id=${child_department_id}
    
    ${add_resp}=    Update Department Hierarchy    ${SUCCESS_CREATE_DEPARTMENT_HIERARCHY}
    [return]     ${add_resp}
     
Copy And Modify JSON
    [Arguments]    ${json}    ${key}    ${value}
    ${copy_json}=    Copy Dictionary    ${json}
    Set To Dictionary    ${copy_json}    ${key}=${value}
    [return]     ${copy_json}
    
Setup Get Department Hierarchy
    Test Setup
    
    ${add_resp}=    Create Test Department Hierarchy
    
    ${parent_department_id}=    Set Variable    ${add_resp.json()['data'][0]['parent_department_id']}
    ${department_id}=    Set Variable    ${add_resp.json()['data'][0]['department_id']}
    
    ${get_resp}=    Get Departments By Department Id    ${parent_department_id}
    ${company_id}=    Set Variable    ${get_resp.json()['data'][0]['company_id']}

    ${get_Department_Hierarchy_by_company_id}=    Copy And Modify JSON    ${SUCCESS_GET_DEPARTMENT_HIERARCHY}    target_company_id    ${company_id}
    ${get_Department_Hierarchy_by_underneath_department_id}=    Copy And Modify JSON    ${SUCCESS_GET_DEPARTMENT_HIERARCHY}    underneath_department_id    ${parent_department_id}
    ${get_Department_Hierarchy_by_department_type}=    Copy And Modify JSON    ${SUCCESS_GET_DEPARTMENT_HIERARCHY}    department_type    ${1}

    Set Test Variable    ${get_Department_Hierarchy_by_company_id}
    Set Test Variable    ${get_Department_Hierarchy_by_underneath_department_id}
    Set Test Variable    ${get_Department_Hierarchy_by_department_type}
    
Verify Department Hierarchy Get By Argument
    [Arguments]    ${department_hierarchy}
    ${get_resp}=    Get Department Hierarchy    ${department_hierarchy}
    Verify Get Department Hierarchy    ${get_resp}