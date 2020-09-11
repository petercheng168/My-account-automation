*** Keywords ***
Input Valid Data For Login Page
    [Documentation]    Input Valid Account/Password to login in login page, user already has a valid contract.
    #  Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${DRIVER_PATH}/${DRIVER_VERSION}
    Sleep    1s
    Maximize Browser Window
    #瀏覽器展開至視窗大小
    Input Valid User Email
    Input Valid User Password
    Click Login Button
    Wait Until Location Is    https://pa-network-my.gogoro.com/dashboard    30s

Blank Textbox For Login Page
    [Documentation]    Blank Account/Password to login in login page, user already has a valid contract.
    Sleep    1s
    Maximize Browser Window
    Input Text  //input[@type="password"][@name="password"]     ${PASSWORD1}
    Wait Until Keyword Succeeds    10s    2s   Verfiy Login Username Blank Msg        電子信箱為必填欄位
    Sleep    1s
    Reload Page
    Input Text  //input[@type="text"][@name="email"]     ${MYGOGORO_ACCOUNT}
    Click Login Button
    Wait Until Keyword Succeeds    10s    2s   Verfiy Login Password Blank Msg        密碼為必填欄位

Input Invalid data For Login Page
    [Documentation]    Input Invalid Account/Password to login in login page
    Sleep    1s
    Maximize Browser Window
    Input Text  //input[@type="text"][@name="email"]     ${MYGOGORO_ACCOUNT}+11
    Input Text  //input[@type="password"][@name="password"]     ${PASSWORD1}
    Click Login Button
    Wait Until Keyword Succeeds    10s    2s   Verfiy Invalid Account/Password Msg       請檢查您的帳號或密碼\n確認
    Sleep    1s
    Click Element   //html/body/div/div/div[2]/footer/button
    # Click Submit Type Button    確認

# -------- Verify Keyword -------- #   
Verify Navigate to MyAccount Dashboard After Click Login Button
    Assign Id To Element    //*[@id="app"]    Top_Container
    #將 Top_Container 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  Top_Container   timeout=20
    #等待被指定為 Login_button 的ID 出現,等待時間2秒
    sleep  5s

Verfiy Login Password Blank Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${email_not_register_msg}=    Get Text     //*[@id="app"]/div/div/div/div/div[2]/span
    Should Be Equal As Strings    ${email_not_register_msg}    ${expected}   
Verfiy Login Username Blank Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${email_not_register_msg}=    Get Text     //*[@id="app"]/div/div/div/div/div[1]/span
    Should Be Equal As Strings    ${email_not_register_msg}    ${expected}   

Verfiy Invalid Account/Password Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${email_not_register_msg}=    Get Text     //html/body/div/div/div[2]
    Should Be Equal As Strings    ${email_not_register_msg}    ${expected}  

    

# -------- MyGogoro Elements -------- #
Input Valid User Email
    Assign Id To Element    //*[@id="1val-username"]    Login_email
    #將 Login_email 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  Login_email   timeout=20
    #等待被指定為 username 的ID 出現,等待時間2秒
    Input Text  //input[@type="text"][@name="email"]     ${MYGOGORO_ACCOUNT}
Input Valid User Password
    Assign Id To Element    //*[@id="1val-password"]    Login_password
    #將 Login_password 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  Login_email   timeout=20
    #等待被指定為 password 的ID 出現,等待時間2秒
    Input Text  //input[@type="password"][@name="password"]     ${PASSWORD1}
Click Login Button
    [Documentation]     Click login button in My_Account page
    Assign Id To Element    //*[@id="app"]/div/div/div/div/div[3]/button    Login_button
    #將 Login_button 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  Login_button   timeout=20
    #等待被指定為 Login_button 的ID 出現,等待時間2秒
    Click element   Login_button
    #點擊登入按鈕

# -------- New Account MyGogoro Elements -------- #
Input Valid User Email For AC
    Assign Id To Element    //*[@id="1val-email"]    Login_email_AC
    #將 Login_email 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  Login_email_AC   timeout=20
    #等待被指定為 username 的ID 出現,等待時間2秒
    Input Text  //input[@type="text"][@name="email"]     ${MYGOGORO_ACCOUNT}
Input Valid User Password For AC
    Assign Id To Element    //*[@id="1val-password"]    Login_password_AC
    #將 Login_password 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  Login_email_AC   timeout=20
    #等待被指定為 password 的ID 出現,等待時間2秒
    Input Text  //input[@type="password"][@name="password"]     ${PASSWORD1}
