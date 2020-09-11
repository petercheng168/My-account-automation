*** Settings ***
Documentation    Test suite of performance to login Sales_Portal 
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Run performance of login
    [Template]    Performance Test
    FOR    ${index}    IN RANGE    ${count}
        Input Login Page Correct Content On Production    開啟網頁後白畫面,或轉圈圈    2
        Click Login Button    找不到登入按鈕    2
        Click Receive 2FA Email Button    找不到收2FA驗證信按鈕    2
        Input 2FA Verification Code    未收到驗證信
        Check Remember Checkbox Unavailable    找不到記住密碼CheckBox
        Click 2FA Confirm Button To Login On Production    驗證碼錯誤登入失敗,或超時未進入首頁    2
        Click Logout Button    登出失敗
        Log Result    總登入花費時間超過10秒
    END

*** Keywords ***
Log Result
    [Documentation]    Result with login UAT, including verify total time
    ${average_time_list} =    Average Time    ${temp_array}
    ${maximum_time_list} =    Maximum Time    ${temp_array}
    ${minimum_time_list} =    Minimum Time    ${temp_array}
    Log To Console    \n-----------------------------------------------
    Log To Console    總共登入次數 : ${count}
    Log To Console    測試項目 | 平均花費(ms) | 最大花費(ms) | 最小花費(ms)
    Log To Console    打開登入頁輸入帳密 | ${average_time_list}[0] | ${maximum_time_list}[0] | ${minimum_time_list}[0]
    Log To Console    點登入出現2FA驗證 | ${average_time_list}[1] | ${maximum_time_list}[1] | ${minimum_time_list}[1]
    Log To Console    點透過Email收驗證碼 | ${average_time_list}[2] | ${maximum_time_list}[2] | ${minimum_time_list}[2]
    Log To Console    輸入驗證碼進首頁 | ${average_time_list}[3] | ${maximum_time_list}[3] | ${minimum_time_list}[3]
    Verify Total Time    ${temp_array}

Suite Setup
    Open Browser    ${SALES_PORTAL_PROD_URL}    ${SALES_PORTAL_WINDOW_HEIGHT}    ${SALES_PORTAL_WINDOW_WEIGHT}
    ${temp_array} =    Create List
    Set Suite Variable    ${temp_array}
    Set Suite Variable    ${count}    1
