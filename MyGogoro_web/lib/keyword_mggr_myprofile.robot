*** Variables ***
${normalize_path_jpg}    ${PROJECT_ROOT}/MyGogoro_web/res/Avatar-kakao.jpg
${normalize_path_png}    ${PROJECT_ROOT}/MyGogoro_web/res/Avatar-kakao.png
${normalize_path_incorrect_format_pdf}    ${PROJECT_ROOT}/MyGogoro_web/res/giveup.pdf

*** Keywords ***

Change Account Infomation1
    Sleep       2s
    Change Account Information Name1
# <change account data group>
Change Account Infomation
    Sleep       2s
    Change Account Information Name
    Change Account Information Gender
    Change Mobile Num
    Saved Account Information
#     # Wait Until Keyword Succeeds    10s    2s        Verify Account Information      ${FIRST_NAME_CHANGE1}
#     Go to       https://pa-network-my.gogoro.com/logout
    # [Teardown]    Close All Browsers
# </change account data group>

# <change account data group>
Update Invalid Account Infomation
    Sleep       2s
    Change Invalid Account Information Name
    Change Account Information Gender
    Saved Account Information
#     # Wait Until Keyword Succeeds    10s    2s        Verify Account Information      ${FIRST_NAME_CHANGE1}
#     Go to       https://pa-network-my.gogoro.com/logout
    # [Teardown]    Close All Browsers
# </change account data group>


# <change email group>  
Update Email From Myprofile
    Change Vaild Account Email
    Click Element     //*[@id="app"]/div[2]/div/form/section[3]/div[1]/div[2]/button       #Verify email button
    Saved Account Information
# </change email group>

# <change Invalid email group>  
Update Invalid Email From Myprofile
    Change Invalid Account Email
    Wait Until Keyword Succeeds    10s    2s   Verify Email Format From Myprofile       請檢查您的電子信箱格式     
    Saved Account Information
# </change Invalid email group>


# <change password group>
Update To New Password From Myprofile     
    Change Account New Password
    Saved Account Information
    Sleep       2s
    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
    Maximize Browser Window
    Sleep       2s
    Wait Until Element Is Visible       //*[@id="app"]/div/div      timeout=20
    Verify Account New Password
    Sleep       3s
Update To Old Password From Myprofile  
    Change Account Old Password
    Saved Account Information
    Open Browser    ${MY_ACCOUNT_URL}    ${MY_ACCOUNT_WINDOW_HEIGHT}    ${MY_ACCOUNT_WINDOW_WEIGHT}
    Maximize Browser Window
    Sleep       2s
    Wait Until Element Is Visible       //*[@id="app"]/div/div      timeout=20
    Verify Account Old Password
    Sleep       3s
    Go to       https://pa-network-my.gogoro.com/logout
# </change pssword group>

# <change wrong password format group>
Check Wrong Password Format From Myprofile
    # Change Account Password by Wrong Password Format
    Wait Until Keyword Succeeds    10s    2s   Verify Account Password Format Msssage      密碼必需要有最少一個大寫英文和小寫英文和數字
    Go to       https://pa-network-my.gogoro.com/logout
# </change wrong password format group>

# <change wrong password format group>
Check Wrong Password String Length From Myprofile
    # Change Account Password by Wrong Password String
    Wait Until Keyword Succeeds    10s    2s   Verify Account Password String Length Msssage      請輸入最少 8 以及最多 20 個數字的密碼
    Go to       https://pa-network-my.gogoro.com/logout
# </change wrong password format group>

# <change wrong confirm password group>
Update Wrong Confirm Password From Myprofile
    Change Account Password by Confirm Wrong Password
    Wait Until Keyword Succeeds    10s    2s   Verify Account Confirm Password Message       兩次新密碼輸入不相同 
    Go to       https://pa-network-my.gogoro.com/logout
# </change wrong confirm password group>

