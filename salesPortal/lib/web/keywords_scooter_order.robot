*** Settings ***
Resource    variables_common.robot
Resource    variables_scooter_order.robot

*** Keywords ***
# -------- Sales Portal Elements --------
Apply Company Project
    [Documentation]    Click button to apply company project
    [Arguments]    ${project}=2017年出廠直營展車95折
    Click Visible Element    //div[@class="Order-row" and contains(.,"${project}")]/parent::div//button[text()="APPLY"]

Apply Telecom Coupon
    [Documentation]    Click button to apply telecom coupon
    [Arguments]    ${telecom}=遠傳電信
    Click Visible Element    //div[@class="Order-row" and contains(.,"${telecom}")]/parent::div//button[text()="APPLY"]

Check Scrollbar Loading State
    [Documentation]    Check that scrollbar full loaded on the right side on scooter homepage
    Wait Until Element Is Enabled    ${XPATH_INTELLIGENT_SCOOTER_SCROLLBAR}    10s
    Wait Until Element Is Visible    ${XPATH_INTELLIGENT_SCOOTER_SCROLLBAR}    10s

Check Quotation PDF Loading State
    [Documentation]    Check that scooter order quotation pdf is full loaded
    Wait Until Element Is Visible    ${XPATH_QUOTATION_PDF_IMAGE}    5s

Click Apply Recycle Radio Button
    [Documentation]    Click apply recycle radio button
    [Arguments]    ${text}
    Run Keyword And Ignore Error    JS Click Element    //div[@class="Order-item"][contains(.,"是否委託 Gogoro 代為辦理四行程或二行程老舊機車報廢及回收相關事宜*")]//span[text()="${text}"]

Click Button To Send out Gogoro Account
    [Documentation]    Click button to send out gogoro account information as new buyer
    Click Visible Element    ${XPATH_CONFIRM_SPAN_BUTTON}

Click Checkbox For Agreement Quotation
    [Documentation]    Click checkbox for agreement in scooter order quotation page
    JS Click Element    ${XPATH_AGREE_QUOTATION_CHECKBOX}

Click Checkbox For Agreement With Taking Plate Method
    [Documentation]    Click checkbox for agreeing method of taking plate
    JS Click Element    ${XPATH_AGREE_TAKE_PLATE_CHECKBOX}
    Wait Until Page Contains    個人資料蒐集、處理及利用同意書    5s
    Wait Until Element Is Enabled    ${XPATH_CLOSE_AGREEMENT_POP_DOCUMENT}
    JS Click Element    ${XPATH_CLOSE_AGREEMENT_POP_DOCUMENT}
    Wait Until Element Is Not Visible    ${XPATH_CLOSE_AGREEMENT_POP_DOCUMENT}    5s

Click Checkbox For Car Insurance
    [Documentation]    Click checkbox for car insurance, input with true or false
    [Arguments]    ${bool}
    JS Click Element    //div[@id="isAgreeInsuranceEvent"]//input[@value="${bool}"]/parent::span

Click Checkbox For Recycle Fee
    [Documentation]    Click checkbox for agreeing recycle fee
    Wait Until Element Is Enabled    ${XPATH_RECYCLE_FEE_CHECKBOX}
    JS Click Element    ${XPATH_RECYCLE_FEE_CHECKBOX}

Click Checkbox For Scooter Order Risk
    [Documentation]    Click checkbox for realizing scooter order risk
    JS Click Element    ${XPATH_SCOOTER_RISK_CHECKBOX}

Click Checkbox For Subsidy Limitation
    [Documentation]    Click checkbox for knowning subsidy limation
    Wait Until Element Is Enabled    ${XPATH_SUBSIDY_LIMITATION_CHECKBOX}
    JS Click Element    ${XPATH_SUBSIDY_LIMITATION_CHECKBOX}

Click Checkout Button
    [Documentation]    Click button to checkout in scooter order homepage
    Scroll Element Into View    ${XPATH_CHECKOUT_BUTTON}
    Click Visible Element    ${XPATH_CHECKOUT_BUTTON}    5s    2s

Click Shopping List Continue Button
    [Documentation]    Click button to complete shopping list
    Click Visible Element    ${XPATH_SHOPPING_LIST_CONTINUE_BUTTON}    5s

Click Continue Button In Scooter Order
    [Documentation]    Click button to continue create scooter order process in scooter order page
    [Arguments]    ${stage}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    //*[@id="root"]/div[2]/main/div/div[${stage}]/div/div/div/div/div[2]/button    5s
    JS Click Element    //*[@id="root"]/div[2]/main/div/div[${stage}]/div/div/div/div/div[2]/button
    Wait Until Element Is Not Visible    //*[@id="root"]/div[2]/main/div/div[${stage}]/div/div/div/div/div[2]/button    ${PAGE_CONTAINS_TIMEOUT}

