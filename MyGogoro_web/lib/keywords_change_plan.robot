*** Keywords ***
# -------- MyGogoro Elements -------- #
Agree Legal Agreement
    [Documentation]    Click agree legal agreement checkbox
    Wait Until Element Is Enabled    //label/label[contains(.,"已詳細閱讀並充分了解且同意線上更改電池服務資費方案使用條款之內容以及個人資料保護告知事項之規定")]
    Click Element    //label/label[contains(.,"已詳細閱讀並充分了解且同意線上更改電池服務資費方案使用條款之內容以及個人資料保護告知事項之規定")]

Click Alert Confirm Button
    [Documentation]    Click alert confirm button at change-plan flow
    Wait Until Element Is Visible    //h2[contains(.,"變更成功")]    5s
    Click Rounded Button    確認

Click Select Plan Button
    [Documentation]    Click select plan button
    [Arguments]    ${plan_name}
    Wait Until Element Is Enabled    //div[@class="PlanCard__Container-sc-18qyffm-0 dNuQIh"][contains(.,"${plan_name}")]/div/button[contains(.,"選擇此方案")]
    Click Element    //div[@class="PlanCard__Container-sc-18qyffm-0 dNuQIh"][contains(.,"${plan_name}")]/div/button[contains(.,"選擇此方案")]

Input User Name
    [Documentation]    Input user name at change-plan flow
    Wait Until Element Is Enabled    //input[@type="text"][@placeholder="請輸入電池服務合約使用者名字 ( 或公司名稱 )"]    30s
    Input Text    //input[@type="text"][@placeholder="請輸入電池服務合約使用者名字 ( 或公司名稱 )"]    ${User.last_name}${User.first_name}

Input Wrong User Name
    [Documentation]    Input user name at change-plan flow
    Wait Until Element Is Enabled    //input[@type="text"][@placeholder="請輸入電池服務合約使用者名字 ( 或公司名稱 )"]    30s
    Input Text    //input[@type="text"][@placeholder="請輸入電池服務合約使用者名字 ( 或公司名稱 )"]    ${User.last_name}${User.first_name}1

Input User ID
    [Documentation]    Input user ID at change-plan flow
    Wait Until Element Is Enabled    //input[@type="text"][@placeholder="請輸入電池服務合約使用者身分證 ( 或護照，公司統編 ) 後五碼"]    30s
    Input Text    //input[@type="text"][@placeholder="請輸入電池服務合約使用者身分證 ( 或護照，公司統編 ) 後五碼"]    56789

Input Wrong User ID
    [Documentation]    Input user ID at change-plan flow
    Wait Until Element Is Enabled    //input[@type="text"][@placeholder="請輸入電池服務合約使用者身分證 ( 或護照，公司統編 ) 後五碼"]    30s
    Input Text    //input[@type="text"][@placeholder="請輸入電池服務合約使用者身分證 ( 或護照，公司統編 ) 後五碼"]    @6789

Select Birthday Value
    [Documentation]    Select birthday value from date select list
    [Arguments]    ${type}    ${value}
    Wait Until Element Is Enabled    //div[@class="DateSelect__SelectGroup-sc-17b7zj1-0 fKBNTO"]/div[contains(.,"${type}")]
    Click Element     //div[@class="DateSelect__SelectGroup-sc-17b7zj1-0 fKBNTO"]/div[contains(.,"${type}")]
    Select From List By Value    //select[contains(.,"${type}")]    ${value}

Select Birthday Wrong Value
    [Documentation]    Select birthday value from date select list
    [Arguments]    ${type}    ${value}
    Wait Until Element Is Enabled    //div[@class="DateSelect__SelectGroup-sc-17b7zj1-0 fKBNTO"]/div[contains(.,"${type}")]
    Click Element     //div[@class="DateSelect__SelectGroup-sc-17b7zj1-0 fKBNTO"]/div[contains(.,"${type}")]
    Select From List By Value    //select[contains(.,"${type}")]    ${value}+1

# -------- MyGogoro Keywords --------
Confirm Change Plan Dialog
    [Documentation]    Confirm change plan
    Click Rounded Button    確認
    Wait Until Element Is Visible    //div[contains(@class,"Modal__ModalHeader-sc-13wp7c6-1")][contains(.,"認證成功")]
    Click Rounded Button    確認
    ${status} =    Run Keyword And Return Status    Wait Until Element Is Visible    //h2[contains(.,"變更成功")]    5s
    Run Keyword If    '${status}' == 'False'    Click Rounded Button    確認
    Click Alert Confirm Button
    
Cancel Change Plan Dialog
    [Documentation]    Confirm change plan
    Click Rounded Button    確認
    Wait Until Element Is Visible    //div[contains(@class,"Modal__ModalHeader-sc-13wp7c6-1")][contains(.,"認證成功")]
    Click Rounded Button    取消
    

Choose User Birthday
    [Documentation]    Choose user birthday at change-plan flow
    [Arguments]    ${year}    ${month}    ${date}
    Select Birthday Value    年    ${year}
    Select Birthday Value    月    ${month}
    Select Birthday Value    日    ${date}

Fill In Change Plan Information
    [Documentation]    Fill in change plan information at change-plan flow
    [Arguments]    ${User}
    Agree Legal Agreement
    Upload User Information
    Choose User Birthday    ${USer.year}    ${User.month}    ${User.date}

Fill In Wrong Name Change Plan Information
    [Documentation]    Fill in wrong name change plan information at change-plan flow
    [Arguments]    ${User}
    Agree Legal Agreement
    Upload Wrong User Name
    Choose User Birthday    ${USer.year}    ${User.month}    ${User.date}

Fill In Wrong ID Change Plan Information
    [Documentation]    Fill in wrong ID change plan information at change-plan flow
    [Arguments]    ${User}
    Agree Legal Agreement
    Upload Wrong User ID
    Choose User Birthday    ${USer.year}    ${User.month}    ${User.date}

Fill In Wrong BD Change Plan Information
    [Documentation]    Fill in wrong BD change plan information at change-plan flow
    [Arguments]    ${User}
    Agree Legal Agreement
    Upload User Information
    Choose User Birthday    ${USer.year}    ${User.month}    22

Upload User Information
    [Documentation]    Input user information at change-plan flow
    Input User Name
    Input User ID

Upload Wrong User Name
    [Documentation]    Input wrong user name at change-plan flow
    Input Wrong User Name
    Input User ID

Upload Wrong User ID
    [Documentation]    Input wrong user ID at change-plan flow
    Input User Name
    Input Wrong User ID

# -------- Verify Keywords --------
Verify Plan Card Message As Expected
    [Arguments]    ${next_plan_start}    ${plan_text}
    [Documentation]    Verfiy plan changed correctly
    Wait Until Page Contains Element    //div[contains(@class,"PlanCard__Container-sc-18qyffm-0")]
    Page Should Contain    您將可以從 ${next_plan_start} 開始享受 ${plan_text}