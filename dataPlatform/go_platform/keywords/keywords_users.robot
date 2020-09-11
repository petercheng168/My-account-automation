*** Keywords ***
# -------- Gogoro Keywords --------
Create User
    [Documentation]    Create user with User object variable
    [Arguments]    ${User}
    ${resp} =    Users Post
    ...    ${User.company_code}    ${User.first_name}    ${User.gender}
    ...    ${User.email}           ${User.status}
    ...    ${User.enable_e_carrier}
    ...    invoice_address=${User.invoice_address}
    ...    invoice_district=${User.invoice_district}
    ...    invoice_city=${User.invoice_city}
    ...    gogoro_guid=${User.gogoro_guid}
    ...    profile_id=${User.profile_id}
    ...    password=${User.encode_password}
    Users Update Email Verified    ${resp.json()['data'][0]['user_id']}    1
    [Return]    ${resp.json()['data'][0]['user_id']}

# -------- Verify Keywords --------
Verify User Field Is Expected Via Email
    [Documentation]    Verify the user field is expected
    [Arguments]    ${user_email}    ${request_data_type}    ${field}    ${value}
    ${resp} =    Users Get Email    ${user_email}    ${request_data_type}
    Verify Response Contains Expected    ${resp.json()['data'][0]['${field}']}    ${value}

Verify User Schema Is Expected
    [Documentation]    Verify the user schema is expected
    [Arguments]    ${user_email}    ${request_data_type}    ${schema_file}    ${schema}
    ${resp} =    Users Get Email    ${user_email}    ${request_data_type}
    Verify Schema    ${schema_file}    ${schema}    ${resp.json()}