Click Hyperlink On Scooter Homepage
    [Documentation]    Click hyperlink on scooter homepage with name
    [Arguments]    ${name}
    Wait Until Keyword Succeeds    5s    500ms    Click Element    //a[@class="link_ligthGrayFat"][contains(.,"${name}")]

Click References Radio Button
    [Documentation]    Click references radio button
    JS Click Element    ${XPATH_REFERENCE_RADIO_BUTTON}

Click Restart Button
    [Documentation]    Click button to restart create scooter order process
    Run Keyword And Ignore Error    Click Visible Element    ${XPATH_RESTART_BUTTON}    3s

Click Send Quotation Email Button
    [Documentation]    Click button to send quotation email
    Click Visible Element    ${XPATH_SEND_QUOTATION_BUTTON}
    Click Visible Element    ${XPATH_CONFIRM_SPAN_BUTTON}

Click Skip Sign Button
    [Documentation]    Click button to skip sign
    Click Button With Name    跳過簽署

Click Show Quotation Button
    [Documentation]    Click button to show quotation detail
    Scroll View To Element    ${XPATH_MENU_ICON_BUTTON}
    Click Visible Element    ${XPATH_SHOW_QUOTATION_BUTTON}    retry_second=10s

Fill Telecom Coupon Discount
    [Documentation]    Fill telecom coupon discount code
    [Arguments]    ${coupon_code}
    Input Text In Element    telecomDiscountCode    ${coupon_code}

Select Installment Type
    [Documentation]    Keywords for selecting paymenet installment type if payment type is loan
    Scroll Element Into View    ${XPATH_INSTALLMENT_H5}
    Click Visible Element    ${XPATH_INSTALLMENT_TYPE_RADIO_BUTTON}    ${PAGE_CONTAINS_TIMEOUT}

Select Owner City
    [Documentation]    Keyword for selecting owner city
    [Arguments]    ${city}
    Click Visible Element    ${XPATH_OWNER_CITY_DIV}
    Click Subitem In Dropdown List    ${city}

Select Owner District
    [Documentation]    Keyword for selecting owner district
    [Arguments]    ${district}
    Click Visible Element    ${XPATH_OWNER_DISTRICT_DIV}
    Click Subitem In Dropdown List    ${district}

Select Payment Type
    [Documentation]    Keywords for select payment type
    [Arguments]    ${type}
    Wait Until Element Is Visible    //*[@id="payType"]/div[${type}]/label    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    //*[@id="payType"]/div[${type}]/label

# -------- Sales Portal Keywords --------
Add Event And Project In Shopping List
    [Documentation]    First common step of to create a scooter order - add scooter into shopping list
    [Arguments]    ${input_first_event}    ${input_second_event}
    Run Keyword And Ignore Error    Click Restart Button
    Run Keyword And Ignore Error    Select First Event    ${input_first_event}
    Run Keyword And Ignore Error    Select Second Event    ${input_second_event}
    Click Shopping List Continue Button
    Sleep    5s

Check Scooter Stock And Type
    [Documentation]    Check scooter has stocks in sales portal
    [Arguments]    ${scooter_model}    ${color}
    ${stock}    ${stock_type} =    Get Scooter Stock And Type    ${scooter_model}    ${color}
    Run Keyword If    ${stock} < 0    Click Button To Close Popup Window    span    該車款車色已售罄    2
    ...    ELSE IF    '${stock_type}' == '1'    Click Button To Close Popup Window    div    該車款車色僅能申請明年度補助
    ...    ELSE IF    '${stock_type}' == '2'    Run Keyword And Ignore Error    Click Button To Close Popup Window    div    僅供建立門市展示車訂單    2

Click Confirm Gogoro Account Button
    [Documentation]    Click button to confirm gogoro account is valid
    Click Visible Element    ${XPATH_CONFIRM_GOGORO_ACCOUNT_BUTTON}
    Wait Until Page Contains    驗證成功    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_OK_SPAN_BUTTON}
    Wait Until Page Does Not Contain    驗證成功    ${PAGE_CONTAINS_TIMEOUT}

Fill CHT Number
    [Documentation]    Fill phone number if telecom is CHT
    [Arguments]    ${phone_number}
    Run Keyword And Ignore Error    Input Text    ${XPTAH_CHT_NUMBER_INPUT}    ${phone_number}

