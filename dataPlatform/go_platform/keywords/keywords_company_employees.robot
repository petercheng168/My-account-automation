*** Keywords ***
# -------- Gogoro Keywords --------
Get Employees By Emp Id
    [Documentation]    Get employees info by emp_id
    [Arguments]    ${emp_id}    ${account}=${None}
    ${resp} =    Employees Get By Emp Id    ${emp_id}    ${account}
    [Return]    ${resp}

Get Employees
    [Documentation]    Get employees 
    [Arguments]    ${get_data}    ${account}=${None}
    ${dict} =    Create Dictionary    &{get_data}    account=${account}    
    ${resp} =    Employees Get    &{dict}
    [Return]    ${resp}
    
Create employees
    [Documentation]    Create employees
    [Arguments]    ${add_data}    ${account}=${None}
    ${dict} =    Create Dictionary    &{add_data}    account=${account}    
    ${resp} =    Employees Add    &{dict}
    [Return]    ${resp}

Update employees
    [Documentation]    Update employees
    [Arguments]    ${update_data}    ${account}=${None}   
    ${dict} =    Create Dictionary    &{update_data}    account=${account}    
    ${resp} =    Employees Update    &{dict}
    [Return]    ${resp}
        
# -------- Verify Keywords --------    
Verify Create Employee As Expected With Admin Account 
    [Documentation]    Verify the created employee data
    [Arguments]    ${resp}    ${employee}   

    Should Be Equal As Strings    ${resp['department_id']}    ${employee['department_id']}
    Should Be Equal As Strings    ${resp['first_name']}    ${employee['first_name']}
    Should Be Equal As Strings    ${resp['middle_name']}    ${employee['middle_name']}
    Should Be Equal As Strings    ${resp['last_name']}    ${employee['last_name']}
    Should Be Equal As Strings    ${resp['legal_first_name']}    ${employee['legal_first_name']}
    Should Be Equal As Strings    ${resp['legal_middle_name']}    ${employee['legal_middle_name']}
    Should Be Equal As Strings    ${resp['legal_last_name']}    ${employee['legal_last_name']}
    Should Be Equal As Strings    ${resp['profile_id']}    ${employee['profile_id']}
    Should Be Equal As Strings    ${resp['mobile_phone']}    ${employee['mobile_phone']}
    Should Be Equal As Strings    ${resp['email']}    ${employee['email']}
    Should Be Equal As Strings    ${resp['password']}    ${employee['password']}
    Should Be Equal As Strings    ${resp['contract_address']}    ${employee['contact_address']}
    Should Be Equal As Strings    ${resp['job_title']}    ${employee['job_title']}
    Should Be Equal As Strings    ${resp['job_duty']}    ${employee['job_duty']}
    Should Be Equal As Strings    ${resp['job_code']}    ${employee['job_code']}
    Should Be Equal As Integers    ${resp['status']}    ${1}
    Should Be Equal As Strings    ${resp['gender']}    ${employee['gender']}
    Should Be Equal As Strings    ${resp['employee_date']}    ${employee['emp_date']}
    Should Be Equal    ${resp['enable_security_key']}    ${false}
    Verify Response Data Not None    ${resp["emp_id"]}
    Verify Response Data Not None    ${resp["emp_code"]}
    Verify Response Data Not None    ${resp["company_id"]}
    Verify Response Data Not None    ${resp["company_name"]}      
    Verify Response Data Not None    ${resp["company_type"]}
    Verify Response Data Not None    ${resp["department_name"]}
    Verify Response Data Not None    ${resp["update_time"]}    
    Verify Response Data Not None    ${resp["create_time"]}
    Verify Response Data Not None    ${resp["password_force_update"]}
    Verify Response Data Not None    ${resp["password_update_time"]}
    
Verify Update Employee Basic Fields As Expected 
    [Documentation]    Verify Update Employee As Expected With Admin Account
    [Arguments]    ${resp}    ${expected_result}   
    Should Be Equal As Strings       ${resp["emp_id"]}                 ${expected_result["emp_id"]}
    Should Be Equal As Strings       ${resp["company_id"]}             ${expected_result["company_id"]}
    Should Be Equal As Strings       ${resp["company_name"]}           ${expected_result["company_name"]}
    Should Be Equal As Integers      ${resp["company_type"]}           ${expected_result["company_type"]}
    Should Be Equal As Strings       ${resp["department_id"]}          ${expected_result["department_id"]}
    Should Be Equal As Strings       ${resp["department_name"]}        ${expected_result["department_name"]}
    Should Be Equal As Strings       ${resp["emp_code"]}               ${expected_result["emp_code"]}
    Should Be Equal As Strings       ${resp["first_name"]}             ${expected_result["first_name"]}
    Should Be Equal As Strings       ${resp["middle_name"]}            ${expected_result["middle_name"]}
    Should Be Equal As Strings       ${resp["last_name"]}              ${expected_result["last_name"]}
    Should Be Equal As Strings       ${resp["legal_first_name"]}       ${expected_result["legal_first_name"]}
    Should Be Equal As Strings       ${resp["legal_middle_name"]}      ${expected_result["legal_middle_name"]}
    Should Be Equal As Strings       ${resp["legal_last_name"]}        ${expected_result["legal_last_name"]}
    Should Be Equal As Strings       ${resp["profile_id"]}             ${expected_result["profile_id"]}
    Should Be Equal As Strings       ${resp["mobile_phone"]}           ${expected_result["mobile_phone"]}
    Should Be Equal As Strings       ${resp["email"]}                  ${expected_result["email"]}
    Should Be Equal As Strings       ${resp["password"]}               ${expected_result["password"]}
    Should Be Equal As Strings       ${resp["contract_address"]}       ${expected_result["contract_address"]}
    Should Be Equal As Strings       ${resp["contract_zip"]}           ${expected_result["contract_zip"]}
    Should Be Equal As Strings       ${resp["job_title"]}              ${expected_result["job_title"]}
    Should Be Equal As Strings       ${resp["job_duty"]}               ${expected_result["job_duty"]}
    Should Be Equal As Integers      ${resp["job_code"]}               ${expected_result["job_code"]}
    Should Be Equal As Integers      ${resp["status"]}                 ${expected_result["status"]}
    Should Be Equal As Strings       ${resp["gender"]}                 ${expected_result["gender"]}
    Should Be Equal As Integers      ${resp["employee_date"]}          ${expected_result["employee_date"]}
    Verify Response Data Not None    ${resp["update_time"]}
    Should Be Equal As Integers      ${resp["create_time"]}            ${expected_result["create_time"]}
    Should Be Equal                  ${resp["enable_security_key"]}    ${expected_result["enable_security_key"]}  

Verify Get Employees
    [Documentation]    Verify Get employee data
    [Arguments]    ${resp}
    Verify Status Code As Expected  ${resp}  200
    Should Be True    ${resp.json()["total_count"]} > 0