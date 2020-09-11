*** Settings ***
Resource    variables_test_ride.robot
Resource    variables_test_ride_non_participate.robot

*** Keywords ***
# -------- Sales Portal Elements --------
Click Done Questionnaire Button
    [Documentation]    Click done questionnaire button
    Click Visible Element    ${QUESTIONNAIRE_DONE_BUTTON}

Click Next Questionnaire Button
    [Documentation]    Click next questionnaire button
    Scroll View To Element    ${QUESTIONNAIRE_NEXT_BUTTON}
    Click Visible Element    ${QUESTIONNAIRE_NEXT_BUTTON}

Click On Finish Questionnaire Button
    [Documentation]    Click finish button
    JS Click Element    //*[contains(text(),"完成")][@class="btn btn_black"]
    Wait Until Element Is Visible    //*[@class="ant-modal-confirm-body"]
    JS Click Element    //button[@class="ant-btn ant-btn-primary"]

Click Submit Button After Fill In Complete Data
    [Documentation]    Click confirm button on reservation window
    Click Visible Element    //*[@id="root"]/div[2]/main/div/div/div/div/div/form/div/div/button[2]

Focus On Section At Button
    [Documentation]    Jump out iframe and go to selected section
    Wait Until Element Is Visible    //*[@class="SignaturePad-signBtnWrap SignaturePad-signBtnWrap_shadow SignaturePad-signBtnWrap_flexEnd"]
    Set Focus To Element    //*[@class="SignaturePad-signBtnWrap SignaturePad-signBtnWrap_shadow SignaturePad-signBtnWrap_flexEnd"]

Select Age On Questionnaire
    [Documentation]    Select age on questionnaire
    [Arguments]    ${age}
    Click Visible Element    //fieldset[contains(.,"年齡")]//span[contains(.,"${age}")]

Select Customer Area From Dropdown List
    [Documentation]    Select area form dropdown list
    [Arguments]    ${area}
    Click Visible Element    //*[@id="root"]/div[2]/main/div/div/div/div/div/form/div/ul/li[4]/div/div[1]/div[2]
    Click Subitem In Dropdown List    ${area}

Select Customer City From Dropdown List
    [Documentation]    Select city form dropdown list
    [Arguments]    ${city}
    Click Visible Element    //*[@id="root"]/div[2]/main/div/div/div/div/div/form/div/ul/li[4]/div/div[1]/div[1]
    Click Subitem In Dropdown List    ${city}

Select Date To Become Scooter Owner On Questionnaire
    [Documentation]    Select date to become scooter owner on questionnaire
    [Arguments]    ${date}
    Click Visible Element    //fieldset[contains(.,"您近期是否計劃成為 Gogoro 車主？")]//span[contains(.,"${date}")]

Select Feature With Very Agree
    [Documentation]    Select feature with very agree
    [Arguments]    ${feature}
    Click Visible Element    //tr[contains(.,"${feature}")]/td[6]

Select Gender Of Customer
    [Documentation]    Select gender on radio button
    [Arguments]    ${gender}
    Wait Until Element Is Visible    //*[@id="gender"]//input[@value="${gender}"]//parent::span
    JS Click Element    //*[@id="gender"]//input[@value="${gender}"]//parent::span

Select Gender On Questionnaire
    [Documentation]    Select gender on questionnaire
    [Arguments]    ${gender}
    Click Visible Element    //fieldset[contains(.,"性別")]//span[contains(.,"${gender}")]

Select Gogoro VIVA Detail Type In Interested On Questionnaire
    [Documentation]    Select Gogoro VIVA detail type in interested on questionnaire
    [Arguments]    ${scooter_type}
    Click Visible Element    //fieldset[contains(.,"最感興趣的 Gogoro VIVA 系列")]//span[contains(.,"${scooter_type}")]

Select Holding Scooter Type On Questionnaire
    [Documentation]    Select holding scooter type on questionnaire
    [Arguments]    ${type}
    Click Visible Element    //fieldset[contains(.,"現有車款品牌")]//span[contains(.,"${type}")]

Select Reason For Buying Scooter On Questionnaire
    [Documentation]    Select reason for buying scooter on questionnaire
    [Arguments]    ${reason}
    Click Visible Element    //fieldset[contains(.,"本次主要購車動機")]//span[contains(.,"${reason}")]

Select Scooter Type In Interested On Questionnaire
    [Documentation]    Select scooter type in interested on questionnaire
    [Arguments]    ${scooter_type}
    Click Visible Element    //fieldset[contains(.,"最感興趣的車系")]//span[contains(.,"${scooter_type}")]

Select Subsidy Type On Questionnaire
    [Documentation]    Select subsidy type on questionnaire
    [Arguments]    ${subsidy_type}
    Click Visible Element    //fieldset[contains(.,"您預計申請的補助類型")]//span[contains(.,"${subsidy_type}")]

Wait Until Questionnaire Is Visible
    [Documentation]    Select iframe of the questionnaire
    Wait Until Element Is Visible    //iframe[@title="questionnaire"]
    Select Frame    //iframe[@title="questionnaire"]

# -------- Sales Portal Keywords --------
Input Email On Questionnaire
    [Documentation]    Input email on questionnaire
    Wait Until Element Is Visible    ${QUESTIONNAIRE_ONE_DIV}
    Input Text In Element    466994838    ${SALES_PORTAL_MANAGER_ACCOUNT}

Input Phone On Questionnaire
    [Documentation]    Input phone on quesitonnaire
    Wait Until Element Is Visible    ${QUESTIONNAIRE_TWO_DIV}
    Input Text In Element    466994843    ${phone}

Select City On Questionnaire
    [Documentation]    Select city on questionnaire
    [Arguments]    ${city}
    Scroll View To Element    ${QUESTIONNAIRE_CITY_SELECT}
    Click Visible Element    ${QUESTIONNAIRE_CITY_SELECT}
    Click Visible Element    ${QUESTIONNAIRE_CITY_SELECT}/option[contains(.,"${city}")]

Select Subsidy City On Questionnaire
    [Documentation]    Select subsidy city on questionnaire
    [Arguments]    ${city}
    Click Visible Element    ${QUESTIONNAIRE_SUBSIDY_CITY_SELECT}
    Click Visible Element    ${QUESTIONNAIRE_SUBSIDY_CITY_SELECT}/option[contains(.,"${city}")]

# -------- Verify Keywords --------
Verify Back To Questionnaire Starting Page
    [Documentation]    Verify page of returning to beginning
    Page Should Contain Element   //*[@class="Contract-infoTitle mobile"][contains(.,"顧客資料")]

Verify Research Thank You Header
    [Documentation]    Verify finish of the questionnaire
    Wait Until Element Is Visible    //*[@class="research-thank-you-header"]
    Element Should Contain    //*[@class="research-thank-you-header"]    感謝您填寫調查問卷
