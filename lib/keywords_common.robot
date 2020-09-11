*** Keywords ***
# -------- Gogoro Elements --------
Set Data Platform Cipher
    Set Test Variable    ${CIPHER_APP}    ${ENV}
    Set Test Variable    ${CIPHER_RESOURCE}    ${ENV}
    Set Test Variable    ${CIPHER_PASSWORD}    123
    Set Test Variable    ${GO_CLIENT_HEADER}    ${ENV}

Set Sales Portal Cipher
    Set Test Variable    ${CIPHER_APP}    sales_portal
    Set Test Variable    ${CIPHER_RESOURCE}    sales_portal
    Set Test Variable    ${CIPHER_PASSWORD}    ${SALES_PASSWORD}
    Set Test Variable    ${GO_CLIENT_HEADER}    sales_portal

# -------- Gogoro Keywords --------
Open Browser
    [Arguments]    ${url}    ${height}    ${weight}
    [Documentation]    Create a chrome browser without UI display
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless  ##背景執行
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-setuid-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --incognito  ##無痕
    Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${BROWSER_PATH}/${DRIVER_VERSION}
    Set Window Size    ${height}    ${weight}
    Go To    ${url}

Click Visible Element
    [Documentation]    Click a visible element
    [Arguments]    ${input}    ${wait_second}=${PAGE_CONTAINS_TIMEOUT}    ${retry_second}=1s
    Wait Until Element Is Visible    ${input}    ${wait_second}
    Wait Until Keyword Succeeds    ${retry_second}    200ms    Click Element    ${input}

# Open Browser
#     [Documentation]    Create a chrome browser without UI display
#     [Arguments]    ${url}    ${height}    ${weight}
#     ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#     Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
#     Call Method    ${chrome_options}    add_argument    --disable-extensions
#     Call Method    ${chrome_options}    add_argument    --disable-gpu
#     Call Method    ${chrome_options}    add_argument    --disable-setuid-sandbox
#     Call Method    ${chrome_options}    add_argument    --headless
#     Call Method    ${chrome_options}    add_argument    --lang\=zh_TW
#     Call Method    ${chrome_options}    add_argument    --no-sandbox
#     Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${DRIVER_PATH}/${DRIVER_VERSION}
#     Set Window Size    ${height}    ${weight}
#     Go To    ${url}

Print
    [Documentation]    Print string to console
    [Arguments]    ${text}
    Log To Console    ${text}

Return Email Body
    [Documentation]    Get email body
    [Arguments]    ${sender}    ${email}    ${password}
    Open Mailbox    host=imap.googlemail.com    user=${email}    password=${password}
    ${latest} =    Wait For Email    sender=${sender}    toEmail=${email}    status=UNSEEN
    ${body} =    Get Email Body With Utf8    ${latest}
    Mark Email As Read    ${latest}
    Delete Email    ${latest}
    Close Mailbox
    [Return]    ${body}

Set Screenshot
    [Documentation]    Capture Screenshot with assign filename
    [Arguments]    ${filename}
    Set Screenshot Directory    ${filename}
    Capture Page Screenshot

Delete Lastest Email
    [Documentation]    Delete lastest email
    [Arguments]    ${sender}    ${email}    ${password}
    Open Mailbox    host=imap.googlemail.com    user=${email}    password=${password}
    ${latest} =    Wait For Email    sender=${sender}    toEmail=${email}
    Delete Email    ${latest}
    Close Mailbox

# -------- Verify Keywords --------
Verify Page URL
    [Arguments]    ${expected}
    [Documentation]    Check the URL of pages
    ${currentURL} =    Get Location
    Should Be Equal As Strings    ${currentURL}    ${expected}

Verify Element Validation Message
    [Documentation]    Check element validation message
    [Arguments]    ${xpath}    ${message}
    Sleep    0.5s
    Element Attribute Value Should Be    ${xpath}    validationMessage    ${message}

Verify Email Exists
    [Documentation]    Check email existing and delete email
    [Arguments]    ${sender}    ${email}    ${password}
    Open Mailbox    host=imap.googlemail.com    user=${email}    password=${password}
    ${latest} =    Wait For Email    sender=${sender}    toEmail=${email}
    Delete Email    ${latest}
    Close Mailbox

# Verify Page URL
#     [Documentation]    Check the URL of pages
#     [Arguments]    ${expected}
#     ${currentURL} =    Get Location
#     Should Be Equal As Strings    ${currentURL}    ${expected}