*** Settings ***
Resource    variables_scooter_order.robot
Resource    variables_order.robot

*** Variables ***
${normalize_path}    ${PROJECT_ROOT}/salesPortal/res/car.png

*** Keywords ***
# -------- Sales Portal Elements --------
Check Title Exist
    [Documentation]    Check title exist in delivery process
    [Arguments]    ${name}
    Wait Until Page Contains Element    //h2[text()="${name}"]|//h3[text()="${name}"]    10s

Click Apply To Take Plate Button
    [Documentation]    Click button to apply to get plate
    Wait Until Page Contains    申請領牌    20s
    Click Visible Element    ${XPATH_ORDER_APPLY_TO_TAKE_PLATE_BUTTON}

Click Button With Assign Order Number
    [Documentation]    Click button to deal with assign order
    [Arguments]    ${order}
    Click Visible Element    //a[contains(@href,"${order}")]|//a[contains(@href,"predeliver/${order}")]

Click Checkbox In Waiting Delivery Scooter Date Page
    [Documentation]    Click checkbox in waiting delivery scooter date page
    [Arguments]    ${input_type}
    Run Keyword And Ignore Error    JS Click Element    //li[@class="Attach-opItemDiv"][contains(.,"${input_type} ")]/div/label/span/span|//li[@class="Attach-opItemDiv"][contains(.,"${input_type}")]/div/label/span/span

Click Confirm Apply To Take Plate Button
    [Documentation]    Click button to confirm apply to get plate
    Wait Until Page Contains    已送申請領牌    20s
    Click Button To Close Popup Window    span    已送申請領牌

Click Confirm Delivery Date Button
    [Documentation]    Click button to confirm delivery date
    Click Visible Element    ${XPATH_CONFIRM_DELIVERY_DATE_BUTTON}

Click Label Input
    [Documentation]    Click input by label
    [Arguments]    ${label}
    Click Visible Element    //label[text()="${label}"]/input    5s

Click Legend Input
    [Documentation]    Click input by legend
    [Arguments]    ${legend}
    Click Visible Element    //legend[text()="${legend}"]/parent::fieldset//label[text()="是"]/input    5s

Click OK Button In Go Support
    [Documentation]    Click OK button in Go Support platform
    Wait Until Page Contains Element    ${XPATH_GO_SUPPORT_OK_BUTTON}    5s
    Sleep    1s
    Click Button With Name    OK

Click Order State Button
    [Documentation]    Given id and input name to decide which order state list to show on screen
    [Arguments]    ${id}    ${input}
    Wait Until Element Is Enabled    //*[@id="root"]/div[2]/main/div/div/div[3]/div[1]/button[${id}][contains(.,"${input}")]    10s
    ${value} =    Run Keyword And Ignore Error    Wait Until Page Contains Element    //button[text()="查看"]    10s
    Run Keyword If    'FAIL' in ${value}    Wait Until Page Contains    暫無訂單資訊    10s
    JS Click Element    //*[@id="root"]/div[2]/main/div/div/div[3]/div[1]/button[${id}][contains(.,"${input}")]

Click Reservation Success Button
    [Documentation]    Click button to confrim reservation success
    Wait Until Page Contains    預約成功    10s
    Click Button To Close Popup Window    span    預約成功

Click Save Pre-Delivery Information Button
    [Documentation]    Click button to save pre-delivery information and go to next step
    Sleep    1s
    Scroll Element Into View    //button[text()="儲存並繼續交車當天作業"]
    Click Visible Element    //button[text()="儲存並繼續交車當天作業"]    10s
    Wait Until Page Contains    儲存成功    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    ${XPATH_OK_SPAN_TEXT}

Click Select All Button
    [Documentation]    Click select all button with given div h2 name
    [Arguments]    ${name}
    Run Keyword And Ignore Error    JS Click Element    //div[contains(h2,"${name}")]//button[text()=" 全選 "]

Click Send Review Button
    [Documentation]    Click button to send delivery scooter date result for reviewing
    Sleep    1s
    JS Click Element    //button[text()="送出審核"]
    Wait Until Page Contains    已送申請領牌    20s
    Click Visible Element    //button[contains(span,"確 定")]

