*** Variables ***
${normalize_path}    ${PROJECT_ROOT}/MyGogoro_web/res/car.png
${normalize_path_incorrect_format}    ${PROJECT_ROOT}/MyGogoro_web/res/giveup.pdf


*** Keywords ***
# -------- MyGogoro Elements -------- #
Choose Another Plan
    [Documentation]    Choose another plan
    [Arguments]    ${plan_name}
    Wait Until Element Is Enabled    //div[@class="PlanCard__Container-sc-18qyffm-0 dNuQIh"][contains(.,"${plan_name}")]
    Click Element    //div[@class="PlanCard__Container-sc-18qyffm-0 dNuQIh"][contains(.,"${plan_name}")]    30s

Click Addon Card
    [Documentation]    Click addon card to remove it
    Wait Until Element Is Enabled    //div[@class="SportModeTrial__Container-m5umnk-0 gSZhHs"][contains(.,"30 天免費試用")]
    Click Element    //div[@class="SportModeTrial__Container-m5umnk-0 gSZhHs"][contains(.,"30 天免費試用")]

Click Agree Es Contract Checkbox
    [Documentation]    Click agree es-contract checkbox
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/div[2]/label/label[contains(.,"我已閱讀並同意電池服務合約")]
    Click Element    //*[@id="app"]/div[2]/div/div[2]/label/label[contains(.,"我已閱讀並同意電池服務合約")]

Click Agree Terms And Conditions Checkbox
    [Documentation]    Click agree terms and conditions checkbox
    Sleep    0.5s
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/label/label[contains(.,"已閱讀並同意使用此帳號簽署服務合約")]
    Click Element    //*[@id="app"]/div[2]/div/label/label[contains(.,"已閱讀並同意使用此帳號簽署服務合約")]

Click Agree Use Personal Data
    [Documentation]    Click agree gogoro use personal data
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/div[2]/label/label[contains(.,"我已同意並閱讀個資使用同意書")]
    Click Element    //*[@id="app"]/div[2]/div/div[2]/label/label[contains(.,"我已同意並閱讀個資使用同意書")]

Click To Clear The Signed Canvas
    [Documentation]    Click clear to clear the signed canvas
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/p[contains(.,"需要重新簽名嗎？")]    10s
    Wait Until Keyword Succeeds    10s    2s    Click Element    //*[@id="app"]/div[2]/div/p/button[contains(.,"清除")]
    

Click I Agree Activate Contract Checkbox
    [Documentation]    Click I agree to activate the contract
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/label/label[contains(.,"我是使用者本人、法定代理人、或授權之人，我已確認以上資訊無誤並同意啟用電池服務合約。")]    10s
    Wait Until Keyword Succeeds    10s    2s    Click Element    //*[@id="app"]/div[2]/div/label/label[contains(.,"我是使用者本人、法定代理人、或授權之人，我已確認以上資訊無誤並同意啟用電池服務合約。")]

Click Input Account Information Checkbox
    [Documentation]    Click input account information checkbox in new subscription flow
    Sleep    0.5s
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/form/div[1]/label/label[contains(.,"帶入我的帳號資料")]
    Click Element    //*[@id="app"]/div[2]/div/form/div[1]/label/label[contains(.,"帶入我的帳號資料")]

Click Upload Back ID Card Button
    [Documentation]    Click upload Id card button
    Wait Until Element Is Visible    //img[@src="/images/icon-success-1paq9Zw.svg"]     100s
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/form/div[2]/div/div[2]/div[contains(.,"身分證背面")]
    Choose File    //*[@id="app"]/div[2]/div/form/div[2]/div/div[2]/div/input    ${normalize_path}

Click Upload Front ID Card Button
    [Documentation]    Click upload Id card button
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/form/div[2]/div/div[1]/div[contains(.,"身分證正面")]    50s
    Choose File    //*[@id="app"]/div[2]/div/form/div[2]/div/div[1]/div/input    ${normalize_path}

