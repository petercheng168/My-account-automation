*** Keywords ***
# -------- MyGogoro Keywords --------
Save User Detail As Subscriber
    [Documentation]    Save user detail as subscriber
    [Arguments]    ${gender}    ${first_name}    ${last_name}    ${birthday}    ${id_number}    ${mobile}    ${invoice_city}    ${invoice_district}    ${invoice_zipcode}    ${invoice_address}    ${contact_city}    ${contact_district}    ${contact_zipcode}    ${contact_address}    ${gogoro-sess}    ${csrf_token}
    ${resp} =    Api My Subscription Draft Subscriber Put    ${gender}    ${first_name}\
    ...    ${last_name}    ${birthday}    ${id_number}    ${mobile}    ${invoice_city}\
    ...    ${invoice_district}    ${invoice_zipcode}    ${invoice_address}\
    ...    ${contact_city}    ${contact_district}    ${contact_zipcode}\
    ...    ${contact_address}    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   201

# -------- Verify Keywords --------