# <einvoice setting group>
Einvoice Setting to Einvoice
    Einvoice setting
    Saved Account Information
    Reload Page
    Wait Until Keyword Succeeds    10s    2s   Verify Einvoice Setting Is Einvoice       開立發票後不寄送紙本證明聯，將由系統主動進行對獎，若有中獎，將以電子郵件通知用戶。
    Go to       https://pa-network-my.gogoro.com/logout 
# </einvoice setting group>

# <paper invoice setting group>
Einvoice Setting to Paper Invoice
    Paper Invoice Setting   
    Saved Account Information
    Reload Page
    Wait Until Keyword Succeeds    10s    2s   Verify Einvoice Setting Is Paper Invoice      紙本發票將寄送至使用者地址如需修改地址或加註統編請至 Gogoro Network™ 官網的『聯絡我們』頁面留言，將由專人盡快為您服務。
    Einvoice setting
    Saved Account Information
    Go to       https://pa-network-my.gogoro.com/logout
# </paper invoice setting group>
    
# <donate setting group>
Einvoice Setting to Donate
    Donate Setting  
    Saved Account Information
    Reload Page
    Wait Until Keyword Succeeds      10s    2s   Verify Einvoice Setting Is Donate       公益關懷協會
    Einvoice setting
    Saved Account Information
    Go to       https://pa-network-my.gogoro.com/logout
# </donate setting group>


Upload avatar jpg
    [Documentation]    Upload user avatar jpg format
    Click Avatar JPG
    Click Rounded Button       確認上傳

Upload avatar png
    [Documentation]    Upload user avatar png format
    Click Avatar PNG
    Click Rounded Button       確認上傳

Not upload avatar png
    [Documentation]    Upload user avatar png format
    Click Avatar PNG
    Click Element       //html/body/div/div/div/div/button

Not upload avatar jpg
    [Documentation]    Upload user avatar jpg format
    Click Avatar JPG
    Click Element       //html/body/div/div/div/div/button


Upload invalid format file
    [Documentation]    Upload user avatar jpg format
    Click Avatar Invalid File
    Wait Until Keyword Succeeds    10s    2s   Verify Avatar Format Message- Title       檔案上傳錯誤
    Wait Until Keyword Succeeds    10s    2s   Verify Avatar Format Message- Content     請選擇 PNG 或 JPG 檔案，然後再試一次\n確認

    

# -------- Mygogoro Keyword ----------------------------------  
Change Account Information Name1
    [Documentation]    Change account vaild data in my profile page

    ${FirstName_txb_string}=    Get Text     xpath=//*[@id="1val-firstName"] 
    ${FirstName_txb_string}=    set variable    ${FIRST_NAME_CHANGE_ONE}
    Run Keyword If      '${FirstName_txb_string}' == '${FIRST_NAME_CHANGE_ONE}'      Log To Console     one
    ...  ELSE IF  '${FirstName_txb_string}' == '${FIRST_NAME_CHANGE_TWO}'   Log To Console      two


Change Account Information Name
    [Documentation]    Change account vaild data in my profile page
    ${FirstName_txb_string}=    Get Text     xpath=//*[@id="1val-firstName"] 
    # ${FirstName_txb_string}=  set variable    ${FIRST_NAME_CHANGE_ONE}
    Run Keyword If      '${FirstName_txb_string}' == '${FIRST_NAME_CHANGE_ONE}'      Input Text    //*[@id="1val-firstName"]    ${FIRST_NAME_CHANGE_TWO}
    ...  ELSE       Input Text     //*[@id="1val-firstName"]      ${FIRST_NAME_CHANGE_ONE}
    Sleep       2s
    
    ${LastName_txb_string}=    Get Text     xpath=//*[@id="1val-lastName"]
    # ${LastName_txb_string}=  set variable    ${LAST_NAME_CHANGE_ONE}
    Run Keyword If      '${LastName_txb_string}' == '${LAST_NAME_CHANGE_ONE}'      
    ...  Input Text     //*[@id="1val-lastName"]    ${LAST_NAME_CHANGE_TWO}
    ...  ELSE       Input Text      //*[@id="1val-lastName"]      ${LAST_NAME_CHANGE_ONE}

    ${DisplayName_txb_string}=    Get Text     xpath=//*[@id="1val-displayName"]
    # ${DisplayName_txb_string}=  set variable    ${DISPLAY_NAME_CHANGE_ONE}
    Assign Id To Element    //*[@id="1val-displayName"]       DisplayName_txb
    Run Keyword If      '${DisplayName_txb_string}' == '${DISPLAY_NAME_CHANGE_ONE}'      
    ...  Input Text     DisplayName_txb      ${DISPLAY_NAME_CHANGE_TWO}
    ...  ELSE       Input Text      DisplayName_txb     ${DISPLAY_NAME_CHANGE_ONE}