Fill Credit Card Information
    [Documentation]    Fill credit card information for payment
    [Arguments]    ${type}
    Wait Until Element Is Visible    //*[@id="onlineCardNum"]    5s
    JS Click Element    //span[text()="${type}"]/ancestor::label//input
    Scroll Page    0    1000
    Input Text In Element    onlineCardNum    ${card.credit_card_no}
    Select Credit Card Month    ${card.credit_card_month}
    Select Credit Card Year    ${card.credit_card_year}
    Input Text In Element    onlineCardCVC    ${card.credit_card_pwd}

Fill Customer Information In Quotation Page
    [Documentation]    Given customer information for getting quotation
    [Arguments]    ${name}    ${email}    ${phone}
    Scroll View To Element    ${XPATH_CUSTOMER_NAME_ELEMENT}
    Input Text In Element    customerName    ${name}
    Input Text In Element    customerEmail    ${email}
    Input Text In Element    customerPhone    ${phone}

Fill Gogoro Account As Buyer
    [Documentation]    Given gogoro account information as buyer
    [Arguments]    ${account}    ${phone}
    Input Text In Element    userEmail    ${account}
    Input Text In Element    userPhone    ${phone}

Fill Invoice Number
    [Documentation]    Fill invoice number while selecting sales channel
    ${invoice_no} =    Generate Random String    10    [NUMBERS]
    Scroll View To Element    ${XPATH_CHANNEL_NUMBER_ELEMENT}
    Input Text In Element    ChannelNumber    ${invoice_no}

Fill Payment Type Information
    [Documentation]    Fourth common step to create a scooter order - choose payment type
    ...    1=現金、信用卡、匯款 , 2=貸款 , 3=線上刷卡
    [Arguments]    ${type}
    Select Payment Type    ${type}
    Run Keyword If    ${type} == 2    Select Installment Type
    Run Keyword If    ${type} == 3    Fill Credit Card Information    刷卡一次付清
    Click Continue Button In Scooter Order    4

Fill References Information
    [Documentation]    Fill references information
    Click References Radio Button
    Wait Until Element Is Enabled    ${XPATH_RECOMMEND_EMAIL_ELEMENT}
    Scroll View To Element    ${XPATH_RECOMMEND_EMAIL_ELEMENT}
    ${references} =    Set Variable    ${Roles('${SALES_PORTAL_TRANSFER_OLD_OWNER_ACCOUNT}')}
    Input Text In Element    RecommendEmail    ${references.email}
    Input Text In Element    RecommendLicense    ${SALES_PORTAL_TRANSFER_PLATE}
    Input Text In Element    RecommendName    ${references.name}
    Input Text In Element    RecommendPhone    ${references.full_phone}

Fill Scooter Discount Code
    [Documentation]    Fill scooter discount code
    ${discount_code} =    Generate Random String    7    [NUMBERS][LETTERS]
    Scroll View To Element    ${XPATH_SCOOTER_DISCOUNT_CODE_ELEMENT}
    Input Text In Element    scooterDiscountCode    201${discount_code}

Fill Subsidy Information For Get Scooter Plate
    [Documentation]    Third common step to create a scooter order - fill subsidy information
    [Arguments]    ${get_plate_type}
    Click Checkbox For Subsidy Limitation
    Click Checkbox For Car Insurance    true
    Click Apply Recycle Radio Button    是
    Click Checkbox For Agreement With Taking Plate Method
    Run Keyword If    "${get_plate_type}" == "2"    Take Plate By Self
    JS Click Element    ${XPATH_STEP_3_CONTINUE_BUTTON}

Generate Discount Coupon
    [Arguments]    ${coupon_name}
    [Documentation]    Generate discount coupon code
    ${resp_list} =    Get Discount List Post    offset=0    limit=91    token=${token}
    ${discount_detail} =    Evaluate    list(filter((lambda i: "${coupon_name}" == i["Name"]), ${resp_list.json()['Data']['List']}))[0]    re
    ${resp_detail} =    Import Discount Coupons Post
    ...    discount_plan_option_id={discount_detail['DiscountPlanOptionsId']}
    ...    coupon_code=${coupon_code}    token=${token}

Generate Random EVT Number
    [Documentation]    Generate random EVT number
    ${current_timestamp} =    Evaluate    int(time.time())   time
    Set Test Variable    ${coupon_code}    EVT00${current_timestamp}
    Log To Console    ${coupon_code}

