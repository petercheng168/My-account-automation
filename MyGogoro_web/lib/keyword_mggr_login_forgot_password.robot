*** Keywords ***
Forgot Password Positive Flow
    [Documentation]    Forgot password positive flow
    #  Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${DRIVER_PATH}/${DRIVER_VERSION}
    Sleep    1s
    Maximize Browser Window
    #瀏覽器展開至視窗大小
    Wait Until Location Is    https://pa-network-my.gogoro.com/login    30s
    Verify Page URL In Login Page For Forgot Password
    Click Forgot Password Button
    Wait Until Location Is    https://pa-network-my.gogoro.com/forgot-password    30s
    Verify Page URL In Forgot Password Page
    Fill Valid Email Into Textbox
    Click Send Button In Forgot Password
    Sleep   2s
    # Wait Until Keyword Succeeds    10s    2s   Verify Email Send Succeeds     A verification Email has been sent to the Email provided
    Open Emailbox URL
    Sleep   2s
    Switch Windows Tab      1
    Sleep    2s
    Open Email In Mailbox
    Sleep    10s
    Click Email
    Sleep    5s
    Switch Windows Tab      2
    Reset Password

Forgot Password Negative Flow
    [Documentation]    Forgot password negative flow
    #  Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${DRIVER_PATH}/${DRIVER_VERSION}
    Sleep    1s
    Maximize Browser Window
    #瀏覽器展開至視窗大小
    Wait Until Location Is    https://pa-network-my.gogoro.com/login    30s
    Verify Page URL In Login Page For Forgot Password
    Click Forgot Password Button
    Wait Until Location Is    https://pa-network-my.gogoro.com/forgot-password    30s
    Verify Page URL In Forgot Password Page
    Fill Invalid Email Into Textbox
    Click Send Button In Forgot Password
    Sleep   50s
    Wait Until Element Is Visible    //html/body/div[1]/div       timeout=30
    Wait Until Keyword Succeeds    10s    2s   Verfiy Email Not Register Msg        您的 Email 尚未驗證，請先檢查您的 Email 信箱驗證帳號\n確認
    Click Msg Of Forgot Password

Forgot Password Negative Flow- Field is empty
    [Documentation]    Forgot password negative flow
    #  Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${DRIVER_PATH}/${DRIVER_VERSION}
    Sleep    1s
    Maximize Browser Window
    #瀏覽器展開至視窗大小
    Wait Until Location Is    https://pa-network-my.gogoro.com/login    30s
    Verify Page URL In Login Page For Forgot Password
    Click Forgot Password Button
    Wait Until Location Is    https://pa-network-my.gogoro.com/forgot-password    30s
    Verify Page URL In Forgot Password Page
    Click Send Button In Forgot Password

Forgot Password Negative Flow- Format and Length
    [Documentation]    Forgot password positive flow
    #  Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${DRIVER_PATH}/${DRIVER_VERSION}
    Sleep    1s
    Maximize Browser Window
    #瀏覽器展開至視窗大小
    Wait Until Location Is    https://pa-network-my.gogoro.com/login    30s
    Verify Page URL In Login Page For Forgot Password
    Click Forgot Password Button
    Wait Until Location Is    https://pa-network-my.gogoro.com/forgot-password    30s
    Verify Page URL In Forgot Password Page
    Fill Valid Email Into Textbox
    Click Send Button In Forgot Password
    Sleep   2s
    # Wait Until Keyword Succeeds    10s    2s   Verify Email Send Succeeds     A verification Email has been sent to the Email provided
    Open Emailbox URL
    Sleep   2s
    Switch Windows Tab      1
    Sleep    2s
    Open Email In Mailbox
    Sleep    10s
    Click Email
    Sleep    5s
    Switch Windows Tab      2

