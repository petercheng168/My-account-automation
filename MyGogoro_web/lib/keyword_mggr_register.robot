
*** Keywords ***
# -------- MyGogoro Elements -------- #
Click Register Button
    Assign Id To Element    //*[@id="app"]/div/footer/a[2]    Register_btn  
    Click Element    Register_btn  

#<EULA Group>
Click EULA Agree Button 
    # Assign Id To Element    //html/body/div[3]/div/div/div/div[2]/div[2]/button[2]   EULA-Agree_btn
    # Click Element    EULA-Agree_btn
    Click Rounded Button    同意

Click EULA Cancel Button 
    # Assign Id To Element    //html/body/div[2]/div/div/div/div[2]/div[2]/button[1]   EULA-Cancel_btn
    # Click Element    EULA-Cancel_btn
    Click Rounded Button    取消

#</EULA Group>

#<Gender Radio Button Group>#
Click Gender Raido Button- Male Radio Button
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[7]/label[2]/label   Ｍale_raidobtn  #性別男
    Click Element    Ｍale_raidobtn
Click Gender Raido Button- Female Radio Button
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[7]/label[3]/label  Female_raidobtn  #性別女
    Click Element    Female_raidobtn
Click Gender Raido Button- Juridical-person Radio Button
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[7]/label[4]/label  Juridical-person_raidobtn  #法人
    Click Element    Juridical-person_raidobtn
#</Gender Radio Button Group>

#<Fill In Data Group>
#---- Fill In Valid Data Group ----
Fill In Valid Data Into Last Name Of The New Account
    [Documentation]    Fill in new account lastname
    Wait Until Element Is Enabled    //input[@type="text"][@name="lastName"]
    ##### Random 1 #####
    ${num}    set variable    6
    ${letter}    evaluate    "".join(random.sample(string.ascii_letters,int(${num})))    random,string
    ##### Random 2 #####
    # ${letter}=    Evaluate    "".join(random.sample(string.ascii_letters+string.digits,5))    random,string
    Input Text      //input[@type="text"][@name="lastName"]       ${letter}   
Fill In Valid Data Into First Name Of The New Account
    [Documentation]    Fill in new account firstname
    Wait Until Element Is Enabled    //input[@type="text"][@name="firstName"]
    ${num}    set variable    6
    ${letter}    evaluate    "".join(random.sample(string.ascii_letters,int(${num})))    random,string
    Input Text      //input[@type="text"][@name="firstName"]      ${letter}     
Fill In Valid Data Into Email Of The New Account
    [Documentation]    Fill in new account email
    Wait Until Element Is Enabled    //input[@type="text"][@name="username.email"]
    ${num}    set variable    6
    ${number}    evaluate    "".join(random.sample(string.digits,int(${num})))    random,string
    Input Text      //input[@type="text"][@name="username.email"]      gogopasw001+${number}@gmail.com
Fill In Valid Data Into Mobile Of The New Account
    [Documentation]    Fill in new account mobile
    Wait Until Element Is Enabled    //input[@type="text"][@name="mobile"]
    ${num}    set variable    8
    ${number}    evaluate    "".join(random.sample(string.digits,int(${num})))    random,string
    Input Text      //input[@type="text"][@name="mobile"]      09${number}
Fill In Valid Data Into Password Of The New Account
    [Documentation]    Fill in new account mobile
    Wait Until Element Is Enabled    //input[@type="password"][@name="password"]
    Input Text      //input[@type="password"][@name="password"]      Gogoro123
Fill In Valid Data Into passwordConfirm Of The New Account
    [Documentation]    Fill in new account mobile
    Wait Until Element Is Enabled    //input[@type="password"][@name="passwordConfirm"]
    Input Text      //input[@type="password"][@name="passwordConfirm"]      Gogoro123







#---- </Fill In Valid Data Group> ----

#---- <Fill In Invalid Data Group> ----
Fill In Invalid Data Into Last Name Of The New Account
    [Documentation]    Fill in invalid new account lastname
    Wait Until Element Is Enabled    //input[@type="text"][@name="lastName"]
    ##### Random 1 #####
    ${num}    set variable    6
    ${letter}    evaluate    "".join(random.sample(string.ascii_letters+string.digits,int(${num})))    random,string
    Input Text      //input[@type="text"][@name="lastName"]       @${letter}
    Wait Until Keyword Succeeds    10s    2s   Verfiy Invalid Lastname Register Msg      只允許輸入中英文字元  
Fill In Invalid Data Into First Name Of The New Account
    [Documentation]    Fill in invalid new account firstname
    Wait Until Element Is Enabled    //input[@type="text"][@name="firstName"]
    ${num}    set variable    6
    ${letter}    evaluate    "".join(random.sample(string.ascii_letters+string.digits,int(${num})))    random,string
    Input Text      //input[@type="text"][@name="firstName"]      @${letter}
    Wait Until Keyword Succeeds    10s    2s   Verfiy Invalid Firstname Register Msg      只允許輸入中英文字元 
Fill In Invalid Data Into Email Of The New Account
    [Documentation]    Fill in invalid new account firstname
    Wait Until Element Is Enabled    //input[@type="text"][@name="username.email"]
    ${num}    set variable    6
    ${number}    evaluate    "".join(random.sample(string.digits,int(${num})))    random,string
    Input Text      //input[@type="text"][@name="username.email"]      gogopasw001+${number}
    Wait Until Keyword Succeeds    10s    2s   Verfiy Invalid Email Register Msg     請檢查您的電子信箱格式