Select Company Project
    [Documentation]    Select different company project, default as 2017 discount event
    [Arguments]    ${project}=2017年出廠直營展車95折
    Wait Until Element Is Enabled    ${XPATH_COMPANY_PROJECT_H3_TEXT}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_COMPANY_PROJECT_H3_TEXT}    5s
    ${attr} =    Get Element Attribute    ${XPATH_SCOOTER_DISCOUNT_ID_DIV}    aria-controls
    Wait Until Element Is Enabled    ${XPATH_SCOOTER_DISCOUNT_ID_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_SCOOTER_DISCOUNT_ID_DIV}    5s    2s
    Run Keyword And Ignore Error    Click Visible Element    //*[@id="${attr}"]/ul/li[contains(.,"${project}")]    5s

Select Company Project Flow
    [Documentation]    Flow to select company project
    [Arguments]    ${project}
    Select Company Project    ${project}
    Run Keyword If    '${project}' != '2017年出廠直營展車95折' and '${project}' != '2018年出廠直營展車97折'    Click Button To Close Popup Window    div    當期促銷及新車購車贈品無法與車價折扣併用
    Run Keyword If    '${project}' == '員工 9折' or '${project}' == '媒體公關卡 95折'    Fill Scooter Discount Code
    Apply Company Project    ${project}
    Verify Add Company Project Success    ${project}

Select Credit Card Month
    [Documentation]    Keyword for selecting credit card month
    [Arguments]    ${month}
    ${attr} =    Get Element Attribute    ${XPATH_CREDIT_CARD_MONTH_DIV}    aria-controls
    JS Click Element    ${XPATH_CREDIT_CARD_MONTH_DIV}/div/div
    Click Visible Element    //*[@id="${attr}"]/ul/li[${month}]

Select Credit Card Year
    [Documentation]    Keyword for selecting credit card year
    [Arguments]    ${year}
    Click Visible Element    ${XPATH_CREDIT_CARD_YEAR_DIV}
    Click Subitem In Dropdown List    ${year}

Select Deliver Area
    [Documentation]    Select deliver scooter area - 北 中 南
    [Arguments]    ${area}
    ${attr} =    Get Element Attribute    //*[@id="DeliverArea"]/div    aria-controls
    JS Click Element    //*[@id="DeliverArea"]/div/div/div
    Click Visible Element    //*[@id="${attr}"]/ul/li[text()="${area}"]

Select Deliver Information Flow
    [Documentation]    Flow to select deliver area, type, store
    [Arguments]    ${area}    ${type}    ${store}
    Scroll View To Element      //*[@id="DeliverArea"]/div
    Wait Until Element Is Visible    //*[@id="DeliverArea"]/div    5s
    Sleep    1s
    Select Deliver Area     ${area}
    Select Deliver Type     ${type}
    Select Deliver Store    ${store}

Select Deliver Store
    [Documentation]    According to deferent delive area and type, deicde which store to delivery scooter
    [Arguments]    ${store}
    ${attr} =    Get Element Attribute    //*[@id="DeliverStore"]/div    aria-controls
    JS Click Element    //*[@id="DeliverStore"]/div/div/div
    Click Visible Element    //*[@id="${attr}"]/ul/li[text()="${store}"]

Select Deliver Type
    [Documentation]    Select deliver scooter area - 服務中心 交車中心 Gogoro門市
    [Arguments]    ${area}
    ${attr} =    Get Element Attribute    //*[@id="DeliverType"]/div    aria-controls
    JS Click Element    //*[@id="DeliverType"]/div/div/div
    Click Visible Element    //*[@id="${attr}"]/ul/li[text()="${area}"]

Select First Event
    [Documentation]    Select first event in shopping list
    [Arguments]    ${event}
    ${attr} =    Get Element Attribute    //div[@id="EventSelect1"]/div    aria-controls
    JS Click Element    //*[@id="EventSelect1"]/div/div
    Click Visible Element    //*[@id="${attr}"]/ul/li[text()="${event}"]    5s

Select Second Event
    [Documentation]    Select second event in shopping list
    [Arguments]    ${event}
    ${attr} =    Get Element Attribute    //div[@id="EventSelect2"]/div    aria-controls
    JS Click Element    //*[@id="EventSelect2"]/div/div
    Click Visible Element    //*[@id="${attr}"]/ul/li[text()="${event}"]    5s

Select Owner Birthday Year
    [Documentation]    Keyword to select owner's birthday year in dropdown list
    [Arguments]    ${input_year}
    JS Click Element    ${XPATH_OWNER_YEAR_DIV}
    Click Subitem In Dropdown List    ${input_year}

Select Owner Birthday Month
    [Documentation]    Keyword to select owner's birthday month in dropdown list
    [Arguments]    ${input_month}
    ${attr} =    Get Element Attribute    ${XPATH_OWNER_MONTH_DIV}    aria-controls
    JS Click Element    ${XPATH_OWNER_MONTH_DIV}/div/div
    Click Visible Element    //*[@id="${attr}"]/ul/li[${input_month}]    5s