Click Upload Scooter License Button
    [Documentation]    Click upload scooter license button
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/form/div[1]/div/div/div[contains(.,"行照")]    50s
    Choose File    //*[@id="app"]/div[2]/div/form/div[1]/div/div/div/input    ${normalize_path}

Click Upload Incorrect Back ID Card Button
    [Documentation]    Click upload incorrect Id card button
    Wait Until Element Is Visible    //img[@src="/images/icon-success-1paq9Zw.svg"]     50s
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/form/div[2]/div/div[2]/div[contains(.,"身分證背面")]
    Choose File    //*[@id="app"]/div[2]/div/form/div[2]/div/div[2]/div/input    ${normalize_path_incorrect_format}

Click Upload Incorrect Front ID Card Button
    [Documentation]    Click upload incorrect Id card button
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/form/div[2]/div/div[1]/div[contains(.,"身分證正面")]    10s
    Choose File    //*[@id="app"]/div[2]/div/form/div[2]/div/div[1]/div/input    ${normalize_path_incorrect_format}

Click Upload Incorrect Scooter License Button
    [Documentation]    Click upload incorrect scooter license button
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/form/div[1]/div/div/div[contains(.,"行照")]    50s
    Choose File    //*[@id="app"]/div[2]/div/form/div[1]/div/div/div/input    ${normalize_path_incorrect_format}

Input Scooter And Battery Information
    [Documentation]    Input scooter and battery information at new subscription flow
    [Arguments]    ${field}    ${input}
    Wait Until Element Is Enabled    //input[@type="text"][@placeholder="${field}"]    100s
    Input Text    //input[@type="text"][@placeholder="${field}"]    ${input}

Sign Canvas
    [Documentation]    Sign canvas in new subscription flow
    Sleep    5s
    Wait Until Element Is Enabled    //canvas[@class="SigningArea__StyledSigningPad-p4fa1g-4 JrsyE"]
    Mouse Down    //canvas[@class="SigningArea__StyledSigningPad-p4fa1g-4 JrsyE"]

Click Button To Turn Contract Into Draft In ID Card Page
    Click Button Type Button    點此暫存

Return To Correct Step After click Button
    Click Button Type Button    繼續完成合約


# -------- MyGogoro Keywords --------
Agree And Activate Es Contract
    [Documentation]    Agree and activate es-contract
    Click I Agree Activate Contract Checkbox
    Click Button Type Button    下一步
    Click Button Type Button    完成

Agree Terms And Conditions
    [Documentation]    Agree terms/condiitions and click next step
    Click Agree Terms And Conditions Checkbox
    Click Button Type Button    下一步

Change Plan And Confirm
    [Documentation]    Change plan and confirm
    [Arguments]    ${plan_name}
    Wait Until Element Is Enabled    //button[@type="button"][contains(.,"更改電池服務資費方案")]    30s
    Click Button Type Button    更改電池服務資費方案
    Choose Another Plan    ${plan_name}
    Click Button Type Button    下一步

    
    Click Button Type Button    確認
    Click Addon Card
    Click Button Type Button    下一步
    Wait Until Element Is Visible    //*[@id="app"]/div[2]/div/section[2]/div/label[contains(.,"${plan_name}")]    10s

Choose Es Contract Settings
    [Documentation]    Choose es-contract setting, include es-plan, addon and invoice settings
    [Arguments]    ${addon}=default
    Click Button Type Button    下一步  #選Plan
    Click Button Type Button    確認    #確認plan
    Click Button Type Button    下一步  #確認接受系統開通設定費
    Run Keyword Unless    '${addon}' == 'default'    Click Addon Card
    Click Button Type Button    下一步   #addon 開啟
    Run Keyword If    '${addon}' == 'default'    Click Button Type Button    確認
    Click Submit Type Button    下一步

Choose Es Contract Settings Cancel Disclaimer
    [Documentation]    Choose es-contract setting cancel disclaimer
    [Arguments]    ${addon}=default
    Click Button Type Button    下一步  #選Plan
    Click Button Type Button    取消    #取消plan