Click Login Button For AC
    [Documentation]     Click login button in My_Account page
    Assign Id To Element    //*[@id="app"]/div/div/div/div[3]/button    Login_button_AC
    #將 Login_button 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  Login_button_AC   timeout=20
    #等待被指定為 Login_button 的ID 出現,等待時間2秒
    Click element   Login_button
    #點擊登入按鈕


####For Register
Input User Mail
    [Documentation]    Input user email at login page
    [Arguments]    ${email}
    Wait Until Element Is Enabled    //input[@type="text"][@name="email"]
    Input Text    //input[@type="text"][@name="email"]    ${email}
    
Input User Passwords
    [Documentation]    Input user password at login page
    [Arguments]    ${password}
    Wait Until Element Is Enabled    //input[@type="password"][@name="password"]
    Input Text    //input[@type="password"][@name="password"]    ${password}

Input User Mail AC
    [Documentation]    Input user email at login page
    [Arguments]    ${email}
    Wait Until Element Is Enabled    //input[@type="text"][@name="email"]
    Input Text    //input[@type="text"][@name="email"]    ${email}
    
Input User Passwords AC
    [Documentation]    Input user password at login page
    [Arguments]    ${password}
    Wait Until Element Is Enabled    //input[@type="password"][@name="password"]
    Input Text    //input[@type="password"][@name="password"]    ${password}

# -------- MyGogoro Keywords --------
Login With Email And Password
    [Documentation]    Login My Account domain with user email and password
    [Arguments]    ${email}    ${password}
    Input User Mail    ${email}
    Input User Passwords    ${password}
    Click Rounded Button    登入
    Wait Until Location Is    https://${MYGOGORO_GN_HOST}/new-sub    30s


Login With Email And Password For AC
    [Documentation]    Login New My Account domain with user email and password
    [Arguments]    ${email}    ${password}
    Input User Mail AC    ${email}
    Input User Passwords AC   ${password}
    Click Rounded Button    登入
    Wait Until Location Is    https://${NEWMYGOGORO_PA_HOST}/new-sub    30s

Login With Email And Password For MyPlan
    [Documentation]    Login My Account domain with user email and password
    [Arguments]    ${email}    ${password}
    Input User Mail    ${email}
    Input User Passwords    ${password}
    Click Rounded Button    登入
    Wait Until Location Is    https://${MYGOGORO_GN_HOST}/dashboard    30s

Login With Email And Old Password 
    [Documentation]    Login My Account domain with user email and password
    [Arguments]    ${email}    ${password}
    Input User Mail    ${email}
    Input User Passwords    ${password}
    Click Rounded Button    登入
    Wait Until Location Is    https://${MYGOGORO_GN_HOST}/login?lang=zh-TW    30s

Login With Email And Password For One Bttery
    [Documentation]    Login My Account domain with user email and password
    [Arguments]    ${email}    ${password}
    Input User Mail    ${email}
    Input User Passwords    ${password}
    Click Rounded Button    登入
    Wait Until Location Is    https://${MYGOGORO_GN_HOST}/dashboard   30s











# # -------- MyGogoro Elements -------- #
# Input Valid User Email
#     [Documentation]    Input user email at login page
#     [Arguments]    ${email}
#     Wait Until Element Is Enabled    //input[@type="text"][@name="email"]
#     Input Text    //input[@type="text"][@name="email"]    ${email}

# Input Valid User Password
#     [Documentation]    Input user password at login page
#     [Arguments]    ${PASSWORD1}
#     Wait Until Element Is Enabled    //input[@type="password"][@name="password"]
#     Input Text    //input[@type="password"][@name="password"]    ${PASSWORD1}


# Input Valid Data For Login Page
#     [Documentation]    Input Valid Account/Password to login in login page, user already has a valid contract.
#     #  Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${DRIVER_PATH}/${DRIVER_VERSION}
#     Sleep    1s
#     Maximize Browser Window
#     #瀏覽器展開至視窗大小
#     Assign Id To Element    //*[@id="1val-username"]    Login_email
#     #將 Login_email 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
#     Wait Until Element Is Visible  Login_email   timeout=20
#     #等待被指定為 Login_email 的ID 出現,等待時間2秒
#     Input Text  Login_email     ${MYGOGORO_ACCOUNT}
#     Assign Id To Element    //*[@id="1val-password"]    Login_password
#     #將 Login_password 的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
#     Wait Until Element Is Visible  Login_email   timeout=20
#     #等待被指定為 Login_password 的ID 出現,等待時間2秒
#     Input Text  Login_password     ${PASSWORD1}