Select Owner Birthday Day
    [Documentation]    Keyword to select owner's birtday day in dropdown list
    [Arguments]    ${input_day}
    ${attr} =    Get Element Attribute    ${XPATH_OWNER_DAY_DIV}    aria-controls
    JS Click Element    ${XPATH_OWNER_DAY_DIV}/div/div
    Click Visible Element    //*[@id="${attr}"]/ul/li[${input_day}]

Select Plan And Addon
    [Documentation]    Fifth common step to create a scooter order - select plan in billing iframe
    [Arguments]    ${plan}
    Select Es-Plan    ${plan}
    Scroll Page    0    200
    Run Keyword And Ignore Error    Click Visible Element    ${XPATH_BUYER_AGREEMENT_CHECKBOX}    5s
    Click Checkbox For Recycle Fee
    Click Visible Element    //button[@type="submit"]    5s

Select Project Event
    [Documentation]    Select project event
    [Arguments]    ${event}
    Wait Until Element Is Enabled    ${XPATH_PROJECT_EVENT_H3_TEXT}    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_PROJECT_EVENT_H3_TEXT}
    Scroll Page    0    200
    Click Visible Element    ${XPATH_PROJECT_EVENT_H3_TEXT}    5s
    ${attr} =    Get Element Attribute    ${XPATH_EVENT_SELECT_DIV}    aria-controls
    Wait Until Element Is Enabled    ${XPATH_EVENT_SELECT_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_EVENT_SELECT_DIV}    5s    2s
    Click Visible Element    //*[@id="${attr}"]/ul/li[contains(.,"${event}")]    5s    2s
    Wait Until Page Contains Element    //div[@id="EventName"][contains(.,"${event}")]    5s

Select Sales Channel
    [Documentation]    Select different sales channel, default as gogoro store
    [Arguments]    ${channel}=Gogoro 門市
    Wait Until Element Is Enabled    ${XPATH_SALES_CHANNEL_H3_TEXT}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    /${XPATH_SALES_CHANNEL_H3_TEXT}    5s
    ${attr} =    Get Element Attribute    ${XPATH_CHANNEL_NAME_DIV}    aria-controls
    Wait Until Element Is Enabled    ${XPATH_CHANNEL_NAME_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_CHANNEL_NAME_DIV}    5s    2s
    Click Visible Element    //*[@id="${attr}"]/ul/li[contains(.,"${channel}")]    5s

Select Sales Channel Area
    [Documentation]    Select different sales channel area
    [Arguments]    ${area}
    Scroll Page    0    100
    Wait Until Page Contains Element    ${XPATH_CHANNEL_AREA_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Enabled    ${XPATH_CHANNEL_AREA_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_CHANNEL_AREA_DIV}    5s
    ${attr} =    Get Element Attribute    ${XPATH_CHANNEL_AREA_DIV}/div    aria-controls
    Click Visible Element    //*[@id="${attr}"]/ul/li[contains(.,"${area}")]    5s

Select Sales Channel Flow
    [Documentation]    Flow to select sales channel
    [Arguments]    ${channel}    ${area}=None    ${store}=None
    Select Sales Channel    ${channel}
    Run Keyword If    '${channel}' == '家樂福' or '${channel}' == '大潤發'
    ...    Run Keywords
    ...    Select Sales Channel Area    ${area}
    ...    AND
    ...    Select Sales Channel Store    ${store}
    ...    AND
    ...    Fill Invoice Number
    ...    AND
    ...    Select Sales Channel Invoice Date
    ...    ELSE IF    '${channel}' == '智慧雙輪推廣計畫'    Fill Invoice Number

Select Sales Channel Invoice Date
    [Documentation]
    Scroll Page    0    100
    Click Visible Element    ${XPATH_CHANNEL_INVOICE_DATE_SPAN}    5s
    Click Visible ELement    ${XPATH_CALENDAR_TODAY_BUTTON_A}    5s

Select Sales Channel Store
    [Documentation]    Select different sales channel store
    [Arguments]    ${store}
    Wait Until Element Is Enabled    ${XPATH_CHANNEL_STORE_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_CHANNEL_STORE_DIV}    5s
    ${attr} =    Get Element Attribute    ${XPATH_CHANNEL_STORE_DIV}/div    aria-controls
    Click Visible Element    //*[@id="${attr}"]/ul/li[contains(.,"${store}")]    5s

Select Scooter Type And Model And Color
    [Documentation]    Select assign scooter model and color
    [Arguments]    ${type}    ${model}    ${color_id}
    JS Click Element    ${XPATH_SCOOTER_SIDE_ACTIVE_H3_I}
    Wait Until Element Is Not Visible    ${XPATH_SCOOTER_SIDE_ACTIVE_H3_I}    5s
    Scroll View To Element    //h3[contains(.,"${type}")]/i
    Scroll Page    0    10
    JS Click Element    //h3[contains(.,"${type}")]/i
    Wait Until Element Is Visible    ${XPATH_SCOOTER_SIDE_ACTIVE_H3_I}
    JS Click Element    //button/parent::h4[text()="${model}"]/parent::div/parent::div/div[@class="ModelSelect-checkWrap"]/div/div
    Run Keyword And Ignore Error    Click Visible Element    //button/parent::h4[text()="${model}"]/parent::div/parent::div/div[@class="ModelSelect-content"]/div[@class="ModelSelect-colorWrap"]/div[${color_id}]/div

Select Telecom Company
    [Documentation]    Select different telecom company, default as FET
    [Arguments]    ${telecom}=遠傳電信
    Wait Until Element Is Enabled    ${XPATH_TELECOM_DISCOUNT_H3_TEXT}    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_TELECOM_DISCOUNT_H3_TEXT}
    Scroll Page    0    200
    Click Visible Element    ${XPATH_TELECOM_DISCOUNT_H3_TEXT}    5s
    ${attr} =    Get Element Attribute    ${XPATH_TELECOM_COMBOBOX_DIV}    aria-controls
    Wait Until Element Is Enabled    ${XPATH_TELECOM_COMBOBOX_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_TELECOM_COMBOBOX_DIV}    5s    2s
    Click Visible Element    //li[contains(.,"${telecom}")]    5s    2s

