*** Settings ***
Resource    variables_common.robot
Resource    variables_scooter_order.robot
Resource    variables_order_with_legal_entity.robot

*** Variables ***
${pdf_path}    ${PROJECT_ROOT}/salesPortal/res/giveup.pdf

*** Keywords ***
-------- Sales Portal Elements --------
Check Agreement To Get Plate Is Selected
    [Documentation]    Check radio button that agreement to get plate is selected
    Wait Until Element Is Visible    ${XPATH_AGREE_TAKE_PLATE_SPAN}    ${PAGE_CONTAINS_TIMEOUT}
    Checkbox Should Be Selected    ${XPATH_AGREE_TAKE_PLATE_INPUT}

Check Radio Button Should Be Disabled
    [Documentation]    Check radio button is disabled by text input
    [Arguments]    ${input}
    Element Should Be Disabled    //*[text()="${input}"]/parent::label//span[1]//input

Click Edit Scooter Color Button
    [Documentation]    Click button to edit scooter color
    Click Visible Element    ${XPATH_EDIT_SCOOTER_COLOR_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}    10s

Click Finish Sign Up Button
    [Documentation]    Click confirm button
    Click Visible Element    ${XPATH_FINISH_SIGN_UP_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}

Click Legal Entity Radio Button
    [Documentation]    Click legal entity radio button
    Wait Until Element Is Visible    ${XPATH_IS_LEGAL_ENTITY_SELF_PLATE_H4}    ${PAGE_CONTAINS_TIMEOUT}
    Sleep    1s
    Click Visible Element    ${XPATH_LEGAL_ENTITY_SUBSIDY_RADIO_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}

Click Owner Not Buyer
    [Documentation]    Click owner not buyer
    Click Visible Element    ${XPATH_OWNER_NOT_BUYER_BUTTON_SPAN}    ${PAGE_CONTAINS_TIMEOUT}

Click Radio Button As Same As Buyer
    [Documentation]    Click button to represent that the same as buyer
    [Arguments]    ${id}
    JS Click Element    //div[@id="${id}"]//div//span[text()="同購買人"]

Click Skip Legal Sign Button
    [Documentation]    Click button to skip legal sign
    Sleep    15s
    Click Visible Element    ${XPATH_SKIP_LEGAL_SIGN_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}

Input Legal Name
    [Documentation]    Input legal name
    [Arguments]    ${legal_name}
    Wait Until Element Is Visible    ${XPATH_OWNER_NAME_OF_LEGAL_INPUT}    ${PAGE_CONTAINS_TIMEOUT}
    Input Text    ${XPATH_OWNER_NAME_OF_LEGAL_INPUT}    ${legal_name}

Input Legal Phone Number
    [Documentation]    Input legal phone num
    [Arguments]    ${phone_num}
    Wait Until Element Is Visible    ${XPATH_OWNER_OF_LEGAL_PHONE_NUMBER}    ${PAGE_CONTAINS_TIMEOUT}
    Input Text    ${XPATH_OWNER_OF_LEGAL_PHONE_NUMBER}    ${phone_num}

Input Tax ID Number
    [Documentation]    Input tax id number of legal
    [Arguments]    ${tax_id}
    Wait Until Element Is Visible    ${XPATH_OWNER_TAX_ID_NUMBER_INPUT}    ${PAGE_CONTAINS_TIMEOUT}
    Input Text    ${XPATH_OWNER_TAX_ID_NUMBER_INPUT}    ${tax_id}

Pay Documentation Fee
    [Documentation]    Decide who pay the documentation fee
    [Arguments]    ${who}
    Click Visible Element    //*[text()="${who}"]    ${PAGE_CONTAINS_TIMEOUT}

Select Owner Identity
    [Documentation]    Decide owner identity
    Click Visible Element    ${XPATH_OWNER_IS_LEGAL_DIV}    ${PAGE_CONTAINS_TIMEOUT}

-------- Sales Portal Keywords --------
Check Color After Changed
    [Documentation]    Check user selected color is shown on page
    [Arguments]    ${color}
    Wait Until Element Is Visible    ${XPATH_SHOPPING_CART_TITLE_SPAN}    ${PAGE_CONTAINS_TIMEOUT}
    ${item} =    Get Text    ${XPATH_SHOPPING_CART_TITLE_SPAN}
    Should Be Equal    ${color}    ${item}
    Click Continue Button In Scooter Order    2

Check Es-Contract Warning Popup Message
    [Documentation]    Confirm popup window
    Click Button To Close Popup Window    span    查無合約資料
    Wait Until Element Is Not Visible    ${XPATH_WARNING_WITHOUT_ES_CONTRACT_SPAN}    ${PAGE_CONTAINS_TIMEOUT}

Click Button To Start Legal Entity Order
    [Documentation]    Click start button of process
    Click Checkout Button
    Click Legal Entity Radio Button
    Click Visible Element    ${XPATH_CONFIRM_SPAN_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}

