*** Keywords ***
# -------- Gogoro Keywords --------
Get Departments By Department Id
    [Documentation]    Get departments info with department_id
    [Arguments]    ${department_id}
    ${resp} =    Departments Get    ${None}    ${department_id}
    [Return]    ${resp}

Get Departments By Department Type
    [Documentation]    Get departments info with department_type
    [Arguments]    ${department_type}
    ${resp} =    Departments Get    department_type=${department_type}
    [Return]    ${resp}

Get Departments
    [Documentation]    Get Departments
    [Arguments]    ${department}    ${account}
    ${resp} =    Departments Get
    ...    ${department['company_id']}\
    ...    ${department['department_id']}\
    ...    ${department['department_code']}\
    ...    ${department['department_name']}\
    ...    ${department['department_type']}
    ...    ${department['country_code']}\
    ...    ${department['status']}
    ...    ${department['pagination_criteria']}
    ...    ${account}\
    [Return]    ${resp}

Create Departments
    [Documentation]    Create Departments
    [Arguments]    ${department}

    ${resp} =    Departments Add
    ...    ${department['department_code']}\
    ...    ${department['department_name']}\
    ...    ${department['department_type']}\
    ...    ${department['owner_company_id']}\
    ...    ${department['contract_start_date']}
    ...    ${department['contract_expiration_date']}
    ...    ${department['contact_address']}\
    ...    ${department['contact_zip']}\
    ...    ${department['contact_person']}\
    ...    ${department['contact_email']}\
    ...    ${department['contact_phone1']}\
    ...    ${department['contact_phone2']}\
    ...    ${department['country_code']}\
    ...    ${department['status']}
    [Return]    ${resp}


Update Departments
    [Documentation]    Update Departments
    [Arguments]    ${department}
    ${resp} =    Departments Update
    ...    ${department['department_id']}\
    ...    ${department['department_code']}\
    ...    ${department['department_name']}\
    ...    ${department['department_type']}\
    ...    ${department['contract_start_date']}
    ...    ${department['contract_expiration_date']}
    ...    ${department['contact_address']}\
    ...    ${department['contact_zip']}\
    ...    ${department['contact_person']}\
    ...    ${department['contact_email']}\
    ...    ${department['contact_phone1']}\
    ...    ${department['contact_phone2']}\
    ...    ${department['country_code']}\
    ...    ${department['status']}
    [Return]    ${resp}

Create Departments For Hierarchy
    [Documentation]    Create Departments For Hierarchy
    [Arguments]    ${department}
    ${resp} =    Departments Add
    ...    ${department.department_code}\
    ...    ${department.department_name}\
    ...    ${department.department_type}\
    ...    ${department.owner_company_id}\
    ...    ${department.contract_start_date}
    ...    ${department.contract_expiration_date}
    ...    ${department.contact_address}\
    ...    ${department.contact_zip}\
    ...    ${department.contact_person}\
    ...    ${department.contact_email}\
    ...    ${department.contact_phone1}\
    ...    ${department.contact_phone2}\
    ...    ${department.country_code}\
    ...    ${department.status}
    
    [Return]    ${resp.json()['data'][0]['department_id']}

# -------- Verify Keywords --------
Verify Create Department Data As Expected
    [Documentation]    Verify the create department data
    [Arguments]    ${resp_data}    ${department}

    Should Be Equal As Strings       ${resp_data['department_code']}    ${department['department_code']}
    Should Be Equal As Strings       ${resp_data['department_name']}    ${department['department_name']}
    Should Be Equal As Strings       ${resp_data['contact_email']}      ${department['contact_email']}
    Lists Should Be Equal            ${resp_data['department_type']}    ${department['department_type']}
    Verify Response Data Not None    ${resp_data["company_id"]}
    Verify Response Data Not None    ${resp_data["department_id"]}
    Verify Response Data Not None    ${resp_data["company_name"]}
    Verify Response Data Not None    ${resp_data["company_type"]}
    Verify Response Data Not None    ${resp_data["country_name"]}


Verify Update Department Data As Expected
    [Documentation]    Verify the update department data
    [Arguments]    ${resp_data}    ${department}

    Should Be Equal As Strings       ${resp_data['department_name']}    ${department['department_name']}
    Should Be Equal As Strings       ${resp_data['contact_address']}    ${department['contact_address']}
    Should Be Equal As Strings       ${resp_data['country_code']}       ${department['country_code']}
    Lists Should Be Equal            ${resp_data['department_type']}    ${department['department_type']}
    Verify Response Data Not None    ${resp_data['department_code']}
    Verify Response Data Not None    ${resp_data['department_name']}
    Verify Response Data Not None    ${resp_data['department_type']}
    Verify Response Data Not None    ${resp_data['contact_address']}
    Verify Response Data Not None    ${resp_data['contact_zip']}
    Verify Response Data Not None    ${resp_data['contact_person']}
    Verify Response Data Not None    ${resp_data['contact_email']}
    Verify Response Data Not None    ${resp_data['contact_phone1']}
    Verify Response Data Not None    ${resp_data['contact_phone2']}
    Verify Response Data Not None    ${resp_data["company_id"]}
    Verify Response Data Not None    ${resp_data["department_id"]}
    Verify Response Data Not None    ${resp_data["company_name"]}
    Verify Response Data Not None    ${resp_data["company_type"]}
    Verify Response Data Not None    ${resp_data["country_name"]}

Verify Get Department Data As Expected With Specified Department Type
    [Documentation]    Verify the get department data
    [Arguments]    ${resp_data}    ${department_type}
    FOR    ${Item}    IN     @{resp_data.json()["data"]}
        List Should Contain Value    ${Item["department_type"]}    ${department_type}    
    END