Select Telecom Coupon
    [Documentation]    Select different type of telecom coupon
    [Arguments]    ${coupon}
    ${attr} =    Get Element Attribute    ${XPATH_TELECOM_COUPON_DIV}    aria-controls
    Wait Until Element Is Enabled    ${XPATH_TELECOM_COUPON_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_TELECOM_COUPON_DIV}    5s    2s
    Click Visible Element    //li[contains(.,"${coupon}")]    5s    2s

Select Telecom Coupon Flow
    [Documentation]    Flow to select telecom coupon
    [Arguments]    ${telecom}    ${coupon}    ${coupon_code}    ${phone_number}
    Select Telecom Company    ${telecom}
    Select Telecom Coupon    ${coupon}
    Wait Until Element Is Visible    //div[@class="ant-modal-content"]/div    ${PAGE_CONTAINS_TIMEOUT}
    Run Keyword And Ignore Error    Click Button To Close Popup Window    div    當期促銷及新車購車贈品無法與電信折價卷併用
    Fill Telecom Coupon Discount    ${coupon_code}
    Fill CHT Number    ${phone_number}
    Apply Telecom Coupon    ${telecom}

Step 2 Order Information
    [Documentation]    Fill order information, case 1: buyer=owner=driver
    Click Checkbox For Scooter Order Risk
    Click Continue Button In Scooter Order    2

Step 2 Order Information With Different Driver
    [Documentation]    Fill order information, case 2: buyer=owner
    Click Checkbox For Scooter Order Risk
    JS Click Element    ${XPATH_DRIVER_SAME_AS_USER_CHECKBOX}
    Input Text In Element    DriverEmail    ${driver.email}
    Input Text In Element    DriverLastFourPhoneNo    ${driver.part_phone}
    Click Confirm Gogoro Account Button
    Click Continue Button In Scooter Order    2

Step 2 Order Information With Different Owner
    [Documentation]    Fill order information, case 3: buyer=driver
    Click Checkbox For Scooter Order Risk
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

Step 2 Order Information With Different Owner And Driver
    [Documentation]    Fill order information, case 4: all different
    Click Checkbox For Scooter Order Risk
    JS Click Element    ${XPATH_DRIVER_SAME_AS_USER_CHECKBOX}
    Input Text In Element    DriverEmail    ${driver.email}
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

Take Plate By Self
    [Documentation]    Process with take plate by self
    Click Visible Element    ${XPATH_TAKE_PLATE_SELF_SPAN_BUTTON}
    Click Visible Element    ${XPATH_TAKE_PLATE_SELF_SPAN_TEXT}