Click Take Plate Flow Confirmation Button
    [Documentation]    Click button to start take plate flow confirmation
    Click Visible Element    //a[text()="領牌驗證流程"]

Select Checkbox In Delivery Page
    [Documentation]    Select checkbox with given name in delivery page
    [Arguments]    ${name}
    JS Click Element    //span[@class="ant-checkbox"]/parent::label[contains(.,"${name}")]//input[@type="checkbox"]

# -------- Sales Portal Keywords --------
Check Plate Exist
    [Documentation]    Check plate information already sync from Go Support
    [Arguments]    ${plate}
    ${result} =    Run Keyword And Ignore Error    Wait Until Page Contains    ${plate}    10s
    Run Keyword If    'FAIL' in ${result}    Reload Page If Plate Not Exist

Click All Checkbox In Waiting Delivery Scooter Date Page
    [Documentation]    Check all the checkbox needed in waiting delivery scooter date page
    Click Checkbox In Waiting Delivery Scooter Date Page    顧客自行用印
    Click Checkbox In Waiting Delivery Scooter Date Page    系統訂單流程作業
    Click Checkbox In Waiting Delivery Scooter Date Page    提貨單(蓋上門市發票章)
    Click Checkbox In Waiting Delivery Scooter Date Page    完整發票
    Click Checkbox In Waiting Delivery Scooter Date Page    TES正本發票
    Click Checkbox In Waiting Delivery Scooter Date Page    地方一階申請

Complete Purchase Intention Flow
    [Documentation]     Complete question in purchase intention dock page
    Scroll Page    0    0
    Click Visible Element    //button[text()="填寫"]
    Click Legend Input    是否曾經騎過 Gogoro?(門市試乘或試騎過親朋好友的車子皆可)
    Click Label Input    現場成交
    Click Label Input    普通重型(125c.c.)機車駕照
    Click Label Input    都沒有
    Click Visible Element    //button[text()="送出"]

Confirm Delivery Scooter Checklist
    [Documentation]    Confirm delivery scooter checklist with given licensing_type
    [Arguments]    ${licensing_type}=gogoro
    Check Title Exist    交車當日作業
    Click Select All Button    隨車項目
    Click Select All Button    確認顧客繳回文件
    Click Select All Button    車輛點檢
    Click Select All Button    符合活動
    Click Select All Button    牌照資料
    Click Select All Button    相關事項說明
    Click Button With Name    儲存
    Click Button To Close Popup Window    span    儲存成功
    Click Button With Name    簽署交車檢查表

Confirm Pre-Delivery Scooter Checklist
    [Documentation]    Confirm checklist before delivery scooter
    [Arguments]    ${licensing_type}=gogoro
    Check Title Exist    交車前準備
    Run Keyword If    '${licensing_type}' == 'gogoro'
    ...   Check Plate Exist    ${scooter.plate}
    Select Checkbox In Delivery Page    PDI完成
    Select Checkbox In Delivery Page    車輛到店
    Run Keyword If    '${licensing_type}' == 'self'    Upload Document In Pre-Delivery Scooter Page    完稅證明
    Run Keyword If    '${licensing_type}' == 'self'    Upload Document In Pre-Delivery Scooter Page    (監理所用完印)新領牌照登記書
    Run Keyword If    '${licensing_type}' == 'self'    Upload License Information
    Run Keyword If    '${licensing_type}' == 'self'    Select Checkbox In Delivery Page    TES補助申請發票正本
    Click Save Pre-Delivery Information Button

Confirm Scooter License Data
    [Documentation]    Confirm scooter license data
    [Arguments]    ${licensing_type}=gogoro
    Run Keyword If    '${licensing_type}' == 'gogoro'    Fill Scooter License Data
    ...   ELSE IF    '${licensing_type}' == 'self'    Fill Scooter License Data By Self

Confirm Sending Take Plate Request
    [Documentation]    Confirm sending take plate request
    Click Button With Assign Order Number    ${dms_order_no}
    Click Apply To Take Plate Button
    Click Confirm Apply To Take Plate Button

