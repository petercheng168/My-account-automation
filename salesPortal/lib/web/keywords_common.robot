*** Keywords ***
# -------- Sales Portal Elements --------
Check Remember Checkbox Unavailable
    [Documentation]    Check remember checkbox is not enable
    Checkbox Should Not Be Selected    //input[@name="keep" and @type="checkbox"]

Click 2FA Confirm Button To Login
    [Documentation]    Click 2FA Confirm Button to login in login page
    Click Visible Element    //*[@id="root"]/div/form/div/button[2]
    Wait Until Element Is Visible    //*[@id="root"]//h3[contains(.,"試乘參觀")]    5s

Click Button To Close Popup Window
    [Documentation]    Click confirm button to close popup window with div/span message
    [Arguments]    ${xpath_type}    ${message}    ${number}=1
    Wait Until Element Is Visible    //${xpath_type}\[text()="${message}"]/parent::div/parent::div//button[${number}]    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Keyword Succeeds    1s    200ms    Click Element    //${xpath_type}\[text()="${message}"]/parent::div/parent::div//button[${number}]

Click Button To Close Popup Window By Message
    [Documentation]    Click confirm button to close popup window by message
    [Arguments]    ${message}
    Wait Until Element Is Visible    //div[text()="${message}"]/parent::div/parent::div/div[2]/button    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Keyword Succeeds    1s    200ms    Click Element    //div[text()="${message}"]/parent::div/parent::div/div[2]/button
    Wait Until Element Is Not Visible    //div[text()="${message}"]/parent::div/parent::div/div[2]/button    ${PAGE_CONTAINS_TIMEOUT}

Click Button With Name
    [Documentation]    Click button with exactly name (text), cannot be duplicated here
    [Arguments]    ${name}
    Click Visible Element    //button[text()="${name}"]    ${PAGE_CONTAINS_TIMEOUT}

Click Element By Type And Id
    [Documentation]    Click element by giving type and id
    [Arguments]    ${type}    ${id}
    Click Visible Element    //${type}\[@id="${id}"]    5s

Click Get 2FA Email Button
    [Documentation]    Click get 2FA email button to receive email information
    Click Visible Element    //*[@id="root"]/div/div[2]/div[1]/button
    ${verifyCode} =    Get Verification Code From Email
    Input Text In Element By Name    code    ${verifyCode}

Click Gogoro Logo
    [Documentation]    Click gogoro logo
    Click Visible Element    ${XPATH_GOGORO_LOGO}    3s    2s

Get Verification Code From Email
    [Documentation]    Keyword to get verification code from email
    ${verifyMessage} =    Return Email Body    no-reply@gogoro.com    ${SALES_PORTAL_MANAGER_ACCOUNT}    ${GMAIL_PASSWORD}
    ${verifyCode} =    Get Substring    ${verifyMessage}    26    32
    [Return]    ${verifyCode}

Input Login Page Content
    [Documentation]    Input Correct Account/Password to login in login page, sleep 1s for avoiding recaptcha issue
    [Arguments]    ${account}    ${password}
    Sleep    1s
    Input Text In Element By Name    account    ${account}
    Input Text In Element By Name    password    ${password}

Input Text In Element
    [Documentation]    Input Correct Account/Password to login in login page
    [Arguments]    ${element}    ${input}
    Wait Until Element Is Visible    //*[@id='${element}']    5s
    Input Text    //*[@id='${element}']    ${input}

Input Text In Element By Name
    [Documentation]    Input text in element by name
    [Arguments]    ${element}    ${input}
    Input Text    //input[@name="${element}"]    ${input}

JS Click Element
    [Documentation]    Use java script to click element by xpath
    [Arguments]    ${xpath}
    Execute JavaScript    document.evaluate('${xpath}', document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();

# -------- Sales Portal Keywords --------
Login With Direct Login
    [Documentation]    Login salesPortal with direct login
    [Arguments]    ${account}=${SALES_ACCOUNT}    ${password}=${SALES_PASSWORD}
    Set Suite Variable    ${email_account}    ${SALES_PORTAL_MANAGER_ACCOUNT}
    Open Browser    ${SALES_PORTAL_DIRECT_URL}    ${SALES_PORTAL_WINDOW_HEIGHT}    ${SALES_PORTAL_WINDOW_WEIGHT}
    Input Login Page Content    ${account}    ${password}
    Click Login Button

Login With Two Factor Authentication
    [Documentation]    Login salesPortal with 2FA
    [Arguments]    ${account}=${SALES_ACCOUNT}    ${password}=${SALES_PASSWORD}
    Set Suite Variable    ${email_account}    ${SALES_PORTAL_MANAGER_ACCOUNT}
    Open Browser    ${SALES_PORTAL_URL}    ${SALES_PORTAL_WINDOW_HEIGHT}    ${SALES_PORTAL_WINDOW_WEIGHT}
    Input Login Page Content    ${account}    ${password}
    Click Login Button
    Click Get 2FA Email Button
    Check Remember Checkbox Unavailable
    Click 2FA Confirm Button To Login

Select Es-Addon
    [Documentation]    Select assign es-addon
    [Arguments]    ${addon}
    ${attr} =    Get Element Attribute    //div[@role="combobox"][contains(.,"請選擇附加方案")]    aria-controls
    Wait Until Element Is Enabled    //div[@aria-controls="${attr}"]/div/div
    JS Click Element    //div[@aria-controls="${attr}"]/div/div
    Click Subitem In Dropdown List    ${addon}

Select Es-Plan
    [Documentation]    Select assign es-plan
    [Arguments]    ${plan}
    Wait Until Element Is Visible    //legend[text()="電池服務資費方案"]    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_BATTERY_TARIFF_PLAN_OPTIONS_UL}    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    //legend[text()="帳單與發票設定"]    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    //label[text()="${plan}"]/input    ${PAGE_CONTAINS_TIMEOUT}

Scroll View To Element
    [Documentation]    Scroll view to any element with its xpath
    [Arguments]    ${xpath}
    Execute Javascript    window.document.evaluate( '${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Wait Until Element Is Visible    ${xpath}    3s

Scroll Page
    [Documentation]    Scroll webpage with x,y coordination
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

Search Order
    [Documentation]    Search order with key and input value
    [Arguments]    ${key}    ${input_value}
    Scroll Page    0    0
    Click Visible Element    //span[text()="${key}"]/parent::label/span/span    ${PAGE_CONTAINS_TIMEOUT}
    Input Text    //*[@id="root"]/div[2]/main/div/div/div[2]/div/span/input    ${input_value}
    Press Keys    //*[@id="root"]/div[2]/main/div/div/div[2]/div/span/input    RETURN

# -------- Verify Keywords --------
Verify Order Information
    [Documentation]    Verify contract info detail list
    [Arguments]    ${item}    ${result}
    Wait Until Page Contains Element    //dl[@class="InfoBox_row__Ab130"]//div[contains(.,"${item}")]/dd[contains(.,"${result}")]    ${PAGE_CONTAINS_TIMEOUT}
    Page Should Contain Element    //dl[@class="InfoBox_row__Ab130"]//div[contains(.,"${item}")]/dd[contains(.,"${result}")]

Verify Popup Window Message
    [Documentation]    Verify that popup window with input text
    [Arguments]    ${text}
    Wait Until Page Contains    ${text}    ${PAGE_CONTAINS_TIMEOUT}
    Page Should Contain    ${text}
