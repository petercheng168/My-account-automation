*** Settings ***
Resource    variables_scooter_order.robot
Resource    variables_es_plan.robot

*** Keywords ***
# -------- Sales Portal Elements --------
Click Addon
    [Documentation]   Click addon
    Sleep    3s
    Click Visible Element    //label[@class="PlanDetail_addon__1So19"]/input    ${PAGE_CONTAINS_TIMEOUT}

Click Change Tariff Plan
    [Documentation]    Click change tariff plan button
    Click Visible Element    ${XPATH_CHANGE_TARIFF_PLAN_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}

Click Radio Button With Owner Gender
    [Documentation]    Click radio button to choose owner gender
    Run Keyword If    '${owner.gender}' == '1'    Click Visible Element    //*[@id="OwnerGender"]//label[contains(.,"男")]
    Run Keyword If    '${owner.gender}' == '2'    Click Visible Element    //*[@id="OwnerGender"]//label[contains(.,"女")]

# -------- Sales Portal Keywords --------
Change Tariff Plan
    [Documentation]    Change tariff plan without addon
    [Arguments]    ${plan}
    Select Es-Plan    ${plan}
    Click Continue Button

Change Tariff Plan With Addon
    [Documentation]    Change tariff plan with addon
    [Arguments]    ${plan}
    Select Es-Plan    ${plan}
    Click Addon
    Scroll View To Element    ${XPATH_BUYER_AGREEMENT_CHECKBOX}
    Click Visible Element    ${XPATH_BUYER_AGREEMENT_CHECKBOX}    ${PAGE_CONTAINS_TIMEOUT}
    Click Continue Button

Change To Flex Plan
    [Documentation]    Change tariff plan with free province
    Select Es-Plan    $299 自由省方案
    Wait Until Element Is Visible    ${XPATH_RECYCLE_FEE_CHECKBOX}    ${PAGE_CONTAINS_TIMEOUT}
    Click Continue Button

Reset Owner Information
    [Documentation]    Keyword to clear all input value in owner information
    Clear Element Text    //*[@id="OwnerIDCard"]
    Clear Element Text    //*[@id="OwnerName"]
    Clear Element Text    //*[@id="OwnerPhone"]
    Clear Element Text    //*[@id="OwnerAddress"]

Sign Up For Order Modify
    [Documentation]    Sign up
    [Arguments]    ${person}=1
    Change Sign Person Button    ${person}
    Click Sign Canvas
    Click Save Sign Button

Sign Up Es-Contract For Order Modify
    [Documentation]    Start all process of signup
    [Arguments]    ${emp_code}=${SALES_ACCOUNT}
    Check Transfer Order Process In Sign Up Page
    Select Manager    ${emp_code}
    Click Start Sign Button
    Sign Up Flow For Order Modify    訂購合約_電池
    Sales And Manager Sign Up

Sign Up Flow For Order Modify
    [Documentation]   Complete Sign Up Flow
    [Arguments]    ${text}
    Scroll View To Element    ${XPATH_SIGN_UP_BUTTON}
    Click Visible Element    ${XPATH_SIGN_UP_BUTTON}    10s    5s
    Sign Up For Order Modify
    ${result} =     Run Keyword And Ignore Error    Wait Until Page Contains    簽名不可為空    1s
    Run Keyword If    'PASS' in ${result}
    ...    Run Keywords
    ...    Click Visible Element    ${XPATH_OK_SPAN_BUTTON}
    ...    AND
    ...    Sign Up
    ...    ELSE    Click Next Sign Up Documentation

Step 2 Modify Order Information With Different Driver
    JS Click Element    ${XPATH_DRIVER_SAME_AS_USER_CHECKBOX}
    Input Text In Element    DriverEmail    ${SALES_PORTAL_DRIVER_EMAIL}
    Input Text In Element    DriverLastFourPhoneNo    ${driver.part_phone}
    Click Confirm Gogoro Account Button
    Click Continue Button In Scooter Order    2