# -------- Verify Keywords --------
Verify Add Company Project Success
    [Documentation]    Verify that success to add company project
    [Arguments]    ${project}
    Wait Until Page Contains Element    //div[@class="ShopCartItem-discount" and text()="${project}"]    ${PAGE_CONTAINS_TIMEOUT}
    Page Should Contain Element    //div[@class="ShopCartItem-discount" and text()="${project}"]

Verify Add Telecom Coupon Success
    [Documentation]    Verify that success to add telecom coupon
    [Arguments]    ${coupon}
    Wait Until Page Contains Element    //div[@class="ShopCartItem-discount" and contains(.,"${coupon}")]    ${PAGE_CONTAINS_TIMEOUT}
    Page Should Contain Element    //div[@class="ShopCartItem-discount" and contains(.,"${coupon}")]

Verify Create Scooter Order Success
    [Documentation]    Verify that success to create a new scooter order
    [Arguments]    ${buyer}    ${owner}    ${driver}    ${scooter_model}    ${invoice_type}
    ${department_name} =    Get Account Information
    Wait Until Element Is Visible    ${XPATH_CREATE_SCOOTER_SUCCESS_H1}    30s
    ${message} =    Get Text         ${XPATH_CREATE_SCOOTER_SUCCESS_H1}
    ${order} =    Get Text           ${XPATH_DMS_ORDER_NUMBER_H1}
    Log To Console    ${order}
    ${department} =    Get Text      ${XPATH_DEPARTMENT_P}
    ${buyer_name} =    Get Text      ${XPATH_BUYER_NAME_P_TEXT}
    ${buyer_phone} =    Get Text     ${XPATH_BUYER_PHONE_P_TEXT}
    ${buyer_model} =    Get Text     ${XPATH_SCOOTER_MODEL_H4}
    Should Be Equal As Strings       ${message}    恭喜你已經訂購成功！
    Should Be Equal As Strings       ${department}     ${department_name}
    Should Be Equal As Strings       ${buyer_name}     ${owner.name}
    Should Be Equal As Strings       ${buyer_phone}    ${owner.full_phone}
    Should Be Equal As Strings       ${buyer_model}    ${scooter_model}
    Verify Order Payment Type        ${invoice_type}
    Verify Order Buyer Detail        ${buyer.name}     ${buyer.email}     ${buyer.full_phone}     ${buyer.full_address}
    Verify Order Owner Detail        ${owner.name}     ${driver.email}    ${owner.full_phone}     ${owner.full_address}     ${owner.birthday}    ${owner.profile_id}
    Verify Order Driver Detail       ${driver.name}    ${driver.email}    ${driver.full_phone}    ${driver.full_address}    ${driver.birthday}

Verify Create Scooter Order Success With Assign Deliver Store
    [Documentation]    Verify that success to create a new scooter order
    [Arguments]    ${buyer}    ${owner}    ${driver}    ${scooter_model}    ${invoice_type}    ${dept_name}
    Wait Until Element Is Visible    ${XPATH_CREATE_SCOOTER_SUCCESS_H1}    30s
    ${message} =    Get Text         ${XPATH_CREATE_SCOOTER_SUCCESS_H1}
    ${order} =    Get Text           ${XPATH_DMS_ORDER_NUMBER_H1}
    Log To Console    ${order}
    ${department} =    Get Text      ${XPATH_DEPARTMENT_P}
    ${buyer_name} =    Get Text      ${XPATH_BUYER_NAME_P_TEXT}
    ${buyer_phone} =    Get Text     ${XPATH_BUYER_PHONE_P_TEXT}
    ${buyer_model} =    Get Text     ${XPATH_SCOOTER_MODEL_H4}
    Should Be Equal As Strings       ${message}    恭喜你已經訂購成功！
    Should Be Equal As Strings       ${department}     ${dept_name}
    Should Be Equal As Strings       ${buyer_name}     ${owner.name}
    Should Be Equal As Strings       ${buyer_phone}    ${owner.full_phone}
    Should Be Equal As Strings       ${buyer_model}    ${scooter_model}
    Verify Order Payment Type        ${invoice_type}
    Verify Order Buyer Detail        ${buyer.name}     ${buyer.email}     ${buyer.full_phone}     ${buyer.full_address}
    Verify Order Owner Detail        ${owner.name}     ${driver.email}    ${owner.full_phone}     ${owner.full_address}     ${owner.birthday}    ${owner.profile_id}
    Verify Order Driver Detail       ${driver.name}    ${driver.email}    ${driver.full_phone}    ${driver.full_address}    ${driver.birthday}

Verify Default Subsidy City
    [Documentation]    Verify default subsidy of scooter order
    [Arguments]    ${city}
    Scroll Page    0    2000
    Wait Until Element Is Visible    ${XPATH_DEFAULT_SUBSIDY_CITY}    3s
    Element Text Should Be    ${XPATH_DEFAULT_SUBSIDY_CITY}    ${city}

