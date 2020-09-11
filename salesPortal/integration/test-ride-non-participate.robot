*** Settings ***
Documentation    Test suite of Sales_Portal Test Riding_Non_Participate Page
Resource    ../init.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Teardown    Reload Page
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Answer questionnaire
    [Tags]    CID:5195
    [Setup]    Fill Out Customer Data And Sign Up
    Input Personal Data
    Motivation For Buying Scooter
    Scooter Type Investigation
    Scooter Type Detail Investigation
    Scooter Type Feature Investigation
    Plan To Buy Scooter
    Fill Feedback Information
    Verify Research Thank You Header
    [Teardown]    Unselect Frame

Finish questionnaire and back to entering page
    [Tags]    CID:5196
    Focus On Section At Button
    Click On Finish Questionnaire Button
    Verify Back To Questionnaire Starting Page

*** Keywords ***
Fill Feedback Information
    Wait Until Element Is Visible    ${QUESTIONNAIRE_TITLE_SPAN}\[contains(.,"意見反饋")]    10s
    Click Done Questionnaire Button

Fill Out Customer Data And Sign Up
    Setup Test Data
    Input Test Riding Nonparticipate Information    ${phone}    ${name}    ${gender}    ${SALES_PORTAL_MANAGER_ACCOUNT}    新北市    板橋區
    Click Submit Button After Fill In Complete Data
    Click Sign Button
    Sign Up With A Dot
    Wait Until Questionnaire Is Visible

Input Personal Data
    Wait Until Element Is Visible    ${QUESTIONNAIRE_TITLE_SPAN}\[contains(.,"個人基本資料")]    10s
    Input Email On Questionnaire
    Input Phone On Questionnaire
    Select Gender On Questionnaire    男
    Select Age On Questionnaire    31 - 35 歲
    Select City On Questionnaire    台北市
    Click Next Questionnaire Button

Input Test Riding Nonparticipate Information
    [Arguments]    ${phone}    ${name}    ${gender}    ${email}    ${city}    ${area}
    Wait Until Element Is Visible    ${XPATH_NEXT_STEP_BUTTON}
    Input Text In Element    phone    ${phone}
    Input Text In Element    name    ${name}
    Input Text In Element    email    ${email}
    Select Gender Of Customer    ${gender}
    Select Customer City From Dropdown List    ${city}
    Select Customer Area From Dropdown List    ${area}

Motivation For Buying Scooter
    Wait Until Element Is Visible    ${QUESTIONNAIRE_TITLE_SPAN}\[contains(.,"購車動機")]    10s
    Select Holding Scooter Type On Questionnaire    Gogoro
    Select Reason For Buying Scooter On Questionnaire    購物
    Click Next Questionnaire Button

Plan To Buy Scooter
    Wait Until Element Is Visible    ${QUESTIONNAIRE_TITLE_SPAN}\[contains(.,"購車計畫")]    10s
    Select Date To Become Scooter Owner On Questionnaire    一週內
    Select Subsidy City On Questionnaire    台北市
    Select Subsidy Type On Questionnaire    新購
    Scroll View To Element    //tr[contains(.,"購車價格")]/td[6]
    Select Feature With Very Agree    購車價格
    Select Feature With Very Agree    政府補助
    Select Feature With Very Agree    電池交換站
    Select Feature With Very Agree    維修保養
    Select Feature With Very Agree    資費方案
    Select Feature With Very Agree    購車優惠
    Click Next Questionnaire Button

Scooter Type Investigation
    Wait Until Element Is Visible    ${QUESTIONNAIRE_TITLE_SPAN}\[contains(.,"車款調查")]    10s
    Select Scooter Type In Interested On Questionnaire    Gogoro VIVA
    Click Next Questionnaire Button

Scooter Type Detail Investigation
    Wait Until Element Is Visible    ${QUESTIONNAIRE_TITLE_SPAN}\[contains(.,"Gogoro VIVA 系列車款調查")]    10s
    Select Gogoro VIVA Detail Type In Interested On Questionnaire    Gogoro VIVA Plus
    Click Next Questionnaire Button

Scooter Type Feature Investigation
    Wait Until Element Is Visible    ${QUESTIONNAIRE_TITLE_SPAN}\[contains(.,"車款調查")]    10s
    Select Feature With Very Agree    產品外觀設計
    Select Feature With Very Agree    車身大小重量
    Select Feature With Very Agree    性能加速表現
    Select Feature With Very Agree    煞車安全配備
    Select Feature With Very Agree    省力貼心配備
    Select Feature With Very Agree    避震與懸吊
    Scroll View To Element            //tr[contains(.,"多重防盜系統")]/td[6]
    Select Feature With Very Agree    多重防盜系統
    Select Feature With Very Agree    iQ System® 智慧系統
    Select Feature With Very Agree    置物空間大小
    Select Feature With Very Agree    App 個性化設定
    Select Feature With Very Agree    配件多樣選擇
    Click Next Questionnaire Button

Setup Test Data
    ${name} =    Generate Random String    4    [NUMBERS]
    ${phone} =    Generate Random String    8    [NUMBERS]
    ${gender} =    Generate Random String    1    12
    Set Suite Variable    ${name}    SWQA-${name}
    Set Suite Variable    ${phone}    09${phone}
    Set Suite Variable    ${gender}    ${gender}

Suite Setup
    Login With Direct Login
    Click First Layer Item In Menu    /testride
    Click Second Layer Item In Menu    /testride/1
    Verify Page URL    ${SALES_PORTAL_URL}/testride/1
