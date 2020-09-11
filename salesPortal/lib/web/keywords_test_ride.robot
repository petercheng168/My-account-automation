*** Settings ***
Resource    variables_common.robot
Resource    variables_test_ride.robot

*** Variables ***
${normalize_path}                 ${PROJECT_ROOT}/salesPortal/res/car.png
${upload_driver_license_xpath}    //*[@id="root"]/div[2]/main/div/div/div/div/div/form/div/ul/li[1]/span[2]/div[1]/label/input

*** Keywords ***
# -------- Sales Portal Elements --------
Click Checkbox In Quotation Page
    [Documentation]    Click checkbox in quotation page
    Click Visible Element    ${XPATH_QUOTATION_CHECKBOX_SPAN}

Click Confirm Button On Reservation Window
    [Documentation]    Click confirm button on reservation window
    Wait Until Element Is Visible    ${XPATH_READY_TO_START_BUTTON}
    Wait Until Element Is Enabled    ${XPATH_READY_TO_START_BUTTON}
    JS Click Element    ${XPATH_READY_TO_START_BUTTON}
    Wait Until Element Is Not Visible    ${XPATH_READY_TO_START_BUTTON}

Click Confirm Sending Email Button On Popup Window
    [Documentation]    Click confirm sending email button on popup window
    Wait Until Page Contains    已經發送至信箱    ${PAGE_CONTAINS_TIMEOUT}
    Click Visible Element    ${XPATH_CONFIRM_SPAN_BUTTON}

Click Confirm Sign Button After Image Loaded
    [Documentation]    Click sign button after route image loaded
    Wait Until Element Is Visible    ${XPATH_ROUTE_IMG}
    Wait Until Element Is Enabled    ${XPATH_AGREE_TEST_RIDE_BUTTON}
    Maximize Browser Window
    JS Click Element    ${XPATH_AGREE_TEST_RIDE_BUTTON}
    Set Window Size    ${SALES_PORTAL_WINDOW_HEIGHT}    ${SALES_PORTAL_WINDOW_WEIGHT}

Click Finish Button After Quotation Done
    [Documentation]    Click finish button after quotation done
    Click Visible Element    ${XPATH_FINISH_QUOTATION_BUTTON}

Click Finish Button After Test Riding Done
    [Documentation]    Click finish button after test riding done
    Click Visible Element    ${XPATH_OK_SPAN_BUTTON}

Click Fetch OCR Data Button
    [Documentation]    Click fetch ocr data button
    Click Visible Element    ${XPATH_FETCH_OCR_BUTTON}

Click Item On Calendar List
    [Documentation]    Click item on calendar list with input number
    [Arguments]    ${item_id}
    Click Visible Element    //*[@id="root"]/div[2]/main/div/div/div/div/div/div/div/div/table/tbody/tr[${item_id}]/td[1]/button

Click List Mode Button
    [Documentation]    Click list mode button to see the reservation list
    Click Visible Element    ${XPATH_LIST_MODE_BUTTON}

Click Next Step Button
    [Documentation]    Click next step button
    Click Visible Element    ${XPATH_NEXT_STEP_BUTTON}

Click Quotation Button
    [Documentation]    Click quotation button
    Click Visible Element    ${XPATH_QUOTATION_BUTTON}

Click Radio Button In Gender Zone
    [Documentation]    Click radio button with given gender , 1 = male , 2 = female
    [Arguments]    ${number}    ${gender}
    Wait Until Element Is Visible    //*[@id="gender"]/label[${number}][contains(.,"${gender}")]
    Wait Until Keyword Succeeds    1s    200ms    Click Element    //*[@id="gender"]/label[${number}]/span[1]

Click Search Button In Phone Number Field
    [Documentation]    Click search button in phone number field
    Click Visible Element    ${XPATH_SEARCH_PHONE_SPAN}

Click Sign Button
    [Documentation]    Click sign button
    Click Visible Element    ${XPATH_SIGN_BUTTON}

Click Start Reservation Button
    [Documentation]    Click button to start reservation flow
    Click Visible Element    ${XPATH_START_RESERVATION_BUTTON}

Click Subitem In Dropdown List
    [Documentation]    Click subitem from dropdown list
    [Arguments]    ${input}
    Click Visible Element    //li[(text()='${input}')]    5s    2s

Click User On Calendar
    [Documentation]    Click user on calendar
    [Arguments]    ${name}
    Wait Until Element Is Visible    //h4[text()="${name}"]    10s
    JS Click Element    //h4[text()="${name}"]