Fill Scooter License Data
    [Documentation]    Fill scooter license data, need to sleep 10 seconds for DP sync
    Wait Until Element Is Visible    //tr[@attachtypeid="31"]//img    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Keyword Succeeds    10s    200ms    Click Image    //tr[@attachtypeid="31"]//img
    Input Text In Element    txtLicenseNo    ${scooter.plate}
    ${cur_date} =    Get Current Date    result_format=%Y/%m/%d
    ${temp} =    Add Time To Date    ${cur_date}    3 days    result_format=%Y/%m/%d
    ${delivery_plate_date} =    Get Substring    ${temp}    0    10
    Click Visible Element    //*[@id="txtLicenseDate-img"]/span
    Input Text In Element    txtLicenseDate    ${delivery_plate_date}
    Click Visible Element    //*[@id="btnSaveLicenseInfo"]
    Input Text In Element    txtTempLicensingDate    ${delivery_plate_date}
    Click Visible Element    //button[contains(.,"儲存")]
    Click OK Button In Go Support

Fill Scooter License Data By Self
    [Documentation]    Fill scooter license data by self
    Input Text    //input[@placeholder="請輸入牌照號碼"]    ${scooter.plate}
    ${cur_date} =    Get Current Date    result_format=%Y-%m-%d
    ${temp} =    Add Time To Date    ${cur_date}    3 days    result_format=%Y-%m-%d
    ${delivery_plate_date} =    Get Substring    ${temp}    0    10
    Wait Until Element Is Visible    //input[@placeholder="請選擇領牌日期"]    10s
    Wait Until Keyword Succeeds    10s    200ms    Click Element    //input[@placeholder="請選擇領牌日期"]
    Input Text    //input[@placeholder="請選擇領牌日期" and @class="ant-calendar-input "]    ${delivery_plate_date}
    Press Keys    //input[@placeholder="請選擇領牌日期" and @class="ant-calendar-input "]    ENTER

Flow To Confirm Upload Result
    [Documentation]    Confirm upload success
    Click Confirm Upload Button
    Wait Until Page Contains    上傳成功    10s
    JS Click Element    ${XPATH_OK_SPAN_TEXT}

Get Delivery Date
    [Documentation]    Get delivery date, default setting add 8 days
    ${current_date} =    Get Current Date    result_format=%Y-%m-%d
    ${devliery_date_time} =    Add Time To Date    ${current_date}    10 days    date_format=%Y-%m-%d
    ${devliery_date} =    Get Substring    ${devliery_date_time}    0    10
    [Return]    ${devliery_date}

Input Delivery Date
    [Documentation]    Input delivery date
    [Arguments]    ${date}
    Click Visible Element    ${XPATH_BOOKING_DATE_SPAN}    10s    2s
    Input Text    ${XPATH_CALENDAR_DATE_INPUT}    ${date}
    Press Keys    ${XPATH_CALENDAR_DATE_INPUT}    RETURN

Input Subsidy Bank Information
    [Documentation]    Input subsidy bank information
    JS Click Element    ${XPATH_ORDER_BANK_BRANCH_CODE_LABEL}
    Input Text    ${XPATH_ORDER_BANK_BRANCH_CODE_INPUT}    8220462
    Click Subitem In Dropdown List    中國信託商業銀行斗六分行
    Input Text    ${XPATH_ORDER_BANK_USER_INPUT}    1111111111
    JS Click Element    ${XPATH_ORDER_BANK_CONFIRM_BUTTON}
    Wait Until Page Contains    更新成功    ${PAGE_CONTAINS_TIMEOUT}
    Sleep    5s
    Click Button To Close Popup Window By Message    補助人的存款帳號

Login Go Support
    [Documentation]    Log-in Go Support
    Execute Javascript    window.open('')
    Switch Window Tab    1
    Go To    ${SALES_PORTAL_GO_SUPPORT}
    Location Should Be    ${SALES_PORTAL_GO_SUPPORT}
    Input Text In Element    DealerCode    GSS
    Input Text In Element    Account    10001318T
    Input Text In Element    Password    Temp4321
    Click Visible Element    //*[@id="site__container"]/div/form/div[4]/input

Receive Order Case
    [Documentation]    Click button to receive the order we selected
    Click Visible Element    //*[@id="grdOrder"]/div[2]/div[1]/table/tbody/tr/td[1]/div
    Handle Alert
    Click OK Button In Go Support
    Click Visible Element    //*[@id="grdOrder"]/div[2]/div[1]/table/tbody/tr/td[1]/div

