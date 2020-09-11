*** Settings ***
Documentation    Test suite of department
Resource    ../init.robot

Force Tags    Departments
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${CREATE_DEPARTMENT_SUCCESS}=        
...     {
...       "department_code": "SWQA",
...       "department_name": "SWQA",
...       "owner_company_id": null,
...       "department_type": [1,2],
...       "contact_address": "長安東路二段225號C棟11樓",
...       "contact_zip": "10552",
...       "contact_person": "SWQA",
...       "contact_email": "sw.verify",
...       "contact_phone1": "0912345678",
...       "contact_phone2": "0987654321",
...       "country_code": "TW",
...       "status": 1
...     }

${CREATE_DEPARTMENT_FAIL_DUPLICATE}=        
...     {
...       "department_code": "DEP1300",
...       "department_name": "SWQA",
...       "owner_company_id": null,
...       "department_type": [1,2],
...       "contact_address": "長安東路二段225號C棟11樓",
...       "contact_zip": "10552",
...       "contact_person": null,
...       "contact_email": "sw.verify",
...       "contact_phone1": "0912345678",
...       "contact_phone2": "0987654321",
...       "country_code": "TW",
...       "status": 1
...     }

${UPDATE_DEPARTMENT_SUCCESS}=        
...     {
...       "department_name": "update",
...       "owner_company_id": null,
...       "department_type": [1],
...       "contact_address": "",
...       "contact_zip": null,
...       "contact_person": "update",
...       "contract_start_date": null,
...       "contract_expiration_date": null,
...       "contact_email": null,
...       "contact_phone1": null,
...       "contact_phone2": null,
...       "country_code": "JP",
...       "status": 1
...     }

*** Test Cases ***
departments - create - success case
    [Setup]    Test Setup
    
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

    ${get_resp} =    Get Departments By Department Id    ${department_id} 

    Verify Status Code As Expected  ${get_resp}  200
    Verify Create Department Data As Expected    ${get_resp.json()["data"][0]}    ${SUCCESS_DEPARTMENT}

    Set Global Variable    ${department_id}

departments - create - success case with department_type 10 and 11
    [Setup]    Test Setup
    
    ${time_stamp}=    evaluate    int(round(time.time() * 1000))    time
    ${department_code}=    Format String    {}{}    ${SUCCESS_DEPARTMENT['department_code']}    ${time_stamp}
    ${department_name}=    Format String    {}{}   ${SUCCESS_DEPARTMENT['department_name']}    ${time_stamp}
    ${contact_email}=    Format String    {}+{}@gogoro.com   ${SUCCESS_DEPARTMENT['contact_email']}    ${time_stamp}
    ${contract_expiration_date}=    evaluate    int(round(time.time() * 1000 + 60000))    time
    ${department_type_list} =    Create List    ${1}  ${2}  ${10}  ${11}

    Set To Dictionary    ${SUCCESS_DEPARTMENT}    department_code=${department_code}\
    ...     department_name=${department_name}\
    ...     contact_email=${contact_email}\
    ...     contract_start_date=${time_stamp}\
    ...     contract_expiration_date=${contract_expiration_date}\
    ...     department_type=${department_type_list}
    
    ${create_resp}=    Create Departments    ${SUCCESS_DEPARTMENT}
    Verify Status Code As Expected  ${create_resp}  200
    
    ${department_id}=    Set Variable    ${create_resp.json()['data'][0]['department_id']}
    
    ${get_resp} =    Get Departments By Department Id    ${department_id} 
    Verify Status Code As Expected  ${get_resp}  200
    Verify Create Department Data As Expected    ${get_resp.json()["data"][0]}    ${SUCCESS_DEPARTMENT}


