*** Keywords ***
# -------- Gogoro Keywords --------
Create Part
    [Documentation]    Create part
    [Arguments]    ${Part}
    ${resp} =    Parts Post    sequence_id=${Part.sequence_id}    part_code=${Part.part_code}    part_category_type=${Part.part_category_type}\
    ...    part_category_sub_type=${Part.part_category_sub_type}    parts_category_id=${Part.part_category_id}    brand_company_code=${Part.brand_company_code}\
    ...    names=${Part.names}    production_start_time=${Part.production_start_time}    production_end_time=${Part.production_end_time}\    
    ...    sale_status=${Part.sale_status}    sale_suspend_time=${Part.sale_suspend_time}    warranty_period=${Part.warranty_period}\
    ...    warranty_distance=${Part.warranty_distance}    endurance_period=${Part.endurance_period}    endurance_distance=${Part.endurance_distance}\
    ...    prices=${Part.prices}    
    [Return]    ${resp}

Update Part
    [Documentation]    Update part
    [Arguments]    ${Part}
     ${resp} =    Parts Update    sequence_id=${Part.sequence_id}    part_code=${Part.part_code}    part_category_type=${Part.part_category_type}\
    ...    part_category_sub_type=${Part.part_category_sub_type}    parts_category_id=${Part.part_category_id}    brand_company_code=${Part.brand_company_code}\
    ...    names=${Part.names}    production_start_time=${Part.production_start_time}    production_end_time=${Part.production_end_time}\    
    ...    sale_status=${Part.sale_status}    sale_suspend_time=${Part.sale_suspend_time}    warranty_period=${Part.warranty_period}\
    ...    warranty_distance=${Part.warranty_distance}    endurance_period=${Part.endurance_period}    endurance_distance=${Part.endurance_distance}\
    ...    prices=${Part.prices}    
    [Return]    ${resp}

# -------- Verify Keywords --------