*** Settings ***
Documentation    Test suite of Accessory Order Page
Resource    ../init.robot
Resource    ../lib/web/variables_item_sets.robot

Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Teardown    Test Teardown
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Check scooter model exist in search items
    [Tags]    CID:6670
    [Template]    Verify Scooter Model Exist In Search Items
    Gogoro 1
    Gogoro 1 Plus (MY19)
    Gogoro 2 Delight
    Gogoro 2 Delight (MY19)
    Gogoro 2 Deluxe
    Gogoro 2 Plus (MY19)
    Gogoro 2 Plus
    Gogoro 2
    Gogoro S2 Adventure Tour Edition
    Gogoro S2 Adventure
    Gogoro S2 Café Racer
    Gogoro S2 ABS
    Gogoro VIVA
    Gogoro VIVA Lite
    Gogoro S2 Café Racer (MY19)
    Gogoro S2 Café Racer ABS
    Gogoro S2 (MY19)
    Gogoro S2
    Gogoro S1
    Gogoro S1 (MY19)
    Gogoro 2 Rumbler
    Gogoro 2 Rumbler (MY19)
    Gogoro 3 Delight
    Gogoro 3
    New Gogoro 3
    New Gogoro 3 Plus
    Gogoro 3 Plus

Check items set with correct contents
    [Tags]    CID:6802
    [Template]    Verify Items Set With Correct Contents
    1     安心共乘組                                                 @{安心共乘組_item}
    2     繽紛女孩組                                                 @{繽紛女孩組_item}
    3     歡樂出遊組                                                 @{歡樂出遊組_item}
    4     都會玩家組（搭配後輪）                                       @{都會玩家組(搭配後輪)_item}
    5     都會玩家組（搭配前輪）                                       @{都會玩家組(搭配前輪)_item}
    6     裸把操控組                                                 @{裸把操控組_item}
    7     耀眼風尚組（適用 Gogoro 3 / S3 系列）                        @{耀眼風尚組（適用 Gogoro 3 / S3 系列）_item}
    8     耀眼風尚組（適用 Gogoro 2 / S2 系列）                        @{耀眼風尚組（適用 Gogoro 2 / S2 系列）_item}
    9     簡單生活組（適用 Gogoro 3 / S3 系列）                        @{簡單生活組（適用 Gogoro 3 / S3 系列）_item}
    10    競速操控組 （搭配後輪）                                      @{競速操控組(搭配後輪)_item}
    11    競速操控組 （搭配前輪）                                      @{競速操控組(搭配前輪)_item}
    12    溼地剋星組（搭配後輪）                                       @{溼地剋星組(搭配後輪)_item}
    13    溼地剋星組（搭配前輪）                                       @{溼地剋星組(搭配前輪)_item}
    14    極致工藝組（適用 Gogoro 3 / S3 系列）                        @{極致工藝組（適用 Gogoro 3 / S3 系列）_item}
    15    極致工藝組（適用 Gogoro 2 / S2 系列）                        @{極致工藝組（適用 Gogoro 2 / S2 系列）_item}
    16    征服山旅組                                                 @{征服山旅組_item}
    17    完美暢行組                                                 @{完美暢行組_item}
    18    城市奔馳組（搭配後輪）                                       @{城市奔馳組(搭配後輪)_item}
    19    城市奔馳組（搭配前輪）                                       @{城市奔馳組(搭配前輪)_item}
    20    傳動躍升組                                                 @{傳動躍升組_item}
    21    簡單生活組（適用 Gogoro 2 / S2 系列）                        @{簡單生活組（適用 Gogoro 2 / S2 系列）_item}
    22    智慧暢行組                                                 @{智慧暢行組_item}
    23    放閃出行組                                                 @{放閃出行組_item}
    24    經典配件組（搭配銀色小 Y 架款）                               @{經典配件組（搭配銀色小 Y 架款）_item}
    25    經典配件組（搭配鈦灰色小 Y 架款）                             @{經典配件組（搭配鈦灰色小 Y 架款）_item}
    26    勁裝出動組                                                 @{勁裝出動組_item}
    27    隨車電池充電器組六折優惠                                     @{隨車電池充電器組六折優惠_item}
    28    轉向輔助照地燈                                              @{轉向輔助照地燈_item}
    29    輔助煞車燈                                                 @{輔助煞車燈_item}
    30    風格行家組                                                 @{風格行家組_item}
    31    豪華裝備組                                                 @{豪華裝備組_item}
    32    舒適加乘組                                                 @{舒適加乘組_item}
    33    搶眼配件組                                                 @{搶眼配件組_item}
    34    前衛風格組                                                 @{前衛風格組_item}
    35    超犀利性能套件五件組                                         @{超犀利性能套件五件組_item}
    36    時尚騎乘組                                                 @{時尚騎乘組_item}
    37    剽悍風格組                                                 @{剽悍風格組_item}
    38    熱血旅程組                                                 @{熱血旅程組_item}
    39    精準操駕組                                                 @{精準操駕組_item}
    40    頂級操控組                                                 @{頂級操控組_item}
    41    騎士經典組                                                 @{騎士經典組_item}
    42    都會輕騎組 (鈦灰經典款) - 適用 Gogoro VIVA 系列               @{都會輕騎組 (鈦灰經典款) - 適用 Gogoro VIVA 系列_item}
    43    都會輕騎組 (銀色時尚款) - 適用 Gogoro VIVA 系列               @{都會輕騎組 (銀色時尚款) - 適用 Gogoro VIVA 系列_item}
    44    都會輕騎組 (鈦灰經典款) - 適用 Gogoro 3 系列                  @{都會輕騎組 (鈦灰經典款) - 適用 Gogoro 3 系列_item}
    45    都會輕騎組 (銀色時尚款) - 適用 Gogoro 3 系列                  @{都會輕騎組 (銀色時尚款) - 適用 Gogoro 3 系列_item}
    46    都會輕騎組 (鈦灰經典款) - 適用 Gogoro 1 / 2 / S1 / S2 系列    @{都會輕騎組 (鈦灰經典款) - 適用 Gogoro 1 / 2 / S1 / S2 系列_item}
    47    都會輕騎組 (銀色時尚款) - 適用 Gogoro 1 / 2 / S1 / S2 系列    @{都會輕騎組 (銀色時尚款) - 適用 Gogoro 1 / 2 / S1 / S2 系列_item}