Change Invalid Account Information Name
    [Documentation]    Change account vaild data in my profile page
    ${FirstName_txb_string}=    Get Text     xpath=//*[@id="1val-firstName"] 
    # ${FirstName_txb_string}=  set variable    ${FIRST_NAME_CHANGE_ONE}
    Run Keyword If      '${FirstName_txb_string}' == '${FIRST_NAME_CHANGE_ONE}'      
    ...  Input Text    //*[@id="1val-firstName"]    ${FIRST_NAME_CHANGE_TWO}@@
    ...  ELSE       Input Text     //*[@id="1val-firstName"]      ${FIRST_NAME_CHANGE_ONE}@@
    Sleep       2s
    
    ${LastName_txb_string}=    Get Text     xpath=//*[@id="1val-lastName"]
    # ${LastName_txb_string}=  set variable    ${LAST_NAME_CHANGE_ONE}
    Run Keyword If      '${LastName_txb_string}' == '${LAST_NAME_CHANGE_ONE}'      
    ...  Input Text     //*[@id="1val-lastName"]    ${LAST_NAME_CHANGE_TWO}@@
    ...  ELSE       Input Text      //*[@id="1val-lastName"]      ${LAST_NAME_CHANGE_ONE}@@

    ${DisplayName_txb_string}=    Get Text     xpath=//*[@id="1val-displayName"]
    # ${DisplayName_txb_string}=  set variable    ${DISPLAY_NAME_CHANGE_ONE}
    Assign Id To Element    //*[@id="1val-displayName"]       DisplayName_txb
    Run Keyword If      '${DisplayName_txb_string}' == '${DISPLAY_NAME_CHANGE_ONE}'      
    ...  Input Text     DisplayName_txb      ${DISPLAY_NAME_CHANGE_TWO}@@
    ...  ELSE       Input Text      DisplayName_txb     ${DISPLAY_NAME_CHANGE_ONE}@@



Change Account Information Gender
    Assign Id To Element    //*[@id="app"]/div[2]/div/form/section[1]/div[3]/label[4]/label       GenderLegal_radiobtn
    Click Element    GenderLegal_radiobtn
    Wait Until Keyword Succeeds    10s    2s   Verify Gender Is Leagl Role       公司名稱*
    Assign Id To Element    //*[@id="app"]/div[2]/div/form/section[1]/div[3]/label[2]/label       GenderMale_radiobtn
    Click Element    GenderMale_radiobtn
    Wait Until Keyword Succeeds    10s    2s   Verify Gender Is Male Role       姓氏*
    
Change Mobile Num
    Assign Id To Element    //*[@id="1val-mobile"]      Mobile_txb
    Double Click Element    Mobile_txb
    Input Text      Mobile_txb      ${MOBILE_NUM}

Change Vaild Account Email
    [Documentation]    Change valid email in my profile page
    ${UpdateEmail_txb_string}=    Get Text     xpath=//*[@id="1val-email"]
    ${UpdateEmail_txb_string}=  set variable    ${MYGOGORO_ACCOUNT}
    Run Keyword If      '${UpdateEmail_txb_string}' == '${MYGOGORO_ACCOUNT}'      Input Text     //*[@id="1val-email"]      ${CHANGE_ACCOUNT_Y_EMAIL}
    ...     ELSE       
    ...     Input Text      //*[@id="1val-email"]      ${MYGOGORO_ACCOUNT}
    Input Text      //*[@id="1val-password"]        Gogoro123

