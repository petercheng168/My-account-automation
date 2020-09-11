*** Settings ***
Resource    variables_accessory_order.robot
Resource    variables_scooter_order.robot

*** Keywords ***
# -------- Sales Portal Elements --------
Choose Additional Accessories
    [Documentation]    Add additional accessories
    Wait Until Page Contains Element    ${XPATH_POPUP_TITLE_DIV}    ${PAGE_CONTAINS_TIMEOUT}
    JS Click Element    ${XPATH_ALREADY_BOUGHT_BUTTON}
    Wait Until Element Is Enabled    ${XPATH_CREATE_ACCESSORY_ORDER_BUTTON}    10s
    JS Click Element    ${XPATH_CREATE_ACCESSORY_ORDER_BUTTON}

Choose Buyer Information With Company Invoice
    [Documentation]    Input buyer info along with tax ID number
    Wait Until Element Is Enabled    //*[@class="ant-radio-group ant-radio-group-outline ant-radio-group_grid"]//label[2]//input
    JS Click Element    //*[@class="ant-radio-group ant-radio-group-outline ant-radio-group_grid"]//label[2]//input
    Wait Until Element Is Visible    //input[@placeholder="請輸入抬頭 (公司名稱)"]
    Input Text    //input[@placeholder="請輸入抬頭 (公司名稱)"]    已抬頭
    Wait Until Element Is Visible    //input[@placeholder="請輸入統一編號"]
    Input Text    //input[@placeholder="請輸入統一編號"]    24396848
    JS Click Element    //*[@class="popup-btnWrap"]//button[2]

Choose Buyer Information With Individual Person
    [Documentation]    Input buyer info along with scooter plate
    Wait Until Element Is Enabled    //*[@class="ant-radio-group ant-radio-group-outline ant-radio-group_grid"]//label[1]//input
    JS Click Element    //*[@class="ant-radio-group ant-radio-group-outline ant-radio-group_grid"]//label[1]//input
    Wait Until Element Is Visible    //input[@placeholder="請輸入車牌號碼"]
    Input Text    //input[@placeholder="請輸入車牌號碼"]    ${SALES_PORTAL_ACCESSORY_PLATE}
    JS Click Element    //button[@class="link_lightBlueFat btn_link"]
    Wait Until Element Is Visible    //div[@class="ProAside-item"]//h5[text()="姓名"]
    Wait Until Element Is Visible    //div[@class="ProAside-item"]//h5[text()="手機"]
    Wait Until Element Is Enabled    //*[@class="popup-btnWrap"]//button[2]
    JS Click Element    //*[@class="popup-btnWrap"]//button[2]

Choose Buyer Information With Ordinary Process
    [Documentation]    Input buyer info without any data
    Wait Until Element Is Enabled    //*[@class="ant-radio-group ant-radio-group-outline ant-radio-group_grid"]//label[3]//input
    JS Click Element    //*[@class="ant-radio-group ant-radio-group-outline ant-radio-group_grid"]//label[3]//input
    Wait Until Element Is Enabled    //*[@class="popup-btnWrap"]//button[2]
    JS Click Element    //*[@class="popup-btnWrap"]//button[2]

Check Item Page
    [Documentation]    Check result pictures on show screen
    Wait Until Element Is Visible    ${XPATH_ITEM_MAIN_IMG_DIV}
    Wait Until Element Is Visible    ${XPATH_ITEM_FIRST_SUB_IMG}
    JS Click Element    ${XPATH_ITEM_FIRST_SUB_IMG}
    Wait Until Element Is Visible    ${XPATH_ITEM_SECOND_SUB_IMG}
    JS Click Element    ${XPATH_ITEM_SECOND_SUB_IMG}
    Wait Until Element Is Visible    ${XPATH_ITEM_THIRD_SUB_IMG}
    JS Click Element    ${XPATH_ITEM_THIRD_SUB_IMG}

Choose One Product
    [Documentation]    Make an item to selected
    Click Visible Element    ${XPATH_SEARCH_RESULT_FIRST_PRODUCT_A}    6s    2s

Push Add To Cart Button
    [Documentation]    Put selected item to shopping cart
    Click Visible Element    ${XPATH_ADD_TO_SHOPPING_CART_BUTTON}    6s    2s

Select Item Quantity
    [Documentation]    Make the item number to purchase
    [Arguments]    ${quantity}
    Wait Until Element Is Visible    ${XPATH_SELECT_ITEM_NUMBER_DIV}
    JS Click Element    ${XPATH_SELECT_ITEM_NUMBER_DIV}
    Wait Until Page Contains Element    //*[@class="ant-select-dropdown-menu-item"][text()="${quantity}"]
    JS Click Element    //*[@class="ant-select-dropdown-menu-item"][text()="${quantity}"]