Forgot Password Negative Flow- Use not exists email to send reset password mail
    [Documentation]    Forgot password negative flow
    #  Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${DRIVER_PATH}/${DRIVER_VERSION}
    Sleep    1s
    Maximize Browser Window
    #瀏覽器展開至視窗大小
    Wait Until Location Is    https://pa-network-my.gogoro.com/login    30s
    Verify Page URL In Login Page For Forgot Password
    Click Forgot Password Button
    Wait Until Location Is    https://pa-network-my.gogoro.com/forgot-password    30s
    Verify Page URL In Forgot Password Page
    Click Send Button In Forgot Password
    Fill Invalid Email Into Textbox
    Click Send Button In Forgot Password
    Sleep   50s
    Wait Until Element Is Visible    //html/body/div[1]/div       timeout=30
    Wait Until Keyword Succeeds    10s    2s   Verfiy Email Not Register Msg        此電子信箱未註冊\n確認
    Click Msg Of Forgot Password


    

# -------- MyGogoro Keywords --------
Switch Windows Tab
    [Arguments]    ${index}
    ${title_var}    Get Window Titles
    Select Window   @{title_var}[${index}]
    # Switch Windows Tab another code
    # # [Arguments]    ${index}
    # ${titles}    Get Window Titles
    # ${titles2}    Get From List   ${titles}   1
    # ${titles1}    Get From List   ${titles}   0
    # Select Window   ${titles2} 

Open Emailbox URL
    # Execute Javascript   window.open('https://mail.google.com/mail/')
    # Execute Javascript   window.open('https://accounts.google.com/signin/v2/identifier?continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&sacu=1&rip=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin')
    Execute Javascript   window.open('http://www.yopmail.com/zh/')
Open Email In Mailbox
    #########gmail
    # Assign Id To Element    //*[@id="identifierId"]     Gmail_txb  
    # Wait Until Element Is Visible       Gmail_txb
    # Input Text  Gmail_txb       ${ACCOUNT_IN_GMAIL}
    # Assign Id To Element    //*[@id="identifierNext"]/div/button/div[2]     Gmail_btn
    # Wait Until Element Is Visible       Gmail_btn
    # Click Element   Gmail_btn
    # Sleep   2s
    # Assign Id To Element    //*[@id="password"]/div[1]/div/div[1]/input     GmailPW_txb
    # Wait Until Element Is Visible       GmailPW_txb
    # Input Text  GmailPW_txb       ${ACCOUNT_IN_GMAIL_PASSWORD}
    # Assign Id To Element    //*[@id="passwordNext"]/span/span     GmailPW_btn
    # Wait Until Element Is Visible       GmailPW_btn
    # Click Element   GmailPW_btn

    ###########yopmail
    Assign Id To Element    //*[@id="login"]    Yopmail_txb
    Wait Until Element Is Visible       Yopmail_txb
    Input Text      Yopmail_txb    ${ACCOUNT_IN_MAILBOX}
    Press Key   Yopmail_txb    \\13
    Press \\13(Enter key) in  Emailbox_txb

Click Email
    Assign Id To Element    //*[@id=":2t"]/td[5]      Mail_1
    Wait Until Element Is Visible   Mail_1
    Click Element   Mail_1
    Assign Id To Element    //*[@id=":n6"]/div[1]/table/tbody/tr[1]/td/table/tbody/tr[2]/td/table/tbody/tr[6]/td/a      ResetPW_Link
    Click Element   ResetPW_Link

Reset Password
    Assign Id To Element    //*[@id="1val-password"]      NewPW_txb
    Wait Until Element Is Visible   NewPW_txb
    Input Text  NewPW_txb       ${NEW_PASSWORD}
    Assign Id To Element    //*[@id="1val-password-confirm"]      Re-enterPW_txb
    Wait Until Element Is Visible   Re-enterPW_txb
    Input Text  Re-enterPW_txb       ${NEW_PASSWORD}
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[5]/button   Reset_btn
    Click Element   Reset_btn

Reset Password- Different confirm password 
    Assign Id To Element    //*[@id="1val-password"]      NewPW_txb
    Wait Until Element Is Visible   NewPW_txb
    Input Text  NewPW_txb       ${NEW_PASSWORD}
    Assign Id To Element    //*[@id="1val-password-confirm"]      Re-enterPW_txb
    Wait Until Element Is Visible   Re-enterPW_txb
    Input Text  Re-enterPW_txb       ${NEW_PASSWORD}123
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[5]/button   Reset_btn
    Click Element   Reset_btn