Select Area From Dropdown List
    [Documentation]    Select area form dropdown list
    [Arguments]    ${area}
    Run Keyword If    '${area}' != '${EMPTY}'
    ...    Run Keywords
    ...    Click Visible Element    ${XPATH_AREA_DROPDOWN_LIST_DIV}
    ...    AND
    ...    Click Subitem In Dropdown List    ${area}

Select Checkbox For Agreement
    [Documentation]    Select checkbox to agree reservation data is correct
    JS Click Element    ${XPATH_BOOK_AGREEMENT_CHECKBOX}

Select City From Dropdown List
    [Documentation]    Select city form dropdown list
    [Arguments]    ${city}
    Run Keyword If    '${city}' != '${EMPTY}'
    ...    Run Keywords
    ...    Click Visible Element    ${XPATH_CITY_DROPDOWN_LIST_DIV}
    ...    AND
    ...    Click Subitem In Dropdown List    ${city}

Select Scooter Model From Dropdown List
    [Documentation]    Select scooter model form dropdown list
    [Arguments]    ${model}
    Run Keyword If    '${model}' != '${EMPTY}'
    ...    Run Keywords
    ...    Click Visible Element    ${XPATH_SCOOTER_MODEL_DROPDOWN_LIST_DIV}
    ...    AND
    ...    Click Subitem In Dropdown List    ${model}

Select Scooter Plate From Dropdown List
    [Documentation]    Select scooter plate form dropdown list
    [Arguments]    ${plate}
    Run Keyword If    '${plate}' != '${EMPTY}'
    ...    Run Keywords
    ...    Click Visible Element    ${XPATH_SCOOTER_PLATE_DROPDOWN_LIST_DIV}
    ...    AND
    ...    Click Subitem In Dropdown List    ${plate}

Send Quotation Result
    [Documentation]    After finishing quotation input, send result with a button
    Wait Until Element Is Visible    ${XPATH_SEND_QUOTATION_RESULT_BUTTON}    3s
    Click Element    ${XPATH_SEND_QUOTATION_RESULT_BUTTON}

Wait Until Calendar Finish Loading
    [Documentation]    Wait until calendar full loaded list information
    Wait Until Element Is Visible    ${XPATH_CALENDAR_FULL_LOADED_DIV}    5s

Click Quote Button
    [Documentation]    Click quote button
    Click Visible Element    ${XPATH_QUOTATION_SIDEBAR_DIV}/footer/button[2]    3s

# -------- Sales Portal Keywords --------
Input Test Riding Information
    [Documentation]    Keywords to decide test riding information
    [Arguments]    ${phone}    ${name}    ${email}    ${city}    ${area}    ${model}    ${plate}
    Wait Until Element Is Visible    ${XPATH_NEXT_STEP_BUTTON}    3s
    Input Text In Element    phone    ${phone}
    Input Text In Element    name    ${name}
    Input Text In Element    email    ${email}
    Select City From Dropdown List    ${city}
    Select Area From Dropdown List    ${area}
    Select Scooter Model From Dropdown List    ${model}
    Select Scooter Plate From Dropdown List    ${plate}

Select Accessory In Quotation Page
    [Documentation]    Select accessories in quotation page, default selecting "橡膠飾蓋工具包","Y型架","杯架"
    Wait Until Element Is Enabled    ${XPATH_Y_TOOL_BAG_IMG}    15s
    Scroll View To Element    ${XPATH_Y_RACK_IMG}
    Sleep    1s
    Click Visible Element    ${XPATH_Y_TOOL_BAG_IMG}
    Wait Until Page Contains Element    ${XPATH_Y_TOOL_BAG_DIV}
    Click Visible Element    ${XPATH_Y_RACK_IMG}
    Wait Until Page Contains Element    ${XPATH_Y_RACK_DIV}
    Click Visible Element     ${XPATH_CUP_SET_IMG}
    Scroll View To Element    ${XPATH_MAT_TEXT_H4}

Select City From Quotation Page List
    [Documentation]    Select city from quotation page dropdown list
    [Arguments]    ${city}
    Click Visible Element    //*[@id="directStore"]/div/div/div
    JS Click Element    //*[text()="${city}"]

