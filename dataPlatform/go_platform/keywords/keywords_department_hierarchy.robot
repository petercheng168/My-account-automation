*** Keywords ***
# -------- Gogoro Keywords --------    
Update Department Hierarchy
    [Documentation]    Update Department Hierarchy
    [Arguments]    ${department_hierarchy}    ${account}=None
    ${resp} =    Department Hierarchy Update   
    ...    ${department_hierarchy['department_id']}\    
    ...    ${department_hierarchy['origin_parent_department_id']}\
    ...    ${department_hierarchy['target_parent_department_id']}\
    ...    ${account}\
    [Return]    ${resp}    
    
Get Department Hierarchy
    [Documentation]    Get Department Hierarchy
    [Arguments]    ${department_hierarchy}    ${account}=None
    ${resp} =    Department Hierarchy Get  
    ...    ${department_hierarchy['target_company_id']}\
    ...    ${department_hierarchy['underneath_department_id']}\
    ...    ${department_hierarchy['department_type']}\  
    ...    ${account}\    
    [Return]    ${resp}
    
# -------- Verify Keywords --------    
Verify Create Department Hierarchy As Expected
    [Documentation]    Verify the create department hierarchy
    [Arguments]    ${resp_data}    ${department_hierarchy}
    
    Should Be Equal As Strings    ${resp_data['department_id']}    ${department_hierarchy['department_id']}
    Should Be Equal As Strings    ${resp_data['parent_department_id']}    ${department_hierarchy['target_parent_department_id']}
 
Verify Get Department Hierarchy
    [Documentation]    Verify the get department hierarchy
    [Arguments]    ${resp}
    ${length}=     Get Length    ${resp.json()["data"]}
    Should Be True    ${length} > 0