Fill In Invalid D ata Into Mobile Of The New Account
    [Documentation]    Fill in invalid new account mobile
    Wait Until Element Is Enabled    //input[@type="text"][@name="mobile"]
    ${num}    set variable    8
    ${number}    evaluate    "".join(random.sample(string.digits,int(${num})))    random,string
    Input Text      //input[@type="text"][@name="mobile"]      09${number}ABC
    Wait Until Keyword Succeeds    10s    2s   Verfiy Invalid Mobile Register Msg     手機號碼必須符合正確格式
Fill In Invalid Format Into Password Of The New Account
    [Documentation]    Fill in invalid new account mobile
    Wait Until Element Is Enabled    //input[@type="password"][@name="password"]
    Input Text      //input[@type="password"][@name="password"]      gogoro123
    Wait Until Keyword Succeeds    10s    2s   Verfiy Invalid Password Register Msg     密碼必需要有最少一個大寫英文和小寫英文和數字
Fill In Invalid Length Into Password Of The New Account
    [Documentation]    Fill in invalid new account mobile
    Wait Until Element Is Enabled    //input[@type="password"][@name="passwordConfirm"]
    Input Text      //input[@type="password"][@name="passwordConfirm"]      go123
    Wait Until Keyword Succeeds    10s    2s   Verfiy Invalid PasswordConfirm Register Msg     密碼需一致

#---- <Fill In Invalid Data Group> ----
#</Fill In Data Group> 
Fill In Resend Mail
    Wait Until Element Is Enabled    //*[@id="1val-email"]
    Input text      //*[@id="1val-email"]       ${User.email}

Click Registered Button
    # Assign Id To Element    //*[@id="app"]/div/div/div/form/div[15]/button  Register_btn  
    # Click Element    Register_btn
    Click Rounded Button    註冊

Click Not Received Mail
    Assign Id To Element    //*[@id="app"]/div/footer/a[2]  Not_Received_Mail
    Click Element    Not_Received_Mail

Click Resend Mail Button
    Assign Id To Element    //*[@id="app"]/div/div/div/form/div[3]/button   Resend_Mail_btn
    Click Element    Resend_Mail_btn

#######Random

    ###### Random 3 #####
    # ${str}  Evaluate    string.ascii_letters    string    #獲取由26個小寫英文字母和26個大寫字母组成的字符串
    # ${len}  Evaluate    len("${str}")    #所有大小寫字母组成的字符串長度是52
    # ${num}  Set Variable   500   #指定隨機生成的字符串長度为500
    # ${newstr}   Set Variable   ${Empty}    #定義隨機生成的字符串變數名
    # :FOR    ${index}    IN RANGE    ${num}    
    # \   ${i}    Evaluate    random.randint(0,int(${len})-1)    random    
    # \   ${tmp}  Set Variable    ${str[int(${i})-1]}    #從52个大小寫字母组成的字符串中隨機獲取一個元素
    # \   ${newstr}   Set Variable    ${newstr}${tmp}    #將獲取的字母追加到隨機字符串
    # Input Text      //input[@type="text"][@name="firstName"]      ${newstr} 
    ########################

# String Lenght Should Be And It Should Consist Of
#     [Arguments]    ${string}    ${length}    ${allowed chars}
#     Length Should Be    ${string}    ${length}
#     FOR    ${i}    IN RANGE    0    ${length}
#         Should Contain    ${allowed chars}    ${string[${i}]}
#         ...    String '${string}' contains character '${string[${i}]}' which is not in allowed characters '${allowed chars}'.
#     END

# Test Random String With
#     [Arguments]    ${expected characters}    ${given characters}
#     ${result} =    Generate Random String    10    ${given characters}
#     String Lenght Should Be And It Should Consist Of    ${result}    10    ${expected characters}


# -------- Verify Keyword -------- #  
Verfiy Invalid Lastname Register Msg
    [Arguments]    ${expected}
    [Documentation]    Check the Lastname not register
    ${lastname_not_register_msg}=    Get Text     //*[@id="app"]/div/div/div/form/div[4]/span
    Should Be Equal As Strings    ${lastname_not_register_msg}    ${expected} 

Verfiy Invalid Firstname Register Msg
    [Arguments]    ${expected}
    [Documentation]    Check the Firstname not register
    ${firstname_not_register_msg}=    Get Text     //*[@id="app"]/div/div/div/form/div[5]/span 
    Should Be Equal As Strings    ${firstname_not_register_msg}    ${expected} 

Verfiy Invalid Email Register Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${email_invalid_register_msg}=    Get Text     //*[@id="app"]/div/div/div/form/div[1]/span
    Should Be Equal As Strings    ${email_invalid_register_msg}    ${expected} 

Verfiy Invalid Mobile Register Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${mobile_invalid_register_msg}=    Get Text     //*[@id="app"]/div/div/div/form/div[6]/span
    Should Be Equal As Strings    ${mobile_invalid_register_msg}    ${expected} 

Verfiy Invalid Password Register Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${password_invalid_register_msg}=    Get Text     //*[@id="app"]/div/div/div/form/div[2]/span
    Should Be Equal As Strings    ${password_invalid_register_msg}    ${expected} 

Verfiy Invalid PasswordConfirm Register Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${passwordConfirm_invalid_register_msg}=    Get Text     //*[@id="app"]/div/div/div/form/div[3]/span
    Should Be Equal As Strings    ${passwordConfirm_invalid_register_msg}    ${expected} 

Verfiy Mail Verified Msg
    [Arguments]    ${expected}
    [Documentation]    Check the email not register
    ${mail_verified_msg}=    Get Text     /html/body/div[1]/div/div[2]/text()
    Should Be Equal As Strings    ${mail_verified_msg}    ${expected} 

