*** Keywords ***
-------- Gogoro Elements --------
-------- Gogoro Keywords --------
Open Browser
    [Arguments]    ${url}    ${height}    ${weight}
    [Documentation]    Create a chrome browser without UI display
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    # Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-setuid-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${BROWSER_PATH}/chromedriver_78
    Set Window Size    ${height}    ${weight}
    Go To    ${url}
