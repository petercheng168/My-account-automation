*** Keywords ***
# -------- MyGogoro Elements -------- #
# Input User Mail
#     [Documentation]    Input user email at login page
#     [Arguments]    ${email}
#     Wait Until Element Is Enabled    //input[@type="text"][@name="email"]
#     Input Text    //input[@type="text"][@name="email"]    ${email}
    

# Input User Passwords
#     [Documentation]    Input user password at login page
#     [Arguments]    ${password}
#     Wait Until Element Is Enabled    //input[@type="password"][@name="password"]
#     Input Text    //input[@type="password"][@name="password"]    ${password}

# # -------- MyGogoro Keywords --------
# Login With Email And Password
#     [Documentation]    Login My Account domain with user email and password
#     [Arguments]    ${email}    ${password}
#     Input User Mail    ${email}
#     Input User Passwords    ${password}
#     Click Rounded Button    登入
#     Wait Until Location Is    https://${MYGOGORO_GN_HOST}/new-sub    30s

# -------- Verify Keywords --------