Reload Page If Plate Not Exist
    [Documentation]    Keyword that as fail case in <Check Plate Exist>
    Reload Page
    Check Title Exist    交車前準備
    Check Plate Exist    ${scooter.plate}

Search Order With Order Number
    [Documentation]    Given order number to get the order which is applied to take plate
    [Arguments]    ${dms_order_no}
    Click Visible Element    ${XPATH_GO_SUPPORT_SEARCH_BAR_BUTTON}
    Scroll View To Element    ${XPATH_GO_SUPPORT_ORDER_NO_INPUT}
    Input Text In Element    txtOrderNo    ${dms_order_no}
    Click Visible Element    ${XPATH_GO_SUPPORT_SEARCH_BUTTON}
    Wait Until Page Does Not Contain    0頁    ${PAGE_CONTAINS_TIMEOUT}

Search Order With Order Number In Sales Portal
    [Documentation]    Search order by dms order number
    [Arguments]    ${dms_order_no}    ${action}
    Reload Page
    Search Order    訂單編號    ${dms_order_no}
    Wait Until Element Is Visible    //button[text()="${action}"]    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    //button[text()="${action}"]
    Run Keyword And Ignore Error    JS Click Element    //button[text()="${action}"]

Select Delivery Date
    [Documentation]    Click button to select delivery date
    Click Visible Element    ${XPATH_ORDER_SELECT_DATE_BUTTON}
    JS Click Element    ${XPATH_CALENDAR_ADD_BUTTON}
    ${delivery_date} =    Get Delivery Date
    Input Delivery Date    ${delivery_date}
    Select Delivery Time From Drop List    13:00:00 - 14:00:00

Select Delivery Time From Drop List
    [Documentation]    Select assign time
    [Arguments]    ${time}
    Click Visible Element    //*[@id="bookingSolt"]/div/div/div
    Click Subitem In Dropdown List    ${time}

Sign Delivery Checklist
    [Documentation]    Sign delivery checklist
    Check Title Exist    合約簽署授權狀況
    Click Start Sign Button
    Sales And Manager Sign Up

Status From Wait Assign Scooter Date To Wait Delivery Plate
    [Documentation]    Assign scooter
    Status From Wait Assign Scooter To Wait Assign Scooter Date
    Assign Scooter From Scooters Infos    ${dms_order_no}
    Click Order State Button    7    待押交車

Status From Wait Assign Scooter To Wait Assign Scooter Date
    [Documentation]    Prepare scooter wait for assigning
    Update Order From Waiting Checkout To Waiting Assign Scooter    ${dms_order_no}
    Scooters Post    company_code=${scooter.company_code}    country_code=${scooter.country}
    ...    scooter_vin=${scooter.scooter_vin}    scooter_guid=${scooter.scooter_guid}
    ...    matnr=${scooter.matnr}    atmel_key=${scooter.atmel_key}    state=${scooter.state}
    ...    es_state=${scooter.es_state}    ecu_status=${scooter.ecu_status}
    ...    status=${scooter.keyfobs_status}    manufacture_date=${scooter.manufacture_date}
    ...    keyfobs_id=${scooter.keyfobs_id}

Sync Assign Scooter Information To DMS
    [Documentation]    Call API to create scooter and assign scooter to the scooter contract on DMS
    [Arguments]    ${dms_order_no}    ${scooter_vin}    ${scooter_model}
    ${current_date} =    Get Current Date    result_format=%Y-%m-%d
    ${order_substring1} =    Get Substring    ${dms_order_no}    1    5
    ${order_substring2} =    Get Substring    ${dms_order_no}    6    11
    ${order_no} =    Catenate    SEPARATOR=    ${order_substring1}    ${order_substring2}
    ${order_no} =    Catenate    SEPARATOR=    SWQA    ${order_no}
    ${company_department_code} =    Get Department Code
    Scooteroutbound Post    ${current_date}    ${scooter_vin}    ${order_no}    ${company_department_code}    ${SALES_PORTAL_DMS_KEY_ONE}    scooter_model=${scooter_model}
    Storeagreementsign Post    ${company_department_code}    ${dms_order_no}    ${scooter_vin}    ${SALES_PORTAL_DMS_KEY_TWO}

