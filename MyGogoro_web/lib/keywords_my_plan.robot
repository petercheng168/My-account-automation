*** Keywords ***
# -------- MyGogoro Elements -------- #
Access To My Plan Page Old
    [Documentation]    Access to my plan page
    Wait Until Element Is Enabled    //*[@id="app"]/div[2]/aside/ul[1]/li/a[contains(.,"我的電池服務資費")]
    Click Element    //*[@id="app"]/div[2]/aside/ul[1]/li/a[contains(.,"我的電池服務資費")]

Click 30 Days Free trial Sport Mode Addon Button Old
    [Documentation]    Click 30 days free trial sport mode addon in my-plan page
    Sleep    0.5s
    Wait Until Element Is Enabled    //*[@id="home"]//button/span[contains(.,"30 天免費試用")]
    Click Element    //*[@id="home"]//button/span[contains(.,"30 天免費試用")]

Click Disable 30 Days Free trial Sport Mode Addon Button Old
    [Documentation]    Click disable 30 days free trial sport mode addon in my-plan page
    Sleep    0.5s
    Wait Until Element Is Enabled    //*[@id="home"]//button/span[contains(.,"取消試用")]
    Click Element    //*[@id="home"]//button/span[contains(.,"取消試用")]

# -------- MyGogoro Keywords --------
Confirm Disable 30 Days Free trial Addon Dialog Old
    [Documentation]    Confirm disable 30 days free addon dialog
    Wait Until Element Is Visible    //h2[contains(.,"取消訂閱成功")]    5s
    Click Element    (//*[contains(@class,'RoundedButton__ThemedButton-iaiki0-0')][contains(.,"確認")])[2]

Confirm Enable 30 Days Free Addon Dialog Old
    [Documentation]    Confirm enable 30 days free addon dialog
    Wait Until Element Is Visible    //h2[contains(.,"啟用成功")]    5s
    Click Rounded Button    確認

# -------- Verify Keywords --------
Verify Addon Card Message Display As Expected Old
    [Arguments]    ${message}
    [Documentation]    Verfiy addon card message display correctly
    Wait Until Page Contains Element    //*[@class="SportModeTrial__Container-m5umnk-0 gSZhHs"]
    Page Should Contain    ${message}

Verify My Plan Page Display Bill Card As Expected Old
    [Documentation]    Verfiy my plan page display bill card as expected
    Wait Until Page Contains Element    //*[@class="Card__StyledCard-nrbflk-0 Bill__StyledCard-sc-16hvvnf-0 ioTWjF"]
    Page Should Contain    帳單資訊