Verify Order Payment Type
    [Documentation]    Verify that payment type with correct invoice type
    [Arguments]    ${invoice}
    Scroll View To Element    ${XPATH_SCOOTER_ORDER_DETAIL_BUTTON}
    Click Visible Element    ${XPATH_SCOOTER_ORDER_DETAIL_BUTTON}
    Wait Until Page Contains    ${invoice}    ${PAGE_CONTAINS_TIMEOUT}

Verify Order Buyer Detail
    [Documentation]    Verify that scooter order with correct buyer information in order detail page
    [Arguments]    ${input_name}    ${input_email}    ${input_phone}    ${input_address}
    Click Visible Element         ${XPATH_SCOOTER_DETAIL_BUTTON}
    ${name} =    Get Text         ${XPATH_BUYER_NAME_TD_TEXT}
    ${email} =    Get Text        ${XPATH_BUYER_EMAIL_TD_TEXT}
    ${phone} =    Get Text        ${XPATH_BUYER_PHONE_TD_TEXT}
    ${address} =    Get Text      ${XPATH_BUYER_ADDRESS_TD_TEXT}
    Should Be Equal As Strings    ${name}    ${input_name}
    Should Be Equal As Strings    ${email}    ${input_email}
    Should Be Equal As Strings    ${phone}    ${input_phone}
    Should Be Equal As Strings    ${address}    ${input_address}

Verify Order Driver Detail
    [Documentation]    Verify that scooter order with correct driver information in order detail page
    [Arguments]    ${input_name}    ${input_email}    ${input_phone}    ${input_address}    ${input_birthday}
    ${name} =    Get Text         ${XPATH_DRIVER_NAME_TD_TEXT}
    ${email} =    Get Text        ${XPATH_DRIVER_EMAIL_TD_TEXT}
    ${phone} =    Get Text        ${XPATH_DRIVER_PHONE_TD_TEXT}
    ${address} =    Get Text      ${XPATH_DRIVER_ADDRESS_TD_TEXT}
    ${birthday} =    Get Text     ${XPATH_DRIVER_BIRTHDAY_TD_TEXT}
    Should Be Equal As Strings    ${name}    ${input_name}
    Should Be Equal As Strings    ${email}    ${input_email}
    Should Be Equal As Strings    ${phone}    ${input_phone}
    Should Be Equal As Strings    ${address}    ${input_address}
    Should Be Equal As Strings    ${birthday}    ${input_birthday}

Verify Order Owner Detail
    [Documentation]    Verify that scooter order with correct owner information in order detail page
    [Arguments]    ${input_name}    ${input_email}    ${input_phone}    ${input_address}    ${input_birthday}    ${input_profile_id}
    ${name} =    Get Text          ${XPATH_OWNER_NAME_TD_TEXT}
    ${email} =    Get Text         ${XPATH_OWNER_EMAIL_TD_TEXT}
    ${phone} =    Get Text         ${XPATH_OWNER_PHONE_TD_TEXT}
    ${address} =    Get Text       ${XPATH_OWNER_ADDRESS_TD_TEXT}
    ${birthday} =    Get Text      ${XPATH_OWNER_BIRTHDAY_TD_TEXT}
    ${profile_id} =    Get Text    ${XPATH_OWNER_PROFILE_ID_TD_TEXT}
    Should Be Equal As Strings     ${name}    ${input_name}
    Should Be Equal As Strings     ${email}    ${input_email}
    Should Be Equal As Strings     ${phone}    ${input_phone}
    Should Be Equal As Strings     ${address}    ${input_address}
    Should Be Equal As Strings     ${birthday}    ${input_birthday}
    Should Be Equal As Strings     ${profile_id}    ${input_profile_id}

Verify Telecom Coupon And Discount Price
    [Documentation]    Verify that telecom coupon and discount price is correct
    [Arguments]    ${coupon}    ${input_discount_price}
    Verify Add Telecom Coupon Success    ${coupon}
    ${discount_price} =    Get Text    //div[@class="AmountList-listWrap"]/span[6]
    Should Be Equal As Strings    ${discount_price}    ${input_discount_price}

Verify Telecom Coupon With Error Input
    [Arguments]    ${error_text_locator}    ${error_message}
    [Documentation]    Verify error input that error message is expected
    Wait Until Element Is Visible    ${error_text_locator}    5s
    ${error_text} =    Get Text    ${error_text_locator}
    Should Be Equal As Strings    ${error_text}    ${error_message}
