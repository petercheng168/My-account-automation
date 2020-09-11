*** Keywords ***
# -------- Gogoro Keywords --------
# -------- Verify Keywords --------
Verify Site Maps Response As Expected
    [Documentation]    Filter site maps response via service type
    [Arguments]    ${resp_data}    ${service_type}    ${url}
    ${site_data} =    Evaluate    list(filter((lambda i: "${service_type}" == i["service_type"]), ${resp_data}))[0]    re
    Should Be Equal As Strings    ${site_data['site_type']}    1
    Should Be Equal As Strings    ${site_data['site_url']}     ${url}