*** Settings ***
Documentation    Test suite for MyGogoro
Resource    ../../init.robot

Force Tags    MyGogoroWeb Forget password
Test Timeout    ${TEST_TIMEOUT}
Suite Setup    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
# Suite Teardown    Close All Browsers

*** Test Cases ***
Forgot password positive test
    Forgot Password Positive Flow


# *** Keywords ***
# -------- MyGogoro Keyword --------  # 
Click longin function
    Input Valid Data For Login Page
    Sleep    1s

    
    