Change Invalid Account Email
    [Documentation]    Change invalid email in my profile page
    Input Text     //*[@id="1val-email"]       ${CHANGE_INVALID_ACCOUNT_EMAIL}
    Input Text     //*[@id="1val-password"]        Gogoro123

Change Account New Password
    [Documentation]    Change valid password in my profile page
    Input Text      //*[@id="1val-password"]        ${PASSWORD1}
    Input Text      //*[@id="1val-new-password"]        ${PASSWORD2}
    Input Text      //*[@id="1val-new-password-confirm"]        ${PASSWORD2}
    # Press Key   //*[@id="1val-new-password-confirm"]    \\13
    # Press \\13(Enter key) in  //*[@id="1val-new-password-confirm"]
    Sleep       2s
    # Go to       https://pa-network-my.gogoro.com/logout
    Click Element        //*[@id="app"]/div[2]/div/form/section[5]/div/button
Change Account Old Password
    [Documentation]    Change valid password in my profile page
    Input Text      //*[@id="1val-password"]        ${PASSWORD2}
    Input Text      //*[@id="1val-new-password"]        ${PASSWORD1}
    Input Text      //*[@id="1val-new-password-confirm"]        ${PASSWORD1}
    # Press Key   //*[@id="1val-new-password-confirm"]    \\13
    # Press \\13(Enter key) in  //*[@id="1val-new-password-confirm"]
    Sleep       2s
    # Go to       https://pa-network-my.gogoro.com/logout
    Click Element       //*[@id="app"]/div[2]/div/form/section[5]/div/button

Change Account Password by Wrong Password Format
    [Documentation]    Change invalid password format in my profile page
    Input Text      //*[@id="1val-password"]        ${PASSWORD1}
    Input Text      //*[@id="1val-new-password"]        ${PASSWORD2}+!@#$
    Input Text      //*[@id="1val-new-password-confirm"]        ${PASSWORD2}+!@#$

Change Account Password by Wrong Password String
    [Documentation]    Change wrong password string length in my profile page
    Input Text      //*[@id="1val-password"]        ${PASSWORD1}
    Input Text      //*[@id="1val-new-password"]        Go1
    Input Text      //*[@id="1val-new-password-confirm"]        Go1


Change Account Password by Confirm Wrong Password
    [Documentation]    Change valid password in my profile page
    Input Text      //*[@id="1val-password"]        ${PASSWORD1}
    Input Text      //*[@id="1val-new-password"]        ${PASSWORD2}
    Input Text      //*[@id="1val-new-password-confirm"]        ${PASSWORD2}123

Einvoice Setting
    Assign Id To Element    //*[@id="app"]/div[2]/div/form/section[4]/div[1]/div/div[1]/label[1]/label       Einvoice_radiobtn
    Click Element    Einvoice_radiobtn

Paper Invoice Setting
    Assign Id To Element    //*[@id="app"]/div[2]/div/form/section[4]/div[1]/div/div[2]/label/label       PaperInvoice_radiobtn
    Click Element    PaperInvoice_radiobtn

Donate Setting
    Assign Id To Element    //*[@id="app"]/div[2]/div/form/section[4]/div[1]/div/div[1]/label[2]/label       Donate_radiobtn
    Click Element    Donate_radiobtn
    Assign Id To Element        //*[@id="2val-e-carrier-donate-to"]/option[5]     Donate_list
    Wait Until Element Is Visible       Donate_list     timeout=20
    Click Element   Donate_list
    Sleep       2s
    # Click Element   //*[@id="2val-e-carrier-donate-to"]/option[5]       




# -------- Mygogoro Element -------- 
Saved Account Information
    Assign Id To Element    //*[@id="app"]/div[2]/div/form/section[5]/div/button    MyProfileSave_btn
    Wait Until Element Is Visible   MyProfileSave_btn   timeout=20
    Click Element       MyProfileSave_btn


