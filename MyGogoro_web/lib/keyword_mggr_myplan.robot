*** Keywords ***

# <paper invoice set in myplan group>
Paper Invoice Setting In MyPlan
    Wait Until Keyword Succeeds    10s    2s   Verify Invoice Setting Strings In My Plan        發票寄送設定\n目前設定為 會員載具，如需更改請至會員資料頁修改
    Click Element   //*[@id="home"]/div[6]/p[2]/a
    

# </paper invoice set in myplan group>       


# -------- MyGogoro Keyword --------  # 


# -------- MyGogoro Elements -------- # 

Open Invoice Setting From MyPlan
    Assign Id To Element       //*[@id="home"]/div[7]/p[2]/span[2]         Invoive_change_btn
    Click Element       Invoive_change_btn

Slelect E-Invoice
    Assign Id To Element       //*[@id="home"]/div[7]/div/div[1]/label      E_invoice_radiobtn
    Click Element       E_invoice_radiobtn

Slelect Paper Invoice
    Assign Id To Element    //*[@id="home"]/div[7]/div/div[2]/label     Paper_invoice_radiobtn
    Click Element       Paper_invoice_radiobtn

Saved Invoice Setting In MyPlan
    Assign Id To Element    //*[@id="home"]/div[7]/button    MyPlanSave_btn
    Wait Until Element Is Visible   MyPlanSave_btn   timeout=20
    Click Element       MyPlanSave_btn

Saved Msg Of MyPlan Invoive 
    Assign Id To Element    //html/body/div[8]/div/div[2]/footer/button    MyPlanMsg_btn
    Wait Until Element Is Visible   MyPlanMsg_btn   timeout=20
    Click Element       MyPlanMsg_btn    


# -------- Verify Keyword -------- #    
Check Go To Myplan Page
    [Documentation]    In my plan page
    Assign Id To Element    //*[@id="app"]/div[2]/div/div[1]/div        MyPlan_page_title
     #將Element的xpath 指定一個ID name (好辨別且也可直接沿用ID name)
    Wait Until Element Is Visible  MyPlan_page_title   timeout=20
     #等待元件出現, 時間20秒

Verify Menu Myplan String 
    [Arguments]    ${expected}
    [Documentation]    Check the URL of pages
    ${menu_string}=    Get Text     //html/body/main/div[2]/aside/ul[1]/li/a 
    Should Be Equal As Strings    ${menu_string}    ${expected}

Verify Invoice Setting Open From MyPlan
    Wait Until Element Is Visible       //*[@id="home"]/div[7]/div

Verify Invoice Is Set To Paper 
    [Arguments]    ${expected}
    [Documentation]    Check the invoice Setting Is Paper of MyPlan
    ${paper_invoice_string}=    Get Text     //*[@id="home"]/div[7]/p[2]/span[1]  
    Should Be Equal As Strings    ${paper_invoice_string}    ${expected}

Verfiy Invoive Set To Paper Succeed Msg
    [Arguments]    ${expected}
    [Documentation]    Check the invoice Setup to Paper succeed of MyPlan
    ${save_succeed_msg}=    Get Text     //*[@id="swal2-title"]
    Should Be Equal As Strings    ${save_succeed_msg}    ${expected}    

Access To My Plan Page
    [Documentation]    Access to my plan page
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/aside/ul[1]/li/a[contains(.,"我的電池服務資費")]
    Click Element    //*[@id="app"]/div[2]/aside/ul[1]/li/a[contains(.,"我的電池服務資費")]

Click 30 Days Free trial Sport Mode Addon Button
    [Documentation]    Click 30 days free trial sport mode addon in my-plan page
    Sleep    0.5s
    Wait Until Element Is Enabled    //*[@id="home"]//button/span[contains(.,"30 天免費試用")]
    Click Element    //*[@id="home"]//button/span[contains(.,"30 天免費試用")]

Click Disable 30 Days Free trial Sport Mode Addon Button
    [Documentation]    Click disable 30 days free trial sport mode addon in my-plan page
    Sleep    0.5s
    Wait Until Element Is Enabled    //*[@id="home"]//button/span[contains(.,"取消試用")]
    Click Element    //*[@id="home"]//button/span[contains(.,"取消試用")]

# -------- MyGogoro Keywords --------
Confirm Disable 30 Days Free trial Addon Dialog
    [Documentation]    Confirm disable 30 days free addon dialog
    Wait Until Element Is Visible    //h2[contains(.,"取消訂閱成功")]    5s
    Click Element    (//*[contains(@class,'RoundedButton__ThemedButton-iaiki0-0')][contains(.,"確認")])[2]

Confirm Enable 30 Days Free Addon Dialog
    [Documentation]    Confirm enable 30 days free addon dialog
    Wait Until Element Is Visible    //h2[contains(.,"啟用成功")]    5s
    Click Rounded Button    確認

# -------- Verify Keywords --------
Verify Addon Card Message Display As Expected
    [Arguments]    ${message}
    [Documentation]    Verfiy addon card message display correctly
    Wait Until Page Contains Element    //*[@class="SportModeTrial__Container-m5umnk-0 gSZhHs"]
    Page Should Contain    ${message}

Verify My Plan Page Display Bill Card As Expected
    [Documentation]    Verfiy my plan page display bill card as expected
    Wait Until Page Contains Element    //*[@class="Card__StyledCard-nrbflk-0 Bill__StyledCard-sc-16hvvnf-0 ioTWjF"]
    Page Should Contain    帳單資訊

Verify The Bundle Plan Cannot Be Change Message
    [Arguments]    ${expected}
    [Documentation]    Check the message correct after click change plan
    ${BundlePlan_cannot_be_changed_message}=    Get Text     //*[@id="app"]/div[2]/div/p
    Should Be Equal As Strings    ${BundlePlan_cannot_be_changed_message}    ${expected} 
    # Click Rounded Button    確認

Verify Wrong Info Plan Cannot Be Change Message
    [Arguments]    ${expected}
    [Documentation]    Check the message correct after fill in wrong information change plan
    ${Wrong_name_message}=    Get Text     //html/body/div[5]/div
    Should Be Equal As Strings    ${Wrong_name_message}    ${expected} 
    Click Rounded Button    確認

Verify Invoice Setting Strings In My Plan
    [Arguments]    ${expected}
    [Documentation]    Check the string correct in my plan
    ${MyPlan_invoice_setting_message}=    Get Text     //*[@id="home"]/div[6]