Reset Password- Format error
    Assign Id To Element    //*[@id="1val-password"]      NewPW_txb
    Wait Until Element Is Visible   NewPW_txb
    Input Text  NewPW_txb       !@#$%^
    Assign Id To Element    //*[@id="1val-password-confirm"]      Re-enterPW_txb
    Wait Until Element Is Visible   Re-enterPW_txb
    Input Text  Re-enterPW_txb       !@#$%^
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[5]/button   Reset_btn
    Click Element   Reset_btn

Reset Password- Length error
    Assign Id To Element    //*[@id="1val-password"]      NewPW_txb
    Wait Until Element Is Visible   NewPW_txb
    Input Text  NewPW_txb       ${NEW_PASSWORD}${NEW_PASSWORD}${NEW_PASSWORD}
    Assign Id To Element    //*[@id="1val-password-confirm"]      Re-enterPW_txb
    Wait Until Element Is Visible   Re-enterPW_txb
    Input Text  Re-enterPW_txb       ${NEW_PASSWORD}${NEW_PASSWORD}${NEW_PASSWORD}
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[5]/button   Reset_btn
    Click Element   Reset_btn

# -------- MyGogoro Elements -------- #
Click Forgot Password Button
    Assign Id To Element    //*[@id="app"]/div/footer/a[1]    ForgotPassword_btn  
    Click Element    ForgotPassword_btn

Fill Valid Email Into Textbox
    Assign Id To Element    //input[@type="text"][@placeholder="請輸入登入用之電子信箱"]    ForgotPassword_email_textbox
    Wait Until Element Is Visible  ForgotPassword_email_textbox   timeout=20
    Input Text      ForgotPassword_email_textbox    ${FORGOT_PASSWORD_ACCOUNT}

Fill Invalid Email Into Textbox
    Assign Id To Element    //input[@type="text"][@placeholder="請輸入登入用之電子信箱"]    ForgotPassword_email_textbox
    Wait Until Element Is Visible  ForgotPassword_email_textbox   timeout=20
    Input Text      ForgotPassword_email_textbox    ${FORGOT_PASSWORD_INVALID_ACCOUNT}

Click Send Button In Forgot Password
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[3]/button    FPSend_btn   
    Click Element    FPSend_btn
    Wait Until Element Is Visible   FPSend_btn      timeout=20

Click Msg Of Forgot Password
    Assign Id To Element    //html/body/div[1]/div/div[2]/footer/button    ForgotPwMsg_btn
    Wait Until Element Is Visible   ForgotPwMsg_btn   timeout=20
    Click Element       ForgotPwMsg_btn    

    


# -------- Verify Keywords --------   
Verify Page URL In Login Page For Forgot Password
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://pa-network-my.gogoro.com/login
    # “Verify Page URL” setting in keywords_common.robot

Verify Page URL In Forgot Password Page
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://pa-network-my.gogoro.com/forgot-password 
    # “Verify Page URL” setting in keywords_common.robot

Verify Email Send Succeeds
    # Verify Email send success String 
    [Arguments]    ${expected}
    [Documentation]    Check the Email send success
    ${menu_string}=    Get Text     //*[@id="app"]/div/div/div/form/p 
    Should Be Equal As Strings    ${menu_string}    ${expected}

Verify Correct Account In Mailbox
    [Arguments]    ${expected}
    [Documentation]    Check the Email send success
    Assign Id To Element    //*[@id="lrefr"]/span/span      Refresh_btn
    ${mailbox_string}=    Get Text     //*[@id="webmailhaut"]/table[2]/tbody/tr/td[1]/div[3] 
    Should Be Equal As Strings    ${mailbox_string}    ${expected}
    Run Keyword If      '${mailbox_string}' == '${expected}'      Click Element   Refresh_btn
    Assign Id To Element    //*[@id="m1"]/div     ForgotMail
    Click Element   ForgotMail

Verfiy Email Not Register Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${email_not_register_msg}=    Get Text     //html/body/div[1]/div/div[2]
    Should Be Equal As Strings    ${email_not_register_msg}    ${expected}   