Update Order From Waiting Assign Scooter To Waiting Delivery Scooter Date
    [Documentation]    Update scooter order status to (A,30002)
    [Arguments]    ${dms_order_no}
    ${resp} =    Users Get Email    ${SALES_PORTAL_BUYER_EMAIL}    1
    ${user_id} =    Set Variable    ${resp.json()['data'][0]['user_id']}
    ${gogoro_guid} =    Set Variable    ${resp.json()['data'][0]['gogoro_guid']}
    Scooters Infos Update    ${dms_order_no}    ${scooter.scooter_vin}    ${user_id}    ${user_id}    ${gogoro_guid}    0

Update Order From Waiting Checkout To Waiting Assign Scooter
    [Documentation]    Update scooter order status to (I,30001)
    [Arguments]    ${dms_order_no}
    ${resp} =    Orders Get    scooter    0    10    None    ${dms_order_no}    None
    ${order_id} =    Set Variable     ${resp.json()['data'][0]['order_id']}
    ${current_time} =    Evaluate    int(time.time())   time
    Orders Update    order_id=${order_id}    order_type=VEH_SALE_CR
    ...    order_number=None    order_state=I    user_id=None
    ...    flow_status=30001    scooter_allocation_flag=2
    ...    delivery_time=${current_time}    sales_portal_flag=1
    ...    scooter_model=${scooter.matnr}    account=${CIPHER_GSS_ACCOUNT}

Upload Document
    [Documentation]    Upload file for examination
    [Arguments]    ${input}
    JS Click Element    //div[@class="Attach-opItem"][contains(.,"${input}")]/div/button[text()="上傳"]
    Choose File    ${XPATH_UPLOAD_INPUT}    ${normalize_path}
    Click Confirm Upload Button
    Click Button To Close Popup Window By Message    檔案種類：${input}

Upload Document In Pre-Delivery Scooter Page
    [Documentation]    Upload file in pre-delivery scooter page with different xpath
    [Arguments]    ${input}
    JS Click Element    //li[@class="PreDeliver-opItem"][contains(.,"${input}")]/div/button[text()="上傳"]
    Choose File    ${XPATH_UPLOAD_INPUT}    ${normalize_path}
    Click Confirm Upload Button
    Click Button To Close Popup Window By Message    檔案種類：${input}
    Sleep    5s

Upload Two Documents
    [Documentation]    Upload two file for orders
    [Arguments]    ${input_1}
    JS Click Element    //div[@class="Attach-opItem"][contains(.,"${input_1}")]/div/button[1]
    Choose File    (${XPATH_UPLOAD_INPUT})[1]    ${normalize_path}
    Choose File    (${XPATH_UPLOAD_INPUT})[2]    ${normalize_path}
    Scroll Page    0   1000
    Click Confirm Upload Button
    Click Button To Close Popup Window By Message    檔案種類：${input_1}

Upload Documents In Waiting Delivery Scooter Date Page
    [Documentation]    Upload all documents in 待押交車 page
    Upload Two Documents    車主(購買人)ID＋影本1份
    Run Keyword And Ignore Error    Upload Document    機車車輛異動登記書
    Run Keyword And Ignore Error    Upload Document    行政院環保署廢機動車輛回收管制聯單
    Run Keyword And Ignore Error    Upload Document    汰舊換新資訊查詢(低污染車輛補助網站畫面)
    Run Keyword And Ignore Error    Upload Document    完整發票電子檔
    Run Keyword And Ignore Error    Upload Document    補助人的存款帳號
    Run Keyword And Ignore Error    Upload Document    Gogoro補助資格切結書
    Run Keyword And Ignore Error    Upload Document    訂購合約
    Run Keyword And Ignore Error    Upload Document    訂購合約_電池
    Run Keyword And Ignore Error    Upload Document    二行程補助資格查詢(低污染車輛補助網站畫面)
    Run Keyword And Ignore Error    Upload Document    新購資格查詢
    Run Keyword And Ignore Error    Upload Document    中低收入證明文件
    Run Keyword And Ignore Error    Upload Document    合約版個資同意書
    Run Keyword And Ignore Error    Upload Document    地方補助
    Run Keyword And Ignore Error    Upload Document    戶籍遷徙紀錄證明(所有文件掃描檔)
    Run Keyword And Ignore Error    Upload Document    工業局聲明書
    Run Keyword And Ignore Error    Upload Document    報廢同意書