Check items set with correct scooter model
    [Tags]    CID:6764
    [Template]    Verify Items Set With Correct Scooter Model
    1     安心共乘組                                                 @{安心共乘組_scooter}
    2     繽紛女孩組                                                 @{繽紛女孩組_scooter}
    3     歡樂出遊組                                                 @{歡樂出遊組_scooter}
    4     都會玩家組（搭配後輪）                                       @{都會玩家組(搭配後輪)_scooter}
    5     都會玩家組（搭配前輪）                                       @{都會玩家組(搭配前輪)_scooter}
    6     裸把操控組                                                 @{裸把操控組_scooter}
    7     耀眼風尚組（適用 Gogoro 3 / S3 系列）                        @{耀眼風尚組（適用 Gogoro 3 / S3 系列）_scooter}
    8     耀眼風尚組（適用 Gogoro 2 / S2 系列）                        @{耀眼風尚組（適用 Gogoro 2 / S2 系列）_scooter}
    9     簡單生活組（適用 Gogoro 3 / S3 系列）                        @{簡單生活組（適用 Gogoro 3 / S3 系列）_scooter}
    10    競速操控組 （搭配後輪）                                      @{競速操控組(搭配後輪)_scooter}
    11    競速操控組 （搭配前輪）                                      @{競速操控組(搭配前輪)_scooter}
    12    溼地剋星組（搭配後輪）                                       @{溼地剋星組(搭配後輪)_scooter}
    13    溼地剋星組（搭配前輪）                                       @{溼地剋星組(搭配前輪)_scooter}
    14    極致工藝組（適用 Gogoro 3 / S3 系列）                        @{極致工藝組（適用 Gogoro 3 / S3 系列）_scooter}
    15    極致工藝組（適用 Gogoro 2 / S2 系列）                        @{極致工藝組（適用 Gogoro 2 / S2 系列）_scooter}
    16    征服山旅組                                                 @{征服山旅組_scooter}
    17    完美暢行組                                                 @{完美暢行組_scooter}
    18    城市奔馳組（搭配後輪）                                       @{城市奔馳組(搭配後輪)_scooter}
    19    城市奔馳組（搭配前輪）                                       @{城市奔馳組(搭配前輪)_scooter}
    20    傳動躍升組                                                 @{傳動躍升組_scooter}
    21    簡單生活組（適用 Gogoro 2 / S2 系列）                        @{簡單生活組（適用 Gogoro 2 / S2 系列）_scooter}
    22    智慧暢行組                                                 @{智慧暢行組_scooter}
    23    放閃出行組                                                 @{放閃出行組_scooter}
    24    經典配件組（搭配銀色小 Y 架款）                               @{經典配件組（搭配銀色小 Y 架款）_scooter}
    25    經典配件組（搭配鈦灰色小 Y 架款）                             @{經典配件組（搭配鈦灰色小 Y 架款）_scooter}
    26    勁裝出動組                                                 @{勁裝出動組_scooter}
    27    隨車電池充電器組六折優惠                                     @{隨車電池充電器組六折優惠_scooter}
    28    轉向輔助照地燈                                              @{轉向輔助照地燈_scooter}
    29    輔助煞車燈                                                 @{輔助煞車燈_scooter}
    30    風格行家組                                                 @{風格行家組_scooter}
    31    豪華裝備組                                                 @{豪華裝備組_scooter}
    32    舒適加乘組                                                 @{舒適加乘組_scooter}
    33    搶眼配件組                                                 @{搶眼配件組_scooter}
    34    前衛風格組                                                 @{前衛風格組_scooter}
    35    超犀利性能套件五件組                                         @{超犀利性能套件五件組_scooter}
    36    時尚騎乘組                                                 @{時尚騎乘組_scooter}
    37    剽悍風格組                                                 @{剽悍風格組_scooter}
    38    熱血旅程組                                                 @{熱血旅程組_scooter}
    39    精準操駕組                                                 @{精準操駕組_scooter}
    40    頂級操控組                                                 @{頂級操控組_scooter}
    41    騎士經典組                                                 @{騎士經典組_scooter}
    42    都會輕騎組 (鈦灰經典款) - 適用 Gogoro VIVA 系列               @{都會輕騎組 (鈦灰經典款) - 適用 Gogoro VIVA 系列_scooter}
    43    都會輕騎組 (銀色時尚款) - 適用 Gogoro VIVA 系列               @{都會輕騎組 (銀色時尚款) - 適用 Gogoro VIVA 系列_scooter}
    44    都會輕騎組 (鈦灰經典款) - 適用 Gogoro 3 系列                  @{都會輕騎組 (鈦灰經典款) - 適用 Gogoro 3 系列_scooter}
    45    都會輕騎組 (銀色時尚款) - 適用 Gogoro 3 系列                  @{都會輕騎組 (銀色時尚款) - 適用 Gogoro 3 系列_scooter}
    46    都會輕騎組 (鈦灰經典款) - 適用 Gogoro 1 / 2 / S1 / S2 系列    @{都會輕騎組 (鈦灰經典款) - 適用 Gogoro 1 / 2 / S1 / S2 系列_scooter}
    47    都會輕騎組 (銀色時尚款) - 適用 Gogoro 1 / 2 / S1 / S2 系列    @{都會輕騎組 (銀色時尚款) - 適用 Gogoro 1 / 2 / S1 / S2 系列_scooter}

