*** Keywords ***
# -------- Gogoro Keywords --------
Create Companies
    [Documentation]    Create companies
    [Arguments]    ${Company}
    ${resp} =    Companies Post
    ...    ${Company.company_code}\
    ...    ${Company.company_name}\
    ...    ${Company.brand_name}\
    ...    ${Company.address}\
    ...    ${Company.zip_code}\
    ...    ${Company.country_code}\
    ...    ${Company.contact_person_firstname}\
    ...    ${Company.contact_person_lastname}\
    ...    ${Company.contact_email}\
    ...    ${Company.contact_phone1}\
    ...    ${Company.contact_phone2}\
    ...    ${Company.company_type}\
    ...    ${Company.company_sub_type}\
    ...    ${Company.company_group_id}\
    ...    ${Company.status}
    [Return]    ${resp.json()['data'][0]['company_id']}

# -------- Verify Keywords --------
Verify Company Data As Expected
    [Documentation]    Verify the company data
    [Arguments]    ${resp}    ${Company}    ${company_name}=${Company.company_name}
    ...    ${brand_name}=${Company.brand_name}
    ...    ${address}=${Company.address}    ${zip_code}=${Company.zip_code}
    ...    ${country_code}=${Company.country_code}    ${status}=${Company.status}
    Verify Response Contains Expected    ${resp["company_id"]}      ${Company.company_id}
    Verify Response Contains Expected    ${resp["code"]}            ${Company.company_code}
    Verify Response Contains Expected    ${resp["name"]}            ${company_name}
    Verify Response Contains Expected    ${resp["brand_name"]}      ${brand_name}
    Verify Response Contains Expected    ${resp["address"]}         ${address}
    Verify Response Contains Expected    ${resp["zip"]}             ${zip_code}
    Verify Response Contains Expected    ${resp["country_code"]}    ${country_code}
    Verify Response Contains Expected    ${resp["status"]}          ${status}