Upload License Information
    [Documentation]    Upload license information
    Upload Scooter License
    Confirm Scooter License Data    self

Upload Process In Go Support
    [Documentation]    Upload needed documents in Go Support
    Click Visible Element    //a[contains(.,"執行項目")]
    Sleep    3s
    Choose File    //*[@id="btnUpload_31"]/div/input[2]    ${normalize_path}
    Click OK Button In Go Support
    Choose File    //*[@id="btnUpload_31_2"]/div/input[2]    ${normalize_path}
    Wait Until Page Contains    OK    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Page Does Not Contain    OK    ${PAGE_CONTAINS_TIMEOUT}
    Choose File    //*[@id="btnUpload_32"]/div/input[2]    ${normalize_path}
    Wait Until Page Contains    OK    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Page Does Not Contain    OK    ${PAGE_CONTAINS_TIMEOUT}
    Choose File    //*[@id="btnUpload_33"]/div/input[2]    ${normalize_path}
    Wait Until Page Contains    OK    ${PAGE_CONTAINS_TIMEOUT}
    Wait Until Page Does Not Contain    OK    ${PAGE_CONTAINS_TIMEOUT}

Upload Scooter License
    [Documentation]    Upload scooter license by self
    Click Visible Element    ${XPATH_SCOOTER_LICENSE_UPLOAD_BUTTON}
    Choose File    (${XPATH_UPLOAD_INPUT})[1]    ${normalize_path}
    Choose File    (${XPATH_UPLOAD_INPUT})[2]    ${normalize_path}
    Wait Until Page Contains    8, 辨識失敗    10s
    JS Click Element    ${XPATH_OK_SPAN_TEXT}
    Flow To Confirm Upload Result
    Sleep    5s

# -------- Verify Keywords --------
Verify Create Scooter Order Success With Saving Order Number
    [Documentation]    Verify that success to create a new scooter order
    [Arguments]    ${input_message}    ${input_department}    ${input_buyer}    ${input_phone}    ${input_model}
    Wait Until Element Is Visible    ${XPATH_CREATE_SCOOTER_SUCCESS_H1}    30s
    ${message} =    Get Text    ${XPATH_CREATE_SCOOTER_SUCCESS_H1}
    ${order} =    Get Text      ${XPATH_DMS_ORDER_NUMBER_H1}
    Set Test Variable    ${order}
    ${department} =    Get Text    ${XPATH_DEPARTMENT_P}
    ${buyer} =    Get Text    ${XPATH_BUYER_NAME_P_TEXT}
    ${phone} =    Get Text    ${XPATH_BUYER_PHONE_P_TEXT}
    ${model} =    Get Text    ${XPATH_SCOOTER_MODEL_H4}
    Should Be Equal As Strings    ${message}    ${input_message}
    Should Be Equal As Strings    ${department}    ${input_department}
    Should Be Equal As Strings    ${buyer}    ${input_buyer}
    Should Be Equal As Strings    ${phone}    ${input_phone}
    Should Be Equal As Strings    ${model}    ${input_model}

Verify Delivery Success
    [Documentation]    Verify that delivery scooter success
    [Arguments]    ${string}
    Wait Until Element Is Visible    //span[text()="${string}"]    30s
    Element Text Should Be    //span[text()="${string}"]    ${string}
    Click Button To Close Popup Window    span    ${string}
    Log To Console    ${dms_order_no}

Verify Order In Correct State List
    [Documentation]    Verify that order transfer to correct state and show on the list
    [Arguments]    ${id}    ${input}    ${dms_order_no}
    Click Order State Button    ${id}    ${input}
    Run Keyword If    '${id}' == '10'    Search Order With Order Number In Sales Portal    ${dms_order_no}    當前作業
    ...    ELSE    Wait Until Page Contains    ${dms_order_no}    10s