Step 2 Modify Order Information With Different Owner
    [Documentation]    Flow to modify order information with different owner
    Reset Owner Information
    JS Click Element    ${XPATH_OWNER_SAME_AS_USER_CHECKBOX}
    Click Radio Button With Owner Gender
    Input Text In Element    OwnerIDCard    ${owner.profile_id}
    Input Text In Element    OwnerName    ${owner.name}
    Input Text In Element    OwnerPhone    ${owner.full_phone}
    Select Owner City    ${owner.city}
    Select Owner District    ${owner.district}
    Input Text In Element    OwnerAddress    ${owner.address}
    Select Owner Birthday Day    ${owner.birthday_day}
    Select Owner Birthday Month    ${owner.birthday_month}
    Select Owner Birthday Year    ${owner.birthday_year}
    Click Continue Button In Scooter Order    2

Step 2 Modify Order Information With Different Owner And Driver
    [Documentation]    Flow to modify order information with different owner and driver
    Reset Owner Information
    JS Click Element    ${XPATH_DRIVER_SAME_AS_USER_CHECKBOX}
    Input Text In Element    DriverEmail    ${SALES_PORTAL_DRIVER_EMAIL}
    Input Text In Element    DriverLastFourPhoneNo    ${driver.part_phone}
    Click Confirm Gogoro Account Button
    JS Click Element    ${XPATH_OWNER_SAME_AS_USER_CHECKBOX}
    Input Text In Element    OwnerIDCard    ${owner.profile_id}
    Input Text In Element    OwnerName    ${owner.name}
    Input Text In Element    OwnerPhone    ${owner.full_phone}
    Select Owner City    ${owner.city}
    Select Owner District    ${owner.district}
    Input Text In Element    OwnerAddress    ${owner.address}
    Select Owner Birthday Day    ${owner.birthday_day}
    Select Owner Birthday Month    ${owner.birthday_month}
    Select Owner Birthday Year    ${owner.birthday_year}
    Click Continue Button In Scooter Order    2

Step 5 Select Plan Without Addon
    [Documentation]    Fifth common step to create a scooter order
    [Arguments]    ${plan}=$299 自由省方案
    Sleep    10s
    Select Es-Plan    ${plan}
    Click App Confirm Button

# -------- Verify Keywords --------
Verify Change Tariff Plan
    [Documentation]    Verify change tariff plan without addon
    [Arguments]    ${input_tariff_plan}
    Wait Until Element Is Visible    ${XPATH_TARIFF_NAME}     ${PAGE_CONTAINS_TIMEOUT}
    ${tariff_name} =    Get Text    ${XPATH_TARIFF_NAME}
    Should Be Equal As Strings    ${tariff_name}    ${input_tariff_plan}

Verify Change Tariff Plan With Addon
    [Documentation]    Verify change tariff plan with addon
    [Arguments]    ${input_tariff_plan}    ${input_addon}
    Wait Until Element Is Visible    ${XPATH_TARIFF_NAME}     ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    //section[2]/dl[@class="InfoList_container__3MlL2"]/dd[1]    ${PAGE_CONTAINS_TIMEOUT}
    ${tariff_name} =    Get Text    ${XPATH_TARIFF_NAME}
    ${addon_name} =    Get Text    //section[2]/dl[@class="InfoList_container__3MlL2"]/dd[1]
    Should Be Equal As Strings    ${tariff_name}    ${input_tariff_plan}
    Should Be Equal As Strings    ${addon_name}    ${input_addon}

Verify Change To Flex Plan
    [Documentation]    Verify change to free province plan
    Wait Until Element Is Visible    ${XPATH_TARIFF_NAME}     ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    //section[2]/dl[@class="InfoList_container__3MlL2"]/dd[1]    ${PAGE_CONTAINS_TIMEOUT}
    ${tariff_name} =    Get Text    ${XPATH_TARIFF_NAME}
    ${addon_name} =    Get Text    //section[2]/dl[@class="InfoList_container__3MlL2"]/dd[1]
    Should Be Equal As Strings    ${tariff_name}    $299 自由省方案
    Should Be Equal As Strings    ${addon_name}    性能提升服務方案