Navigate To My Profile Page
    [Documentation]   Navigate To My Profile Page after click left menu
    Assign Id To Element    //*[@id="Top_Container"]/div[2]/aside/ul[2]/li     MyProfile_btn
    #將Element的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  MyProfile_btn   timeout=20
    Sleep    5s                     
    Click element   MyProfile_btn

Click Avatar JPG
    Wait Until Element Is Visible  //*[@id="app"]/div[1]/div/a/div[1]
    Click Element   //*[@id="app"]/div[1]/div/a/div[1]
    Wait Until Element Is Visible   //html/body/div/div/div/div/div[2]/div
    Wait Until Element Is Enabled    //html/body/div/div/div/div/div[2]/div/div/input
    Choose File    //html/body/div/div/div/div/div[2]/div/div/input    ${normalize_path_jpg}

Click Avatar PNG
    Wait Until Element Is Visible  //*[@id="app"]/div[1]/div/a/div[1]
    Click Element   //*[@id="app"]/div[1]/div/a/div[1]
    Wait Until Element Is Visible   //html/body/div/div/div/div/div[2]/div
    Wait Until Element Is Enabled    //html/body/div/div/div/div/div[2]/div/div/input
    Choose File    //html/body/div/div/div/div/div[2]/div/div/input    ${normalize_path_png}

Click Avatar Invalid File
    Wait Until Element Is Visible  //*[@id="app"]/div[1]/div/a/div[1]
    Click Element   //*[@id="app"]/div[1]/div/a/div[1]
    Wait Until Element Is Visible   //html/body/div/div/div/div/div[2]/div
    Wait Until Element Is Enabled    //html/body/div/div/div/div/div[2]/div/div/input
    Choose File    //html/body/div/div/div/div/div[2]/div/div/input    ${normalize_path_incorrect_format_pdf}


# -------- Verify Keyword -------- #   
Check go to myprofile page
    [Documentation]    In my profile page
    Assign Id To Element    //*[@id="app"]/div[2]/div/div/div       MyProfile_page_title
    #將Element的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  MyProfile_page_title   timeout=20

Verify Menu Myprofile String 
    [Arguments]    ${expected}
    [Documentation]    Check the Menu Myprofile String of pages
    ${menu_string}=    Get Text     //html/body/main/div[2]/aside/ul[2]/li/a 
    Should Be Equal As Strings    ${menu_string}    ${expected}

Verify Gender Is Leagl Role
    [Arguments]    ${expected}
    [Documentation]    Check the Gender Is Leagl Role of pages
    ${gender_string}=    Get Text     //*[@id="app"]/div[2]/div/form/section[1]/div[1]/div/label 
    Should Be Equal As Strings    ${gender_string}    ${expected}

Verify Gender Is Male Role
    [Arguments]    ${expected}
    [Documentation]    Check the Gender Is Male Role of pages
    ${gender_string}=    Get Text     //*[@id="app"]/div[2]/div/form/section[1]/div[1]/div[1]/label
    Should Be Equal As Strings    ${gender_string}    ${expected}

Verify Account Information
    [Arguments]    ${expected}
    [Documentation]    Verify Account Information of pages
    ${FirstName_txb_string}=    Get Value     //*[@id="1val-firstName"]
    Should Be Equal As Strings    ${FirstName_txb_string}    ${expected}

Verify Account New Password
    Assign Id To Element    //*[@id="1val-username"]    Login_email  
    Wait Until Element Is Visible  Login_email   timeout=20
    Input Text  //input[@type="text"][@name="email"]     ${MYGOGORO_ACCOUNT}
    Assign Id To Element    //*[@id="1val-password"]    Login_password
    Wait Until Element Is Visible  Login_email   timeout=20
    Input Text  //input[@type="password"][@name="password"]     ${PASSWORD2}
    Assign Id To Element    //*[@id="app"]/div/div/div/div[3]/button   Login_button
    Wait Until Element Is Visible  Login_button   timeout=20
    Click element   Login_button