Select Date And Time
    [Documentation]    Select date and time for reservation
    [Arguments]    ${time_zone}
    Click Element By Type And Id    span    book_date
    Click Visible Element    //a[@role="button" and text()="Today"]
    Click Element By Type And Id    div    book_session
    Click Subitem In Dropdown List    ${time_zone}

Select Scooter In Quotation Page
    [Documentation]    Select scooter model in quotation page, default selecting "Gogoro S2 Café Racer"
    Select Frame    ${XPATH_QUOTATION_IFRAME}
    Set Focus To Element    ${XPATH_QUOTATION_SIDEBAR_DIV}/div/div[1]/h3/i
    Click Visible Element    ${XPATH_QUOTATION_SIDEBAR_DIV}/div/div[1]/h3/i
    Scroll View To Element    ${XPATH_QUOTATION_SIDEBAR_DIV}/div/div[1]/div/div[1]/div[1]/div
    Click Visible Element    ${XPATH_QUOTATION_SIDEBAR_DIV}/div/div[1]/div/div[5]/div[1]/div
    Scroll View To Element    ${XPATH_GOGORO_3_SERIES_SPAN}
    Click Visible Element    ${XPATH_QUOTATION_SIDEBAR_DIV}/footer/button

Sign Up With A Dot
    [Documentation]    Sign up with a dot (mouse click) and send the result, sleep for waiting list produce
    Wait Until Element Is Visible    ${XPATH_TEST_RIDE_CANVAS}    3s
    Mouse Down    ${XPATH_TEST_RIDE_CANVAS}
    Click Visible Element    ${XPATH_TEST_RIDE_SIGN_SAVE_BUTTON}
    Click Visible Element    ${XPATH_TEST_RIDE_SIGN_SEND_BUTTON}

Upload Non-Driven License Image
    [Documentation]    Upload a non driven license image. It will fail at fetching OCR data, just for testing purpose.
    Choose File    ${upload_driver_license_xpath}    ${normalize_path}
    Click Button To Close Popup Window By Message    8, 辨識失敗
    Click Button To Close Popup Window By Message    此號碼尚無資料

# -------- Verify Keywords --------
Verify Error Hint Without Giving Input
    [Documentation]    Verify error hint while without input information
    [Arguments]    ${number}    ${string}
    Wait Until Element Is Visible    //*[@id="root"]/div[2]/main/div/div/div/div/div/form/div/ul/li[${number}]/div/div/div/div    3s
    Element Text Should Be    //*[@id="root"]/div[2]/main/div/div/div/div/div/form/div/ul/li[${number}]/div/div/div/div    ${string}

Verify Error Hint Without Giving email
    [Documentation]    Same as Verify Error Hint Without Giving Input, but email hint with different xpath.
    [Arguments]    ${number}    ${string}
    Wait Until Element Is Visible    //*[@id="root"]/div[2]/main/div/div/div/div/div/form/div/ul/li[${number}]/div/div/div/div/div    3s
    Element Text Should Be    //*[@id="root"]/div[2]/main/div/div/div/div/div/form/div/ul/li[${number}]/div/div/div/div/div    ${string}

Verify Error Hint Without Giving City And Area
    [Documentation]    Verify error hint while without input city and area (cannot select area before selecting city)
    [Arguments]    ${city}    ${area}
    Wait Until Element Is Visible    ${XPATH_WITHOUT_CITY_ERROR_HINT_DIV}    3s
    Element Text Should Be    ${XPATH_WITHOUT_CITY_ERROR_HINT_DIV}    ${city}
    Wait Until Element Is Visible    ${XPATH_WITHOUT_AREA_ERROR_HINT_DIV}    3s
    Element Text Should Be    ${XPATH_WITHOUT_AREA_ERROR_HINT_DIV}    ${area}

Verify User Information From Search Button
    [Documentation]    Verify user name and email is correct with exist phone number
    [Arguments]    ${input_name}    ${input_email}    ${input_city}    ${input_area}
    Sleep    1s
    ${name}=    Get Value    //*[@id='name']
    ${email}=    Get Value    //*[@id='email']
    ${city}=    Get Text    ${XPATH_CITY_DROPDOWN_LIST_DIV}
    ${area}=    Get Text    ${XPATH_AREA_DROPDOWN_LIST_DIV}
    Should Be Equal As Strings    ${name}    ${input_name}
    Should Be Equal As Strings    ${email}    ${input_email}
    Should Be Equal As Strings    ${city}    ${input_city}
    Should Be Equal As Strings    ${area}    ${input_area}