Wait For Searching Result
    [Documentation]    Make sure the searching result to show
    Wait Until Element Is Visible    //h2[@class="Search-title"]
    Element Should Contain    //h2[@class="Search-title"]    搜尋結果

# -------- Sales Portal Keywords --------
Add Accessory To Shopping Cart To Create An Order
    [Documentation]    Select an accessory to make an order
    [Arguments]    ${accessory}
    Input Accessory With Text    react-autosuggest__input    ${accessory}
    Wait For Searching Result
    Choose One Product
    Check Item Page
    Generate Discount Order Data
    Select Item Quantity    ${quantity}
    Push Add To Cart Button
    Choose Additional Accessories

Check Order Success Page
    [Documentation]    Make sure order success page to show
    Wait Until Element Is Visible    //*[@class="Completed-title"][contains(.,"恭喜你已經訂購成功")]    ${PAGE_CONTAINS_TIMEOUT}
    Page Should Contain Element    //*[@class="Completed-title"][text()="購物明細"]
    Page Should Contain Element    //*[@class="btn btn_lightgray"][text()="列印"]
    ${order_id} =    Get Text    ${XPATH_DMS_ORDER_NUMBER_H1}
    JS Click Element    ${XPATH_ACCESS_ORDER_DETAIL_BUTTON}
    [Return]    ${order_id}

Check Price Detail Item
    [Documentation]    Make sure total price and discount price are expected
    [Arguments]    ${total_price}    ${discount}    ${final_price}
    Wait Until Element Is Visible    ${XPATH_SHOPPING_LIST_TITLE_H2}
    Wait Until Element Is Visible    ${XPATH_EMP_DISCOUNT_SPAN}
    ${show_price} =    Get Text    ${XPATH_ITEM_PRICE_H3}
    ${result} =    Evaluate    ${show_price.replace("$","").replace(",","")}    string
    ${show_discount} =    Get Text    ${XPATH_DISCOUNT_PRICE_H3}
    ${result_discount} =    Evaluate    ${show_discount.replace("$","").replace(",","")}    string
    ${show_final} =    Get Text    ${XPATH_TOTAL_AMOUNT_H3}
    ${result_final} =    Evaluate    ${show_final.replace("$","").replace(",","")}    string
    Should Be Equal As Numbers    ${result}    ${total_price}
    Should Be Equal As Numbers    ${result_discount}    ${discount}
    Should Be Equal As Numbers    ${result_final}    ${final_price}
    Page Should Contain Element    //*[@class="ProAside-text"][contains(.,"訂單總額")]

Click Accessories Beginning Button
    [Documentation]    Redirect to buying page
    Click First Layer Item In Menu    /store
    Verify Page URL    ${SALES_PORTAL_URL}/store

Generate Discount Order Data
    [Documentation]    To make discount amount
    ${quantity} =    Generate Random String    1    12345
    ${total_price} =    Evaluate    ${quantity} * ${1190}
    ${discount} =    Evaluate    ${total_price} * ${0.2}
    ${final_price} =   Evaluate    ${total_price} - ${discount}
    Set Test Variable    ${quantity}
    Set Test Variable    ${discount}
    Set Test Variable    ${total_price}
    Set Test Variable    ${final_price}

Input Accessory With Text
    [Documentation]    Input wanted item to search bar
    [Arguments]    ${bar}    ${text}
    Wait Until Element Is Enabled    //input[@class="${bar}"]    20s
    Input Text    //input[@class="${bar}"]    ${text}
    Click Element    //button[@class="SearchBar-icon btn_link"]

Input Discount Information
    [Documentation]    Input employee data to get discount
    [Arguments]    ${employee_id}    ${email_account}
    Wait Until Element Is Visible    //*[@class="ProAside-iconLink"]
    JS Click Element    //*[@class="ProAside-iconLink"]
    Wait Until Page Contains Element    //*[@class="popup-title"][text()="員購八折"]
    Input Text    //*[@placeholder="請輸入員工編號"]    ${employee_id}
    Input Text    //*[@placeholder="請輸入員工信箱"]    ${email_account}
    JS Click Element    //*[@class="ant-btn ant-btn-primary"][contains(.,"確 認")]

# -------- Verify Keywords --------
Verify Items Should Contain
    [Documentation]    Verify item set has assign item
    [Arguments]    @{items_list}
    FOR    ${item}    IN    @{items_list}
        Page Should Contain Element    (//h4[contains(.,"${item}")])[1]
    END

Verify Scooter Model Should Contain
    [Documentation]    Verify item set has assign scooter model
    [Arguments]     ${index}    @{model_list}
    FOR    ${scooter_model}    IN    @{model_list}
        Page Should Contain Element    //html/body/div[${index}+2]/div/div[2]/div/div[2]/div/div/dl[contains(.,"${scooter_model}")]
    END