Verify Account Old Password
    Assign Id To Element    //*[@id="1val-username"]    Login_email
    Wait Until Element Is Visible  Login_email   timeout=20
    Input Text  //input[@type="text"][@name="email"]     ${MYGOGORO_ACCOUNT}
    Assign Id To Element    //*[@id="1val-password"]    Login_password
    Wait Until Element Is Visible  Login_email   timeout=20
    Input Text  //input[@type="password"][@name="password"]     ${PASSWORD1}
    Assign Id To Element    //*[@id="app"]/div/div/div/div[3]/button    Login_button
    Wait Until Element Is Visible  Login_button   timeout=20
    Click element   Login_button

Verify Account Password Format Msssage
    [Arguments]    ${expected}
    [Documentation]    Verify Account Information of pages
    ${Format_notmatch_string}=    Get text     //*[@id="app"]/div[2]/div/form/section[3]/div[3]/span
    Should Be Equal As Strings    ${Format_notmatch_string}    ${expected}

Verify Account Password String Length Msssage
    [Arguments]    ${expected}
    [Documentation]    Verify Account Information of pages
    ${Format_notmatch_string}=    Get text     //*[@id="app"]/div[2]/div/form/section[3]/div[3]/span
    Should Be Equal As Strings    ${Format_notmatch_string}    ${expected}


Verify Account Confirm Password Message
    [Arguments]    ${expected}
    [Documentation]    Verify Account Information of pages
    ${Password_notmatch_string}=    Get text     //*[@id="app"]/div[2]/div/form/section[3]/div[4]/span
    Should Be Equal As Strings    ${Password_notmatch_string}    ${expected}

Verify Einvoice Setting Is Einvoice
    [Arguments]    ${expected}
    [Documentation]    Check the Einvoice Setting Is Einvoice of pages
    ${einvoice_string}=    Get Text     //*[@id="app"]/div[2]/div/form/section[4]/p[2]
    Should Be Equal As Strings    ${einvoice_string}    ${expected}

Verify Einvoice Setting Is Paper Invoice
    [Arguments]    ${expected}
    [Documentation]    Check the Einvoice Setting Is paper invoice of pages
    ${einvoice_string}=    Get Text     //*[@id="app"]/div[2]/div/form/section[4]/p[2]
    Should Be Equal As Strings    ${einvoice_string}    ${expected}

Verify Einvoice Setting Is Donate   
    [Arguments]    ${expected}
    [Documentation]    Check the Einvoice Setting Is Donate of pages
    ${einvoice_string}=    Get Text     //*[@id="2val-e-carrier-donate-to"]/option[5]
    Should Be Equal As Strings    ${einvoice_string}    ${expected}

Verify Email Format From Myprofile
    [Arguments]    ${expected}
    [Documentation]    Check the Email format error message
    ${email_format_string}=    Get Text     //*[@id="app"]/div[2]/div/form/section[3]/div[1]/span
    Should Be Equal As Strings    ${email_format_string}    ${expected}


Verify My Profile Page Display As Expected
    [Documentation]    Verfiy my profile page display as expected
    Wait Until Page Contains Element    //*[@class="SideMenu__ItemNavLink-sc-8uehm8-6 dLTdbe active"]
    Page Should Contain    帳號與密碼設定

Verify Avatar Format Message- Title
    [Arguments]    ${expected}
    [Documentation]    Check the message correct after upload invalid format to avatar
    ${Invalid_avatar_format_message}=    Get Text     //*[@id="swal2-title"]
    Should Be Equal As Strings    ${Invalid_avatar_format_message}    ${expected} 
    # Click Rounded Button    確認

Verify Avatar Format Message- Content
    [Arguments]    ${expected}
    [Documentation]    Check the message correct after upload invalid format to avatar
    ${Invalid_avatar_format_message_content}=    Get Text     //html/body/div[4]/div/div[2]
    Should Be Equal As Strings    ${Invalid_avatar_format_message_content}    ${expected} 
    # Click Rounded Button    確認