Click Confirm Subsidy Hint Button
    Click Visible Element    ${XPATH_CONFIRM_SUBSIDY_BUTTON}
    Sleep    5s

Click Continue Button To Step 3
    [Documentation]    Click button to continue create scooter order process in scooter order page
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${XPATH_CONTINUE_BUTTON_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    ${XPATH_CONTINUE_BUTTON_DIV}
    Wait Until Element Is Not Visible    ${XPATH_CONTINUE_BUTTON_DIV}    ${PAGE_CONTAINS_TIMEOUT}

Customer Changes Scooter Color
    [Documentation]    User changes default color to wanted
    [Arguments]    ${color}
    Click Edit Scooter Color Button
    Select Scooter Color    ${color}
    Click Visible Element    ${XPATH_CONFIRM_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}
    Check Color After Changed    ${color}

Customer Starts Redeem Process
    [Documentation]    Click redemption button
    [Arguments]    ${dms_order_no}
    Go To    ${SALES_PORTAL_URL}/order/manage
    Search Order With Order Number In Sales Portal    ${dms_order_no}    當前作業
    Input Winner Information
    Click Visible Element    ${XPATH_CONFIRM_SPAN_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}

Fill Legal Entity Order Buyer Information
    [Documentation]    Fill legal entity order buyer information
    Click Checkbox For Scooter Order Risk
    Click Radio Button As Same As Buyer    ownerSameAsUser
    Click Radio Button As Same As Buyer    driverSameAsUser
    Click Continue Button In Scooter Order    2

Fill Legal Entity Order Shopping List
    [Documentation]    Fill shopping list data
    Run Keyword And Ignore Error    Click Restart Button
    Click Shopping List Continue Button

Fill Legal Entity Order Subsidy Information
    [Documentation]    Fill legal entity order subsidy information
    Click Checkbox For Subsidy Limitation
    Click Checkbox For Agreement With Taking Plate Method
    Pay Documentation Fee    贈獎法人
    Page Should Contain    文件處理費：$400元
    Click Continue Button In Scooter Order    3

Fill Owner Of Legal Information
    [Documentation]    Fill out owner of legal information
    [Arguments]    ${input_tax_id}    ${input_legal_name}    ${input_phone_num}    ${input_city}    ${input_district}    ${input_address}
    Click Owner Not Buyer
    Select Owner Identity
    Input Tax ID Number    ${input_tax_id}
    Input Legal Name    ${input_legal_name}
    Input Legal Phone Number    ${input_phone_num}
    Input Legal Residence Address    ${input_city}    ${input_district}    ${input_address}
    Click Continue Button To Step 3

Get Plate And Subsidy Information
    [Documentation]    Get plate and subsidy information
    [Arguments]    ${plate_type}
    Check Agreement To Get Plate Is Selected
    Run Keyword If    '${plate_type}' == "self"    Take Plate By Self
    Check Radio Button Should Be Disabled    自行用印
    Check Radio Button Should Be Disabled    贈獎法人
    Run Keyword If    '${plate_type}' == "gogoro"    Page Should Contain    文件處理費：$400元
    Click Continue Button In Scooter Order    3

Input Legal Residence Address
    [Documentation]    Input legal residence address
    [Arguments]    ${city}    ${district}    ${address}
    Wait Until Element Is Visible    ${XPATH_OWNER_OF_LEGAL_ADDRESS_INPUT}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_OWNER_OF_LEGAL_CITY_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_OWNER_OF_LEGAL_CITY_DISTRICT_LIST_UL}/li[text()="${city}"]    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_OWNER_OF_LEGAL_DISTRICT_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_OWNER_OF_LEGAL_CITY_DISTRICT_LIST_UL}/li[text()="${district}"]    ${PAGE_CONTAINS_TIMEOUT}
    Input Text    ${XPATH_OWNER_OF_LEGAL_ADDRESS_INPUT}    ${address}

Input Winner Information
    [Documentation]    Give scooter winner account and phone number as new buyer
    Input Text In Element    winnerEmail    ${SALES_PORTAL_BUYER_EMAIL}
    Input Text In Element    winnerPhone    5076

Select Scooter Color
    [Documentation]    Select scooter color
    [Arguments]    ${color}
    Wait Until Element Contains    ${XPATH_SCOOTER_COLOR_DIV}    請選擇車色    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_SCOOTER_COLOR_COMBOBOX}    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    ${XPATH_SCOOTER_COLOR_COMBOBOX}
    Click Visible Element    //ul/li[text()="${color}"]

Sign Up Es-Contract
    [Documentation]    Start all process of signup
    [Arguments]    ${emp_code}=${SALES_ACCOUNT}
    Check Transfer Order Process In Sign Up Page
    Select Manager    ${emp_code}
    Click Start Sign Button
    Sign Up Flow    訂購合約
    Sign Up Flow    訂購合約_電池
    Sign Up Flow    Gogoro補助放棄切結書(僅放棄地方)
    Sign Up Flow    合約版個資同意書
    Sales And Manager Sign Up