departments - add - invalid - create duplicate department code
    [Tags]    FET
    [Setup]    Test Setup
    
    ${time_stamp}=    evaluate    int(round(time.time() * 1000))    time
    ${department_name}=    Format String    {}{}   ${DUPLICATE_DEPARTMENT['department_name']}    ${time_stamp}
    ${contact_email}=    Format String    {}+{}@gogoro.com   ${DUPLICATE_DEPARTMENT['contact_email']}    ${time_stamp}
    ${contract_expiration_date}=    evaluate    int(round(time.time() * 1000 + 60000))    time
    
    Set To Dictionary    ${DUPLICATE_DEPARTMENT}    department_name=${department_name}\
    ...    contact_email=${contact_email}\    contract_start_date=${time_stamp}
    ...    contract_expiration_date=${contract_expiration_date}
    
    ${create_resp}=    Create Departments    ${DUPLICATE_DEPARTMENT}
    
    Verify Status Code As Expected       ${create_resp}    200
    Verify GoPlatform Error Message      ${create_resp}    604040005    Duplicate entry
    
departments - update - success case
    [Setup]    Test Setup   
    
    ${get_resp} =    Get Departments By Department Id    ${department_id} 
    ${department_type_list} =    Create List    ${1}  ${2}  ${10}  ${11}
    
    Set To Dictionary    ${UPDATE_DEPARTMENT}    department_id=${department_id}\
    ...    department_code=${get_resp.json()["data"][0]['department_code']}
    ...    department_type=${department_type_list}
    
    ${update_resp}=    Update Departments    ${UPDATE_DEPARTMENT}
    
    Verify Status Code As Expected  ${get_resp}  200
    Should Be Equal As Strings    ${get_resp.json()["message"]}    success
    
    ${get_resp} =    Get Departments By Department Id    ${department_id}
    
    Verify Update Department Data As Expected    ${get_resp.json()["data"][0]}    ${UPDATE_DEPARTMENT}

departments - get - success case
    [Setup]    Create Department
    [Template]    Verify Get Departments By Department Type
    ${1}
    ${2}
    ${3}
    ${4}
    ${5}
    ${6}
    ${7}
    ${8}
    ${9}
    ${10}
    
*** Keywords ***
Test Setup
    
    ${SUCCESS_DEPARTMENT}=    evaluate    json.loads('''${CREATE_DEPARTMENT_SUCCESS}''')    json
    ${DUPLICATE_DEPARTMENT}=    evaluate    json.loads('''${CREATE_DEPARTMENT_FAIL_DUPLICATE}''')    json    
    ${UPDATE_DEPARTMENT}=    evaluate    json.loads('''${UPDATE_DEPARTMENT_SUCCESS}''')    json    
    
    Set Test Variable    ${SUCCESS_DEPARTMENT}
    Set Test Variable    ${DUPLICATE_DEPARTMENT}
    Set Test Variable    ${UPDATE_DEPARTMENT}

Create Department
    Test Setup

    ${time_stamp}=    evaluate    int(round(time.time() * 1000))    time
    ${department_code}=    Format String    {}{}    ${SUCCESS_DEPARTMENT['department_code']}    ${time_stamp}
    ${department_name}=    Format String    {}{}   ${SUCCESS_DEPARTMENT['department_name']}    ${time_stamp}
    ${contact_email}=    Format String    {}+{}@gogoro.com   ${SUCCESS_DEPARTMENT['contact_email']}    ${time_stamp}
    ${contract_expiration_date}=    evaluate    int(round(time.time() * 1000 + 60000))    time
    ${department_type_list} =    Create List    ${1}  ${2}  ${3}  ${4}  ${5}  ${6}  ${7}  ${8}  ${9}  ${10}

    Set To Dictionary    ${SUCCESS_DEPARTMENT}    department_code=${department_code}\
    ...     department_name=${department_name}\
    ...     contact_email=${contact_email}\
    ...     contract_start_date=${time_stamp}\
    ...     contract_expiration_date=${contract_expiration_date}\
    ...     department_type=${department_type_list}
    
    ${create_resp}=    Create Departments    ${SUCCESS_DEPARTMENT}
    ${department_id}=    Set Variable    ${create_resp.json()['data'][0]['department_id']}

Verify Get Departments By Department Type
	[Arguments]    ${department_type}
    ${get_resp} =    Get Departments By Department Type    ${department_type}
	Verify Status Code As Expected       ${get_resp}    200
	Verify Get Department Data As Expected With Specified Department Type    ${get_resp}    ${department_type}
    