Choose Es Contract Settings Cancel System Pay
    [Documentation]    Choose es-contract setting cancel system pay
    [Arguments]    ${addon}=default
    Click Button Type Button    下一步  #選Plan
    Click Button Type Button    確認    #確認plan
    Click Button Type Button    上一步  #確認取消系統開通設定費

Choose Es Contract Settings Cancel Addon Setting
    [Documentation]    Choose es-contract setting cancel addon setting
    [Arguments]    ${addon}=default
    Click Button Type Button    下一步  #選Plan
    Click Button Type Button    確認    #確認plan
    Click Button Type Button    下一步  #確認接受系統開通設定費
    Click Button Type Button    上一步  #確認取消addon 設定

Choose Es Contract Settings Disable Addon       #Addon default is enable
    [Documentation]    Choose es-contract setting cancel system pay
    [Arguments]    ${addon}=default
    Click Button Type Button    下一步  #選Plan
    Click Button Type Button    確認    #確認plan
    Click Button Type Button    下一步  #確認接受系統開通設定費
    Run Keyword Unless    '${addon}' == 'default'    Click Addon Card
    Click Button Type Button    上一步  #確認取消addon 設定

Choose Es Contract Settings Cancel Invoice Setting
    [Documentation]    Choose es-contract setting cancel invoice settings 
    [Arguments]    ${addon}=default
    Click Button Type Button    下一步  #選Plan
    Click Button Type Button    確認    #確認plan
    Click Button Type Button    下一步  #確認接受系統開通設定費
    Run Keyword Unless    '${addon}' == 'default'    Click Addon Card
    Click Button Type Button    下一步   #addon 開啟
    Run Keyword If    '${addon}' == 'default'    Click Button Type Button    確認
    Click Button Type Button    上一步  #確認取消invocie 設定

Choose Es Contract Settings Select Paper Invoice Then Cancel
    [Documentation]    Choose es-contract setting cancel invoice settings 
    [Arguments]    ${addon}=default
    Click Button Type Button    下一步  #選Plan
    Click Button Type Button    確認    #確認plan
    Click Button Type Button    下一步  #確認接受系統開通設定費
    Run Keyword Unless    '${addon}' == 'default'    Click Addon Card
    Click Button Type Button    下一步   #addon 開啟
    Run Keyword If    '${addon}' == 'default'    Click Button Type Button    確認
    Click Element           //


Input User Information As Subscriber
    [Documentation]    Input user information as Subscriber
    Click Input Account Information Checkbox
    Click Submit Type Button    下一步

Input User Information As Subscriber But Cancel
    [Documentation]    Input user information as Subscriber
    Click Input Account Information Checkbox
    Click Button Type Button    取消

Send Es Contract To User Email After Sign A Signature
    [Documentation]    Sign es-contract
    Sign Canvas
    Click Agree Es Contract Checkbox
    Wait Until Element Is Enabled       //*[@id="app"]/div[2]/div/footer/button[2]      timeout=30
    Click Button Type Button    簽下一份
    Sleep   6s
    Sign Canvas
    Click Agree Use Personal Data
    Wait Until Element Is Enabled       //*[@id="app"]/div[2]/div/footer/button[2]      timeout=30
    Click Button Type Button    簽署完成
    Sleep   5s
    Wait Until Element Is Enabled       //*[@id="app"]/div[2]/div/h2      timeout=30
    Click Submit Type Button    下一步      #After signature next step button

Signed Battery Contract Again
    [Documentation]    Signed battery contract of es-contract again
    Sign Canvas
    Click Agree Es Contract Checkbox
    Wait Until Element Is Enabled       //*[@id="app"]/div[2]/div/footer/button[2]      timeout=30
    Click To Clear The Signed Canvas
    Element Should Be Disabled       //*[@id="app"]/div[2]/div/footer/button[2]         #確認button 是disabled 的狀態, enable 則是需要條件成立才可以

