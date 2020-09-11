*** Keywords ***
# -------- Sales Portal Keywords --------
Login Buyer Account
    [Documentation]    Get user guid with email and phone last 4 number
    [Arguments]    ${email}    ${phone}    ${token}
    ${resp} =    Utility Get Dp User Data Post    ${email}    ${phone}    token=${token}
    [Return]    ${resp.json()['Data']['Id']}
