*** Keywords ***
# -------- Sales Portal Elements --------
Click 2FA Confirm Button To Login On Production
    [Documentation]    Click 2FA Confirm Button to login in login page
    Click Visible Element    //*[@id="root"]/div/form/div/button[2]    2s
    Wait Until Element Is Visible    //*[@id="root"]//h3[contains(.,"試乘參觀")]    15s

Click Receive 2FA Email Button
    [Documentation]    Click button to receive 2FA verification email
    Wait Until Element Is Visible    //*[@id="root"]/div/div[2]/div[1]/button    15s
    Click Visible Element    //*[@id="root"]/div/div[2]/div[1]/button    2s

# -------- Sales Portal Keywords --------
Delete All Receive Email With Assign Receiver
    [Documentation]    Keyword to delete all email from receive email address
    [Arguments]    ${email_address}
    Delete All Email In All Mail    ${email_address}
    Delete All Email In Trash    ${email_address}

Input 2FA Verification Code
    [Documentation]    Input 2FA verification code from receiving email
    ${verifyCode} =    Get Verification Code From Production Email
    Input Text In Element By Name    code    ${verifyCode}

Get Verification Code From Production Email
    [Documentation]    Get verification code from email group with production env.
    ${verifyMessage} =    Return Email Body From Group    no-reply@gogoro.com    ${GMAIL_ACCOUNT}    ${GMAIL_PASSWORD}
    ${verifyCode} =    Get Substring    ${verifyMessage}    26    32
    [Return]    ${verifyCode}

Input Login Page Correct Content On Production
    [Documentation]    Input Correct Account/Password to login in login page on production, sleep 1s for avoiding recaptcha issue
    Sleep    1s
    Input Text In Element By Name    account    ${SALES_PROD_ACCOUNT}
    Input Text In Element By Name    password    ${SALES_PROD_PASS}

Performance Setup
    [Documentation]    Keyword for setting up navigation timing
    Get Driver
    Mark Start

Performance Test
    [Documentation]    Given keyword and verify it's perfomance duration time by second
    [Arguments]    ${keyword}    ${error_message}    ${second}=0
    Performance Setup
    ${result} =    Run Keyword And Ignore Error    ${keyword}
    Run Keyword If    'FAIL' in ${result}    Log To Console    ${error_message}
    Run Keyword If    'FAIL' in ${result}    Log To Console    ${result}
    Run Keyword If    'FAIL' in ${result}    Fatal Error
    Run Keyword If    '${second}' > '0'    Verify Performance Result    ${second}

Return Email Body From Group
    [Documentation]    Get email body from group
    [Arguments]    ${sender}    ${email}    ${password}
    Open Mailbox    host=imap.googlemail.com    user=${email}    password=${password}
    ${latest} =    Wait For Email    sender=${sender}    toEmail=${SALES_PORTAL_PROD_EMAIL}    status=UNSEEN
    ${body} =    Get Email Body With Utf8    ${latest}
    Mark Email As Read    ${latest}
    Delete All Receive Email With Assign Receiver    ${SALES_PORTAL_PROD_EMAIL}
    Close Mailbox
    [Return]    ${body}

# -------- Verify Keywords --------
Verify Performance Result
    [Documentation]    Verify that keyword should give response time smaller than assign second
    [Arguments]    ${second}
    Mark End
    ${resp_time} =    Get Mark Resp Time
    Append To List    ${temp_array}    ${resp_time}
    Clear Resp Info

Verify Total Time
    [Documentation]    Verify that login total time need to smaller than 10 seconds
    [Arguments]    ${temp_array}
    ${total_time} =    Get Total Time    ${temp_array}
    ${total_time} =    Convert To Number    ${total_time}
    Run Keyword If    ${total_time} > 10000    Fail