Signed Personal Data Agreement Again
    [Documentation]    Signed battery contract of es-contract again
    Sign Canvas
    Click Agree Es Contract Checkbox
    Wait Until Element Is Enabled       //*[@id="app"]/div[2]/div/footer/button[2]      timeout=30
    Click Button Type Button    簽下一份
    Sleep   5s
    Sign Canvas
    Click Agree Use Personal Data
    Wait Until Element Is Enabled       //*[@id="app"]/div[2]/div/footer/button[2]      timeout=30
    Click To Clear The Signed Canvas
    Element Should Be Disabled       //*[@id="app"]/div[2]/div/footer/button[2]         #確認button 是disabled 的狀態, enable 則是需要條件成立才可以



Upload User Id Card
    [Documentation]    Upload user front/back Id card
    Click Upload Front ID Card Button
    Click Upload Back ID Card Button
    Click Submit Type Button    下一步

Upload Incorrect User Front Id Card
    [Documentation]    Upload user front/back Id card
    Click Upload Incorrect Front ID Card Button
    # Click Upload Back ID Card Button
    # Click Submit Type Button    下一步

Upload Incorrect User Back Id Card
    [Documentation]    Upload user front/back Id card
    Click Upload Front ID Card Button
    Click Upload Incorrect Back ID Card Button

Upload User Scooter Information
    [Documentation]    Upload user scooter information
    [Arguments]    ${plate}    ${user_name}    ${scooter_vin}    ${last_six_battery_sn}
    Click Upload Scooter License Button
    Input Scooter And Battery Information    您的車牌號碼    ${plate}
    Input Scooter And Battery Information    車主姓名    ${user_name}
    Input Scooter And Battery Information    車身號碼    ${scooter_vin}
    Sleep   2s
    Input Scooter And Battery Information    請輸入電池序號末 6 碼    ${last_six_battery_sn}
    log     ${plate}
    log     ${user_name}
    log     ${scooter_vin}
    log     ${last_six_battery_sn}
    Click Button Type Button    下一步
    Click Button Type Button    確認

Upload User Scooter Information For BillingV1
    [Documentation]    Upload user scooter information for billing v1.0
    [Arguments]    ${plate}    ${user_name}    ${scooter_vin}    ${last_six_battery_sn}
    Click Upload Scooter License Button
    Input Scooter And Battery Information    車牌號碼    ${plate}
    Input Scooter And Battery Information    車主姓名    ${user_name}
    Input Scooter And Battery Information    車身號碼    ${scooter_vin}
    Sleep   2s
    Input Scooter And Battery Information    請輸入電池序號末 6 碼    ${last_six_battery_sn}
    log     ${plate}
    log     ${user_name}
    log     ${scooter_vin}
    log     ${last_six_battery_sn}
    Click Button Type Button    下一步
    Click Button Type Button    確認

Upload Incorrect Scooter License
    [Documentation]    Upload incorrrect scooter license
    Click Upload Incorrect Scooter License Button
    Element Should Be Disabled          //*[@id="app"]/div[2]/div/form/footer/button

Upload User Scooter Information Only Plate
    [Documentation]    Upload user scooter information only plate
    [Arguments]    ${plate}    
    Click Upload Scooter License Button
    Input Scooter And Battery Information    您的車牌號碼    ${plate}
    Element Should Be Disabled          //*[@id="app"]/div[2]/div/form/footer/button

Upload User Scooter Information Only User Name
    [Documentation]    Upload user scooter information only username
    [Arguments]    ${user_name}    
    Click Upload Scooter License Button
    Input Scooter And Battery Information    車主姓名    ${user_name}
    Element Should Be Disabled          //*[@id="app"]/div[2]/div/form/footer/button

Upload User Scooter Information Only Scooter Vin
    [Documentation]    Upload user scooter information only scooter vin
    [Arguments]    ${scooter_vin}    
    Click Upload Scooter License Button
    Input Scooter And Battery Information    車身號碼    ${scooter_vin}

Upload User Scooter Information Only Battery Number
    [Documentation]    Upload user scooter information only battery number
    [Arguments]    ${last_six_battery_sn}
    Click Upload Scooter License Button
    Input Scooter And Battery Information    請輸入電池序號末 6 碼    ${last_six_battery_sn}

