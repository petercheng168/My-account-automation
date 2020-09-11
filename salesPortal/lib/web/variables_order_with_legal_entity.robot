*** Variables ***
# ----- Keyword Element -----
${XPATH_AGREE_TAKE_PLATE_INPUT}                   //input[@type="checkbox" and @value="t"]
${XPATH_AGREE_TAKE_PLATE_SPAN}                    //span[@class="ant-checkbox ant-checkbox-checked"]//input[@value="t"]/parent::span
${XPATH_CHECK_ORDER_INFO_BUTTON}                  //button[text()="查看訂單資訊"]
${XPATH_CONFIRM_SUBSIDY_BUTTON}                   //div[text()="僅供建立門市展示車訂單"]/parent::div/parent::div//button[contains(.,"確認更換")]
${XPATH_CONTINUE_BUTTON_DIV}                      //*[@id="root"]/div[2]/main/div/div[2]/div/div/div/div/div[2]/button
${XPATH_CREARTE_SUCCCESS_PAGE_DMS_NUMBRER_DIV}    //div[@class="Completed-wrap"]/div[1]//h1
${XPATH_DMS_NUMBER_SEARTCH_BUTTON_DIV}            //div[@class="OrderTable-formRow"]/span/span
${XPATH_DMS_NUMBER_SEARTCH_DIV}                   //div[@class="OrderTable-formRow"]/span/input
${XPATH_EDIT_SCOOTER_COLOR_BUTTON}                //button[@class="Order-btn link_icon link_circleBlack"]
${XPATH_FINISH_SIGN_UP_BUTTON}                    //button[@class="btn btn_black"][text()="完成簽署"]
${XPATH_GOGORO_ICON_A}                            //a[@class="link_default topbar-logo"]
${XPATH_INVOICE_SETTINGS_H2}                      //h2[text()="帳單與發票設定"]
${XPATH_IS_LEGAL_ENTITY_SELF_PLATE_H4}            //h4[text()="是否為法人贈車，個人領牌*"]
${XPATH_LEGAL_CREATE_ORDER_INPUT}                 //*[@id="root"]/div[2]/main/div/div/div/div[2]/div/form/div[2]/div[2]/div/label/input
${XPATH_LEGAL_ENTITY_SUBSIDY_RADIO_BUTTON}        //*[@class="ScooterModal-subsidyRadio"]//span[text()="法人贈車"]
${XPATH_LEGAL_GIVEUP_SUBSIDY_UPLOAD_INPUT}        //*[@id="root"]/div[2]/main/div/div/div/div[2]/div/form/div[1]/div[2]/div/label/input
${XPATH_OWNER_ADDRESS_H2}                         //h2[text()="車主"]/..//tr[4]/td
${XPATH_OWNER_IS_LEGAL_DIV}                       //div[@id="OwnerGender"]//span[text()="法人"]
${XPATH_OWNER_NAME_H2}                            //h2[text()="車主"]/..//tr[1]/td
${XPATH_OWNER_NAME_OF_LEGAL_INPUT}                //input[@id="OwnerName"]
${XPATH_OWNER_NOT_BUYER_BUTTON_SPAN}              //div[@id="ownerSameAsUser"]/div[2]//span[@class="ant-radio-inner"]
${XPATH_OWNER_OF_LEGAL_ADDRESS_INPUT}             //input[@id="OwnerAddress"]
${XPATH_OWNER_OF_LEGAL_CITY_DISTRICT_LIST_UL}     //ul[@role="listbox"]
${XPATH_OWNER_OF_LEGAL_CITY_DIV}                  //div[@id="OwnerCity"]
${XPATH_OWNER_OF_LEGAL_DISTRICT_DIV}              //div[@id="OwnerDistrict"]
${XPATH_OWNER_OF_LEGAL_PHONE_NUMBER}              //input[@id="OwnerPhone"]
${XPATH_OWNER_PHONE_H2}                           //h2[text()="車主"]/..//tr[3]/td
${XPATH_OWNER_TAX_ID_H2}                          //h2[text()="車主"]/..//tr[6]/td
${XPATH_OWNER_TAX_ID_NUMBER_INPUT}                //input[@id="OwnerGUINumber"]
${XPATH_QUICK_MENU_PENDING_ORDER_H3}              //h3[text()="待處理訂單"]
${XPATH_REGISTRATION_INFO_NAV}                    //nav[@class="SectionTabs_container__3njj4"]/a[2]
${XPATH_SCOOTER_COLOR_COMBOBOX}                   //div[@class="ant-select-selection__rendered"][contains(.,"請選擇車色")]
${XPATH_SCOOTER_COLOR_DIV}                        //div[@class="ant-drawer-body"]
${XPATH_SHOPPING_CART_TITLE_SPAN}                 //div[@class="ShopCartItem-title"]//span
${XPATH_SKIP_LEGAL_SIGN_BUTTON}                   //button[text()="跳過簽署"]
${XPATH_TARIFF_PLAN_NAV}                          //nav[@class="SectionTabs_container__3njj4"]/a[5]
${XPATH_TITLE_H2}                                 //h2[text()="帳單與發票設定"]/../dl//dd[5]
${XPATH_UNIFORM_NUMBER_H2}                        //h2[text()="帳單與發票設定"]/../dl//dd[4]
${XPATH_WARNING_WITHOUT_ES_CONTRACT_SPAN}         //span[@class="ant-modal-confirm-title"][text()="查無合約資料"]
# ----- Verify Element -----
${XPATH_CREATE_LEGAL_ORDER_PAGE_DIV}              //div[@class="container-wrap j-scooter"]
${XPATH_PAYMENT_FEE_DIV}                          //div[@class="ShoppingList-amount ShoppingList-amount_unborder"]//span[@class="AmountList-list"][contains(.,"$400")]
${XPATH_PAYMENT_TYPE_SPAN}                        //*[@id="payType"]//span[contains(.,"現金、信用卡、匯款")]
${XPATH_REFRESH_BUTTON}                           //button[text()="重新整理"]
${XPATH_TITLE_ORDER_INFORMATION_SPAN}             //span[@class="orderCollapse-stepTitle"][text()="訂購資料"]
${XPATH_TITLE_PAYMENT_DATA_SPAN}                  //span[@class="orderCollapse-stepTitle"][text()="付款資料"]
${XPATH_TITLE_SHOPPING_LIST_SPAN}                 //span[@class="orderCollapse-stepTitle"][text()="我的購物清單"]
${XPATH_TITLE_SUBSIDY_DATA_SPAN}                  //span[@class="orderCollapse-stepTitle"][text()="補助領牌資料"]
