*** Keywords ***
# -------- Gogoro Keywords --------
Create Contract User
    [Documentation]    Create user with User object variable
    [Arguments]    ${User}    ${user_type}=${3}    ${status}=${1}
    ${resp} =    Contract Users Post    ${User.first_name}    ${User.last_name}    ${user_type}    ${User.gender}    ${User.birthday}    ${User.email}    ${User.country_code}
    ...    ${User.mobile}    ${User.profile_id}    ${status}    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zip}
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zip}
    [Return]    ${resp.json()['data'][0]['user_id']}

# -------- Verify Keywords --------
Verify Contract User Information As Expected
    [Documentation]    Verify the contract user data
    [Arguments]    ${resp}    ${contract_user_id}    ${User}    ${gender}=${User.gender}    ${country_code}=${User.country_code}\
    ...    ${first_name}=${User.first_name}    ${profile_id}=${User.profile_id}    ${invoice_address}=${User.invoice_address}\
    ...    ${invoice_district}=${User.invoice_district}    ${invoice_city}=${User.invoice_city}
    Verify Response Contains Expected    ${resp.json()['data'][0]['country_code']}    ${country_code}
    Verify Response Contains Expected    ${resp.json()['data'][0]['first_name']}    ${first_name}
    Verify Response Contains Expected    ${resp.json()['data'][0]['gender']}    ${gender}
    Verify Response Contains Expected    ${resp.json()['data'][0]['invoice_address']}    ${invoice_address}
    Verify Response Contains Expected    ${resp.json()['data'][0]['invoice_district']}    ${invoice_district}
    Verify Response Contains Expected    ${resp.json()['data'][0]['invoice_city']}    ${invoice_city}
    Verify Response Contains Expected    ${resp.json()['data'][0]['user_id']}    ${contract_user_id}
