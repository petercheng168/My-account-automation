*** Settings ***
Documentation    Test suite for MyGogoro
Resource    ../../init.robot

Force Tags    MyGogoroWeb Myprofile 
Test Timeout    ${TEST_TIMEOUT}
Suite Setup    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
# Suite Teardown    Close All Browsers

*** Test Cases ***
Change mygogoro valid email
    Click Longin Function
    Navigate To My Profile Page
    Update Email From Myprofile
    Open Emailbox URL
    Sleep   2s
    Switch Windows Tab      1
    Sleep    2s
    Open Email In Mailbox
    Sleep    10s


*** Keywords ***
# -------- Mygogoro Keyword --------  
Navigate To My Profile Page
    [Documentation]   Navigate To My Profile Page after click left menu
    # Assign Id To Element    //*[@id="Top_Container"]/div[2]/aside/ul[2]/li    MyProfile_btn
    Assign Id To Element    //*[@id="app"]/div[2]/aside/ul[2]/li/a   MyProfile_btn
    #將Element的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  MyProfile_btn   timeout=20
    Sleep    5s                     
    Click element   MyProfile_btn

Click Longin Function
    Input Valid Data For Login Page
    Sleep    1s
    Wait Until Keyword Succeeds    10s    2s    Verify Menu Myprofile String       帳號與密碼設定