Upload User Scooter Information For Wrong Plate
    [Documentation]    Upload user scooter information wrong message check
    [Arguments]    ${plate}    ${user_name}    ${scooter_vin}    ${last_six_battery_sn}
    Click Upload Scooter License Button
    Input Scooter And Battery Information    您的車牌號碼    GGR-1234
    Input Scooter And Battery Information    車主姓名    ${user_name}
    Input Scooter And Battery Information    車身號碼    ${scooter_vin}
    Input Scooter And Battery Information    請輸入電池序號末 6 碼    ${last_six_battery_sn}
    Click Button Type Button    下一步


# -------- Verify Keywords --------   
Verify Page URL In Login Page
    Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://pa-network-my.gogoro.com/login
    # “Verify Page URL” setting in keywords_common.robot

# Verify Page URL In Forgot Password Page
#     Wait Until Keyword Succeeds    10s    2s    Verify Page URL    https://pa-network-my.gogoro.com/forgot-password 
#     # “Verify Page URL” setting in keywords_common.robot

Verify In Newsub Page
    [Arguments]    ${expected}
    [Documentation]    Check the newsub page is correct
    ${Newsub_page}=    Get Text     //*[@id="app"]/div/div/div/h2
    Should Be Equal As Strings    ${Newsub_page}    ${expected}  

Verify In Newsub User Profile Page
    [Arguments]    ${expected}
    [Documentation]    Check the user profile page is correct
    ${Newsub_user_page}=    Get Text     //*[@id="app"]/div[2]/div/h2
    Should Be Equal As Strings    ${Newsub_user_page}    ${expected}  

Verify In Newsub Choose Plan Page
    [Arguments]    ${expected}
    [Documentation]    Check the choose plan page is correct
    ${Newsub_plan_page}=    Get Text     //*[@id="app"]/div[2]/div/h2
    Should Be Equal As Strings    ${Newsub_plan_page}    ${expected}  

Verify In Upload ID Card Or License Page 
    [Arguments]    ${expected}
    [Documentation]    Check the upload ID card page error message is correct
    ${Newsub_ID_card_page}=    Get Text     //html/body/div[4]/div
    Should Be Equal As Strings    ${Newsub_ID_card_page}    ${expected}  

Verify Scooter Plate Is Blank In Upload Information Page  
    [Arguments]    ${expected}     
    [Documentation]    Check the upload information page scooter plate is blank
    ${Scooter_plate_blank}=    Get Text     //*[@id="app"]/div[2]/div/form/div[2]/span
    Should Be Equal As Strings    ${Scooter_plate_blank}    ${expected}  

Verify Scooter User Name Is Blank In Upload Information Page  
    [Arguments]    ${expected}     
    [Documentation]    Check the upload information page user name is blank
    ${User_name_blank}=    Get Text     //*[@id="app"]/div[2]/div/form/div[3]/span
    Should Be Equal As Strings    ${User_name_blank}    ${expected}  

Verify Scooter Vin Is Blank In Upload Information Page  
    [Arguments]    ${expected}     
    [Documentation]    Check the upload information page scooter vin is blank
    ${Scooter_Vin_blank}=    Get Text     //*[@id="app"]/div[2]/div/form/div[4]/span
    Should Be Equal As Strings    ${Scooter_Vin_blank}    ${expected}  

Verify Battery Num Is Blank In Upload Information Page  
    [Arguments]    ${expected}     
    [Documentation]    Check the upload information page battery number is blank
    ${Battery_num_blank}=    Get Text     //html/body/main/div[2]/div/form/div[8]/span
    Should Be Equal As Strings    ${Battery_num_blank}    ${expected}  

Verify Remaining Steps 
    [Arguments]    ${expected}     
    [Documentation]    The remaining steps
    ${Remaining_steps}=    Get Text     //*[@id="app"]/div/div/div/div/ol/li[2]/div/span
    Should Be Equal As Strings    ${Remaining_steps}    ${expected}  

Verify Upload ID Card Page 
    Wait Until Element Is Visible    //*[@id="app"]/div[2]/div/h2   10s
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/div/form/div[2]/div/div[2]/div[contains(.,"身分證背面")]