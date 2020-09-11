*** Settings ***
Documentation    Test suite for MyGogoro Change-plan page by one battery
Resource    ../../init.robot
# Suite Setup    Open Browser    ${MYGOGORO_GN_DOMAIN}    ${WINDOW_HEIGHT}    ${WINDOW_WEIGHT}
Force Tags    MyGogoroWeb    Change-Plan for one battery scooter
Suite Setup    SuiteSetup
# Suite Teardown    Close All Browsers
# Test Teardown    Go To    https://pa-network-my.gogoro.com/my-plan
Test Teardown    Test Teardown
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***   


One battery plan display
    Click Scooter List      2R7-0223        #Select From List By Label (use the plate)            kind of script 1
    Click Rounded Button    查看更多
    Click Rounded Button    變更資費
    Wait until element is visible       //*[@id="app"]/div[2]/div/div[2]/div        10s
    sleep       3s
    Wait Until Keyword Succeeds    2s    2s    Verify Plan 399      $399 騎到飽方案\n月繳 $399，享當月無限里程騎到飽，綁約 3 年。\n享豁免電池遺失或損壞賠償。\n無限次數電池交換。\n選擇此方案
    Wait Until Keyword Succeeds    2s    2s    Verify Plan 449      $449 騎到飽方案\n月繳 $449，享當月無限里程騎到飽，綁約 2 年。\n享豁免電池遺失或損壞賠償。\n無限次數電池交換。\n選擇此方案
    Wait Until Keyword Succeeds    2s    2s    Verify Plan 499      $499 騎到飽方案\n月繳 $499，享當月無限里程騎到飽，並至少使用 3 個月。（已完成 1.騎到飽方案綁約期限或 2. 電信業優惠專案期限者則不在此限。)\n享豁免電池遺失或損壞賠償。\n無限次數電池交換。\n選擇此方案
    Wait Until Keyword Succeeds    2s    2s    Verify Plan 299      $299 自由省方案\n月繳 $299，再依電池使用量，每安時 $2.3 計價。\n享動態折價機制，指定站點單次最高八折優惠。\n內含性能提升服務 ( 價值 $99 / 月 ）。\n享豁免電池遺失或損壞賠償及無限次數電池交換。\n每月首次交換電池即享最高 $200 電池使用費折抵金。\n不支援 GoCharger® 智慧電池標準座及 GoCharger® Plus 智慧電池快充座。\n選擇此方案

One battery scooter change plan fix to 399
    # [Setup]    Test Setup For New Plan    綁定 3 年 $399 方案       
    Click Scooter List      F9F-9309        #Select From List By Label (use the plate)            kind of script 1
    sleep   5s
    Click Rounded Button    查看更多
    Click Rounded Button    變更資費
    Wait until element is visible       //*[@id="app"]/div[2]/div       20s
    Click Select Plan Button    $399 騎到飽方案
    Fill In Change Plan Information For One Battery
    Confirm Change Plan Dialog
    Click Scooter List      F9F-9309 
    Get Next Plan Start Date    XRzkDMNz
    Verify Plan Card Message As Expected    ${next_plan_start}    $399 騎到飽方案
    Verify New Subscription Is Correct    lLddbGzL   ${gogoro-sess}    ${csrf_token}     綁定 3 年 $399 方案

One battery scooter change plan fix to 449
    # [Setup]    Test Setup For New Plan    綁定 2 年 $449 方案       
    Click Scooter List      F9F-9309        #Select From List By Label (use the plate)            kind of script 1
    sleep   5s
    Click Rounded Button    查看更多
    Click Rounded Button    變更資費
    Wait until element is visible       //*[@id="app"]/div[2]/div       20s
    Click Select Plan Button    $449 騎到飽方案
    Fill In Change Plan Information For One Battery
    Confirm Change Plan Dialog
    Click Scooter List      F9F-9309 
    Get Next Plan Start Date    XRzkDMNz
    Verify Plan Card Message As Expected    ${next_plan_start}    $449 騎到飽方案
    Verify New Subscription Is Correct    lLddbGzL   ${gogoro-sess}    ${csrf_token}     綁定 2 年 $449 方案
    
One battery scooter change plan fix to 499
    # [Setup]    Test Setup For New Plan    $499 騎到飽方案      
    Click Scooter List      F9F-9309        #Select From List By Label (use the plate)            kind of script 1
    sleep   5s
    Click Rounded Button    查看更多
    Click Rounded Button    變更資費
    Wait until element is visible       //*[@id="app"]/div[2]/div       20s
    Click Select Plan Button    $499 騎到飽方案
    Fill In Change Plan Information For One Battery
    Confirm Change Plan Dialog
    Click Scooter List      F9F-9309 
    Get Next Plan Start Date    XRzkDMNz
    Verify Plan Card Message As Expected    ${next_plan_start}    $499 騎到飽方案
    Verify New Subscription Is Correct    lLddbGzL   ${gogoro-sess}    ${csrf_token}     $499 騎到飽方案

One battery scooter change plan fix to 299
    # [Setup]    Test Setup For New Plan    $499 騎到飽方案      
    Click Scooter List      F9F-9309        #Select From List By Label (use the plate)            kind of script 1
    sleep   5s
    Click Rounded Button    查看更多
    Click Rounded Button    變更資費
    Wait until element is visible       //*[@id="app"]/div[2]/div       20s
    Click Select Plan Button    $299 自由省方案
    Fill In Change Plan Information For One Battery
    Confirm Change Plan Dialog
    Click Scooter List      F9F-9309 
    Get Next Plan Start Date    XRzkDMNz
    Verify Plan Card Message As Expected    ${next_plan_start}    $299 自由省方案
    Verify New Subscription Is Correct    lLddbGzL   ${gogoro-sess}    ${csrf_token}     $299 自由省方案


One battery scooter change plan flex to 399
    # [Setup]    Test Setup For New Plan    綁定 3 年 $399 方案       
    Click Scooter List      4FW-0832        #Select From List By Label (use the plate)            kind of script 1
    sleep   5s
    Click Rounded Button    查看更多
    Click Rounded Button    變更資費
    Wait until element is visible       //*[@id="app"]/div[2]/div       20s
    Click Select Plan Button    $399 騎到飽方案
    Fill In Change Plan Information For One Battery
    Confirm Change Plan Dialog
    Click Scooter List      4FW-0832
    Get Next Plan Start Date    1Lpb2WNj
    Verify Plan Card Message As Expected    ${next_plan_start}    $399 騎到飽方案
    Verify New Subscription Is Correct    KLXPjKeL   ${gogoro-sess}    ${csrf_token}     綁定 3 年 $399 方案

One battery scooter change plan flex to 449
    # [Setup]    Test Setup For New Plan    綁定 2 年 $449 方案       
    Click Scooter List      4FW-0832        #Select From List By Label (use the plate)            kind of script 1
    sleep   5s
    Click Rounded Button    查看更多
    Click Rounded Button    變更資費
    Wait until element is visible       //*[@id="app"]/div[2]/div       20s
    Click Select Plan Button    $449 騎到飽方案
    Fill In Change Plan Information For One Battery
    Confirm Change Plan Dialog
    Click Scooter List      4FW-0832 
    Get Next Plan Start Date    1Lpb2WNj
    Verify Plan Card Message As Expected    ${next_plan_start}    $449 騎到飽方案
    Verify New Subscription Is Correct    KLXPjKeL   ${gogoro-sess}    ${csrf_token}     綁定 2 年 $449 方案
    
One battery scooter change plan flex to 499
    # [Setup]    Test Setup For New Plan    $499 騎到飽方案      
    Click Scooter List      4FW-0832        #Select From List By Label (use the plate)            kind of script 1
    sleep   5s
    Click Rounded Button    查看更多
    Click Rounded Button    變更資費
    Wait until element is visible       //*[@id="app"]/div[2]/div       20s
    Click Select Plan Button    $499 騎到飽方案
    Fill In Change Plan Information For One Battery
    Confirm Change Plan Dialog
    Click Scooter List      4FW-0832 
    Get Next Plan Start Date    1Lpb2WNj
    Verify Plan Card Message As Expected    ${next_plan_start}    $499 騎到飽方案
    Verify New Subscription Is Correct    KLXPjKeL   ${gogoro-sess}    ${csrf_token}     $499 騎到飽方案

*** Keywords ***

Click Scooter List
        #Select From List By Label   (The list is scooter plate)  kind of script 1
    [Arguments]    ${label}   
    Wait Until Element Is Visible      //*[@id="app"]/div[2]/aside/div/select       #wait the dropdown list function visible
    Click element       //*[@id="app"]/div[2]/aside/div/select                      #click the dropdown list to expand
    Select From List By Label       //*[@id="app"]/div[2]/aside/div/select      ${label}
    #################ㄒ 
    # #Select From List By Index    kind of script 2
    # [Arguments]    ${locator}   
    # Wait Until Element Is Visible      //*[@id="app"]/div[2]/aside/div/select       #wait the dropdown list function visible
    # Click element       //*[@id="app"]/div[2]/aside/div/select                      #click the dropdown list to expand
    # Click element     //*[@id="app"]/div[2]/aside/div/select/option[${locator}]  

    # #Select From List By xpath   kind of script 3
    # Wait Until Element Is Visible      //*[@id="app"]/div[2]/aside/div/select       #wait the dropdown list function visible
    # Click element       //*[@id="app"]/div[2]/aside/div/select                      #click the dropdown list to expand
    # Click element     //*[@id="app"]/div[2]/aside/div/select/option[2]  
    #################



Verify Plan 399
    [Arguments]    ${expected}
    [Documentation]    Check 399 plan conternt correct
    ${Plan_399}=    Get Text     //*[@id="app"]/div[2]/div/div[3]/div/div
    # log to console      ${Plan_399}
    Should Be Equal As Strings    ${Plan_399}    ${expected} 
    
Verify Plan 449
    [Arguments]    ${expected}
    [Documentation]    Check 449 plan conternt correct
    ${Plan_449}=    Get Text     //*[@id="app"]/div[2]/div/div[4]/div/div
    Should Be Equal As Strings    ${Plan_449}    ${expected} 

Verify Plan 499
    [Arguments]    ${expected}
    [Documentation]    Check 499 plan conternt correct
    ${Plan_499}=    Get Text     //*[@id="app"]/div[2]/div/div[5]/div/div
    Should Be Equal As Strings    ${Plan_499}    ${expected} 

Verify Plan 299
    [Arguments]    ${expected}
    [Documentation]    Check 299 plan conternt correct
    ${Plan_299}=    Get Text     //*[@id="app"]/div[2]/div/div[6]/div/div
    Should Be Equal As Strings    ${Plan_299}    ${expected} 

# -------- MyGogoro Elements -------- #
Agree Legal Agreement Fo One Battery
    [Documentation]    Click agree legal agreement checkbox
    Wait Until Element Is Enabled    //label/label[contains(.,"本人已詳細閱讀並充分了解且同意線上更改電池服務資費方案使用條款之內容以及個人資料保護告知事項之規定。")]
    Click Element    //label/label[contains(.,"本人已詳細閱讀並充分了解且同意線上更改電池服務資費方案使用條款之內容以及個人資料保護告知事項之規定。")]

Input User Name For One Battery
    [Documentation]    Input user name at change-plan flow
    Wait Until Element Is Enabled    //input[@type="text"][@placeholder="請輸入電池服務合約使用者名字 ( 或公司名稱 )"]    30s
    Input Text    //input[@type="text"][@placeholder="請輸入電池服務合約使用者名字 ( 或公司名稱 )"]    ${ONE_BATTERY_USER_NAME}

Input User ID For One Battery
    [Documentation]    Input user ID at change-plan flow
    Wait Until Element Is Enabled    //input[@type="text"][@placeholder="請輸入電池服務合約使用者身分證 ( 或護照，公司統編 ) 後五碼"]    30s
    Input Text    //input[@type="text"][@placeholder="請輸入電池服務合約使用者身分證 ( 或護照，公司統編 ) 後五碼"]    55735

Select Birthday Value For One Battery
    [Documentation]    Select birthday value from date select list
    [Arguments]    ${type}    ${value}
    Wait Until Element Is Enabled    //div[@class="DateSelect__SelectGroup-sc-17b7zj1-0 fKBNTO"]/div[contains(.,"${type}")]
    Click Element     //div[@class="DateSelect__SelectGroup-sc-17b7zj1-0 fKBNTO"]/div[contains(.,"${type}")]
    Select From List By Value    //select[contains(.,"${type}")]    ${value}






# -------- MyGogoro Keywords --------
Confirm Change Plan Dialog
    [Documentation]    Confirm change plan
    Click Rounded Button    確認
    Wait Until Element Is Visible    //div[contains(@class,"Modal__ModalHeader-sc-13wp7c6-1")][contains(.,"認證成功")]
    Click Rounded Button    確認
    ${status} =    Run Keyword And Return Status    Wait Until Element Is Visible    //h2[contains(.,"變更成功")]    5s
    Run Keyword If    '${status}' == 'False'    Click Rounded Button    確認
    Click Alert Confirm Button
    

Choose User Birthday For One Battery
    [Documentation]    Choose user birthday at change-plan flow
    [Arguments]    ${year}    ${month}    ${date}
    Select Birthday Value    年    ${year}
    Select Birthday Value    月    ${month}
    Select Birthday Value    日    ${date}

Upload User Information For One Battery
    [Documentation]    Input user information at change-plan flow
    Input User Name For One Battery
    Input User ID For One Battery

Fill In Change Plan Information For One Battery
    [Documentation]    Fill in change plan information at change-plan flow
    Agree Legal Agreement Fo One Battery
    Upload User Information For One Battery
    Choose User Birthday For One Battery    2000    01    01



# Click 399 Plan
#     Wait until element is visible       //*[@id="app"]/div[2]/div/div[3]/div/div/div/div[1]/header/h4   
#     Click Rounded Button        選擇此方案
#     Fill In Change Plan Information For One Battery


Get Next Plan Start Date
    [Arguments]    ${es_contract_id}
    ${resp} =    Es Contracts Get    ${es_contract_id}
    log to console           ${resp.json}
    log          ${resp.text}
    ${plan_end} =    Set Variable        ${resp.json()['data'][0]['plan_end']}
    ${next_plan_start} =    Evaluate    int(${plan_end} + 86400)
    ${next_plan_start} =    Convert Date     ${next_plan_start}    result_format=%Y-%m-%d
    Set Test Variable    ${next_plan_start}

SuiteSetup
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${MYGOGORO_ACCOUNT3}    ${PASSWORD3_ENCODE}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}
    Open Browser    ${MYGOGORO_GN_DOMAIN}    ${WINDOW_HEIGHT}    ${WINDOW_WEIGHT}
    Login With Email And Password For One Bttery    ${MYGOGORO_ACCOUNT3}    ${PASSWORD3}
    # Go To    https://pa-network-my.gogoro.com/my-plan

Test Setup For New Plan
    [Arguments]    ${next_plan_name}    #${carrier_type}
    ${next_plan_code} =    Get Es Plan Code Via Es Plan Name    ${next_plan_name}       #${carrier_type}
    Set Test Variable    ${next_plan_code}
    log     ${next_plan_code}

Verify New Subscription Is Correct
    [Arguments]    ${scooter_id}    ${gogoro-sess}    ${csrf_token}    ${next_plan}
    ${resp} =    Api My Scooter ScooterId Subscription Get    ${scooter_id}    ${gogoro-sess}    ${csrf_token}
    log          ${resp.text}
    Verify Response Contains Expected    ${resp.json()['fallbackPlan']['name']}    ${next_plan}
    log     ${next_plan}
    # Verify Response Contains Expected    ${resp.json()['fallbackPlan']['sku']}    ${next_plan_code}
    # log     ${next_plan_code}


Test Teardown
     Go To    https://pa-network-my.gogoro.com/dashboard
     Sleep      5s