Upload Legal Entity Document
    [Documentation]    Upload signup files from legal entity
    [Arguments]    ${type}    ${xpath}
    Wait Until Page Contains    ${type}    ${PAGE_CONTAINS_TIMEOUT}
    Choose File    ${xpath}    ${pdf_path}
    Wait Until Page Contains Element    //span[text()="${type}"]/ancestor::div[@class="Contract-juristicWrap"]//p[text()="已上傳檔案：giveup.pdf"]    ${PAGE_CONTAINS_TIMEOUT}

-------- Verify Keywords --------
Verify Create Scooter Order - Owner Assign To Legal
    [Documentation]    Make sure create scooter order
    [Arguments]    ${input_owner}    ${input_phone}    ${input_tax_id}    ${input_address}
    Click Visible Element    ${XPATH_CHECK_ORDER_INFO_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_REGISTRATION_INFO_NAV}    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_OWNER_NAME_H2}    ${PAGE_CONTAINS_TIMEOUT}
    ${owner} =      Get Text    ${XPATH_OWNER_NAME_H2}
    ${phone} =      Get Text    ${XPATH_OWNER_PHONE_H2}
    ${address} =    Get Text    ${XPATH_OWNER_ADDRESS_H2}
    ${tax_id} =     Get Text    ${XPATH_OWNER_TAX_ID_H2}
    Should Be Equal As Strings    ${owner}      ${input_owner}
    Should Be Equal As Strings    ${phone}      ${input_phone}
    Should Be Equal As Strings    ${tax_id}     ${input_tax_id}
    Should Be Equal As Strings    ${address}    ${input_address}
    Click Visible Element    ${XPATH_TARIFF_PLAN_NAV}    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_INVOICE_SETTINGS_H2}    ${PAGE_CONTAINS_TIMEOUT}
    ${uniform_num} =    Get Text    ${XPATH_UNIFORM_NUMBER_H2}
    ${title} =    Get Text    ${XPATH_TITLE_H2}
    Should Be Equal As Strings    ${uniform_num}    ${input_tax_id}
    Should Be Equal As Strings    ${title}    ${input_owner}

Verify Order Payment Information
    [Documentation]    Make sure input payment data is correct
    Wait Until Element Is Visible    ${XPATH_PAYMENT_TYPE_SPAN}    ${PAGE_CONTAINS_TIMEOUT}
    Page Should Contain Element    ${XPATH_PAYMENT_FEE_DIV}

Verify Order Status After Signing ES-contract
    [Documentation]    Make sure order is the right status in system
    [Arguments]    ${type}    ${stage}    ${status}
    Sleep    10s
    Wait Until Element Is Visible    ${XPATH_REFRESH_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    ${XPATH_REFRESH_BUTTON}
    Verify Order Information    訂購類別    ${type}
    Verify Order Information    訂單階段    ${stage}
    Verify Order Information    訂單狀態    ${status}

Verify Order Success Page
    [Documentation]    Make sure order has been successful
    Wait Until Page Contains    恭喜你已經訂購成功！    ${PAGE_CONTAINS_TIMEOUT}
    Page Should Contain Element    ${XPATH_CREATE_SCOOTER_SUCCESS_H1}

Verify Order With Legal Entity Begin Status
    [Documentation]    Make sure page direct to legal entity buying page
    Wait Until Element Is Visible    ${XPATH_CREATE_LEGAL_ORDER_PAGE_DIV}     ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_TITLE_SHOPPING_LIST_SPAN}        ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_TITLE_ORDER_INFORMATION_SPAN}    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_TITLE_SUBSIDY_DATA_SPAN}         ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_TITLE_PAYMENT_DATA_SPAN}         ${PAGE_CONTAINS_TIMEOUT}
    Element Should Contain    ${XPATH_TITLE_SHOPPING_LIST_SPAN}        我的購物清單
    Element Should Contain    ${XPATH_TITLE_ORDER_INFORMATION_SPAN}    訂購資料
    Element Should Contain    ${XPATH_TITLE_SUBSIDY_DATA_SPAN}         補助領牌資料
    Element Should Contain    ${XPATH_TITLE_PAYMENT_DATA_SPAN}         付款資料

Verify Payment Data With Gogoro User Pay
    [Documentation]    Make sure payment data with gogoro user is correct
    Wait Until Element Is Visible    ${XPATH_TITLE_PAYMENT_DATA_SPAN}
    Page Should Contain    中獎人注意事項
    Page Should Contain    ＊代辦費用僅限使用現金一次付清
    Page Should Contain    商品金額
    Page Should Contain    文件處理費
    Page Should Contain    $400

Verify Payment Data With Legal Entity Pay
    [Documentation]    Make sure payment data with legal entity is correct
    Wait Until Element Is Visible    ${XPATH_TITLE_PAYMENT_DATA_SPAN}
    Page Should Contain    中獎人注意事項
    Page Should Contain    ＊代辦費用僅限使用現金一次付清
    Page Should Contain    商品金額
    Page Should Contain    $0
    Page Should Not Contain    $400