Contribute An Order With Company Invoice
    [Tags]    CID:6666
    Add Accessory To Shopping Cart To Create An Order    杯架
    Choose Buyer Information With Company Invoice
    ${order_Id} =    Check Order Success Page
    Verify Order Information    訂單編號    ${order_id}

Contribute An Order With Personal Buyer
    [Tags]    CID:6667
    Add Accessory To Shopping Cart To Create An Order    杯架
    Choose Buyer Information With Individual Person
    ${order_Id} =    Check Order Success Page
    Verify Order Information    訂單編號    ${order_id}

Contribute An Order With Ordinary Process
    [Tags]    CID:6668
    Add Accessory To Shopping Cart To Create An Order    杯架
    Choose Buyer Information With Ordinary Process
    ${order_Id} =    Check Order Success Page
    Verify Order Information    訂單編號    ${order_id}

Contribute An Order With Ordinary Process Using Discount
    [Tags]    CID:6669
    Add Accessory To Shopping Cart To Create An Order    杯架 
    Input Discount Information    ${employee_Id}    ${SALES_PORTAL_MANAGER_ACCOUNT}
    Check Price Detail Item    ${total_price}    ${discount}    ${final_price}   
    Choose Buyer Information With Ordinary Process
    ${order_Id} =    Check Order Success Page
    Verify Order Information    訂單編號    ${order_id}

*** Keywords ***
Suite Setup
    Login With Direct Login
    Click Accessories Beginning Button
    Set Suite Variable    ${employee_Id}    ${SALES_ACCOUNT}

Test Teardown
    Wait Until Element Is Enabled    ${XPATH_LOGOUT_BUTTON}    10s
    Click Logout Button
    Close Window
    Login With Direct Login
    Click Accessories Beginning Button
    Set Suite Variable    ${employee_Id}    ${SALES_ACCOUNT}

Verify Items Set With Correct Contents
    [Arguments]    ${index}    ${item_set_name}    @{items_list}
    Wait Until Element Is Visible    //h3[text()="擁有車款1"]    10s
    Wait Until Element Is Enabled    (//article[contains(.,"${item_set_name}")]/button)[1]
    JS Click Element    (//article[contains(.,"${item_set_name}")]/button)[1]
    Verify Items Should Contain    @{items_list}
    [Teardown]    JS Click Element   //html/body/div[${index}+2]/div/div[2]/div/div[2]/button

Verify Items Set With Correct Scooter Model
    [Arguments]    ${index}    ${item_set_name}    @{scooter_model}
    Wait Until Element Is Visible    //h3[text()="擁有車款1"]    10s
    Wait Until Element Is Enabled    (//article[contains(.,"${item_set_name}")]/button)[1]
    JS Click Element    (//article[contains(.,"${item_set_name}")]/button)[1]
    Verify Scooter Model Should Contain    ${index}    @{scooter_model}
    [Teardown]    JS Click Element   //html/body/div[${index}+2]/div/div[2]/div/div[2]/button

Verify Scooter Model Exist In Search Items
    [Arguments]    ${scooter_model}
    Wait Until Element Is Visible    //h3[text()="擁有車款1"]    10s
    ${attr} =    Get Element Attribute    //div[@class="OwnedScooter-selectWrap"][contains(.,"擁有車款1")]//div[@role="combobox"]    aria-controls
    Wait Until Element Is Enabled    //div[@aria-controls="${attr}"]/div
    JS Click Element    //div[@aria-controls="${attr}"]/div
    Page Should Contain Element    //ul/li[text()="${scooter_model}"]
