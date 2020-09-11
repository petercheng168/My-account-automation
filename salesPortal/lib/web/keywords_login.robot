*** Settings ***
Resource    variables_common.robot
Resource    variables_login.robot

*** Keywords ***
# -------- Sales Portal Elements --------
Click Login Button
    [Documentation]    Click login button which is in sales_portal login page
    Click Visible Element    ${XPATH_LOGIN_BUTTON}

Click Logout Button
    [Documentation]    Click logout button which is in sales_portal homepage
    Click Visible Element    ${XPATH_LOGOUT_BUTTON}    3s
    Wait Until Element Is Not Visible    ${XPATH_MENU_ICON_BUTTON}    3s

Click Privacy Policy
    [Documentation]    Click Privacy Policy hyperlink in sales_portal login page
    Wait Until Element Is Visible    ${XPATH_PRIVACY_POLICY_A}    3s
    Wait Until Keyword Succeeds    1s    200ms    Click Element    ${XPATH_PRIVACY_POLICY_A}

Click Terms Of Service
    [Documentation]    Click Terms Of Service hyperlink in sales_portal login page
    Wait Until Element Is Visible    ${XPATH_TERMS_OF_SERVICE_A}    3s
    Wait Until Keyword Succeeds    1s    200ms    Click Element    ${XPATH_TERMS_OF_SERVICE_A}

Press Enter Key To Login
    [Documentation]    Press Enter Key on keyboard while focus on 'Password'
    Wait Until Element Is Visible    ${XPATH_PASSWORD_INPUT}    3s
    Wait Until Keyword Succeeds    1s    200ms    Press Keys    ${XPATH_PASSWORD_INPUT}    RETURN

# -------- Sales Portal Keywords --------
Get Account Information
    [Documentation]    API to get department name by employee's account
    [Arguments]    ${emp_code}=${SALES_ACCOUNT}
    ${company_code} =     Employees Get    emp_code=${emp_code}    account=${CIPHER_GSS_ACCOUNT}
    ${result} =    Departments Get    departments_id=${company_code.json()['data'][0]['department_id']}    account=${CIPHER_GSS_ACCOUNT}
    [Return]    ${result.json()['data'][0]['department_name']}

Switch Window Tab
    [Documentation]    Select assign windows tab with index number
    [Arguments]    ${index}
    ${title_var}    Get Window Titles
    Select Window    title=${title_var}[${index}]

# -------- Verify Keywords --------
Verify Company Code
    [Documentation]    Verify that after login, show correct company code
    [Arguments]    ${code}
    Wait Until Element Is Visible    ${XPATH_ACCOUNT_EMP_CODE}/span    3s
    Element Text Should Be    ${XPATH_ACCOUNT_COMPANY_CODE}    ${code}

Verify Error Hint Without Giving Account
    [Documentation]    Verify error hint while without account or password information
    [Arguments]    ${string}
    Wait Until Element Is Visible    ${XPATH_ACCOUNT_ERR_HINT_DIV}    3s
    Element Text Should Be    ${XPATH_ACCOUNT_ERR_HINT_DIV}    ${string}

Verify Error Hint Without Giving Password
    [Documentation]    Verify error hint while without account or password information
    [Arguments]    ${string}
    Wait Until Element Is Visible    ${XPATH_PASSWORD_ERR_HINT_DIV}    3s
    Element Text Should Be    ${XPATH_PASSWORD_ERR_HINT_DIV}    ${string}

Verify Logout Area Account Information
    [Documentation]    Verify that after login, show correct account information
    [Arguments]    ${input}
    ${account}=    Get Text    ${XPATH_ACCOUNT_EMP_CODE}
    Should Be Equal As Strings    ${account}    ${input}

Verify Menu Icon Exist
    [Documentation]    Verify menu icon on homepage exist
    Wait Until Element Is Visible    ${XPATH_MENU_ICON_BUTTON}    3s
    Page Should Contain Element    ${XPATH_MENU_ICON_BUTTON}
