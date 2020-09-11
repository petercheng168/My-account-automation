*** Settings ***
Documentation    Test suite for MyGogoro
Resource    ../../init.robot

Force Tags    MyGogoroWeb Forget password
Test Timeout    ${TEST_TIMEOUT}
Suite Setup    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
# Suite Teardown    Close All Browsers

*** Test Cases ***


Forgot password positive test               #M01-08-01
    Forgot Password Positive Flow

Forgot password Negative test- Field is empty           #M01-09-01
    Forgot Password Negative Flow- Field is empty

Forgot password negative test - Format does not match rules     #M01-10-01
    Forgot Password Negative Flow- Format and Length
    Reset Password- Format error

Forgot password negative test - String does not match length            #M01-11-01
    Forgot Password Negative Flow- Format and Length
    Reset Password- Length error

Forgot password Negative test- Different confirm password setting       #M01-12-01
    Forgot Password Negative Flow- Format and Length
    Reset Password- Different confirm password 


# Forgot password Negative test- Old reset mail         #M01-13-01

Forgot password Negative test- Use not exists email to send reset password mail           #M01-14-01
    Forgot Password Negative Flow- Use not exists email to send reset password mail





*** Keywords ***
# -------- MyGogoro Keyword --------  # 
Click longin function
    Input Valid Data For Login Page
    Sleep    1s

    
    


