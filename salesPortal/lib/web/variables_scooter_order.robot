*** Variables ***
# ----- Keyword Element -----
${XPATH_AGREE_QUOTATION_CHECKBOX}          //*[@id="shoplistContent"]/div[1]/div/div/section/div[4]/div/div/div[4]/div/div/span/label/span[1]/span
${XPATH_AGREE_TAKE_PLATE_CHECKBOX}         //*[@id="isAgreeLiability"]/label[1]/span[1]/span
${XPATH_BUYER_AGREEMENT_CHECKBOX}          //input[@name="agreement"]
${XPATH_CALENDAR_TODAY_BUTTON_A}           //a[@class="ant-calendar-today-btn "]
${XPATH_CHANGE_TARIFF_PLAN_BUTTON}         //button[text()="變更資費方案"]
${XPATH_CHANNEL_AREA_DIV}                  //div[@id="ChannelArea"]
${XPATH_CHANNEL_INVOICE_DATE_SPAN}         //span[@id="ChannelInvoiceDate"]
${XPATH_CHANNEL_NAME_DIV}                  //div[@id="ChannelName"]/div
${XPATH_CHANNEL_NUMBER_ELEMENT}            //*[@id="ChannelNumber"]
${XPATH_CHANNEL_STORE_DIV}                 //div[@id="ChannelStore"]
${XPATH_CHECKOUT_BUTTON}                   //div[@class="Scooter-scooterMenu"]//button[text()="結 帳"]
${XPTAH_CHT_NUMBER_INPUT}                  //input[@id="telecomDiscountPhone"]
${XPATH_CLOSE_AGREEMENT_POP_DOCUMENT}      //button[@aria-label="Close"]/span/i
${XPATH_COMPANY_PROJECT_H3_TEXT}           //h3[contains(.,"公司專案")]
${XPATH_CONFIRM_GOGORO_ACCOUNT_BUTTON}     //*[@id="root"]/div[2]/main/div/div[2]/div/div/form/div[3]/div/div[2]/div/div[1]/div[2]/div/div[3]/button
${XPATH_CREDIT_CARD_MONTH_DIV}             //*[@id="onlineCardMonth"]/div
${XPATH_CREDIT_CARD_YEAR_DIV}              //*[@id="onlineCardYear"]/div
${XPATH_CUSTOMER_NAME_ELEMENT}             //*[@id="customerName"]
${XPATH_DRIVER_SAME_AS_USER_CHECKBOX}      //*[@id="driverSameAsUser"]/div[3]/label/span[1]/input
${XPATH_EVENT_SELECT_DIV}                  //div[@id="EventSelect"]/div
${XPATH_INSTALLMENT_H5}                    //h5[text()="貸款注意事項"]
${XPATH_INSTALLMENT_TYPE_RADIO_BUTTON}     //span[contains(.," x 第 1 ~ 12 期 ") and contains(.,"分期零利率")]
${XPATH_INTELLIGENT_SCOOTER_SCROLLBAR}     //*[@id="SidePanelScrollbars"]/div[1]/div/div[4]/h3/i
${XPATH_OWNER_CITY_DIV}                    //*[@id="OwnerCity"]/div/div
${XPATH_OWNER_DAY_DIV}                     //*[@id="OwnerDay"]/div
${XPATH_OWNER_DISTRICT_DIV}                //*[@id="OwnerDistrict"]/div/div
${XPATH_OWNER_MONTH_DIV}                   //*[@id="OwnerMonth"]/div
${XPATH_OWNER_SAME_AS_USER_CHECKBOX}       //*[@id="ownerSameAsUser"]/div[2]/label/span[1]/input
${XPATH_OWNER_YEAR_DIV}                    //*[@id="OwnerYear"]/div/div/div
${XPATH_PROJECT_EVENT_H3_TEXT}             //h3[contains(.,"專案活動")]
${XPATH_QUOTATION_PDF_IMAGE}               //*[@id="root"]/div/div/div[1]/picture/img
${XPATH_RECOMMEND_EMAIL_ELEMENT}           //*[@id="RecommendEmail"]
${XPATH_RECYCLE_FEE_CHECKBOX}              //input[@name="recycleFee"]
${XPATH_REFERENCE_RADIO_BUTTON}            //*[@id="hasRecommender"]/div[1]/label/span[1]/input
${XPATH_RESTART_BUTTON}                    //span[text()="不，我要重新來過"]/parent::button
${XPATH_SALES_CHANNEL_H3_TEXT}             //h3[contains(.,"銷售通路")]
${XPATH_SCOOTER_DISCOUNT_CODE_ELEMENT}     //*[@id="scooterDiscountCode"]
${XPATH_SCOOTER_DISCOUNT_ID_DIV}           //div[@id="scooterDiscountId"]/div
${XPATH_SCOOTER_RISK_CHECKBOX}             //*[@id="root"]/div[2]/main/div/div[2]/div/div/form/header/div/div/div/span/label/span[1]/span
${XPATH_SCOOTER_SIDE_ACTIVE_H3_I}          //h3[@class="ScooterSide-collapseTitle active"]/i
${XPATH_SEND_QUOTATION_BUTTON}             //*[@id="root"]/div[2]/main/div/form/div[3]/div[1]/div[2]/div[1]/header/div[2]/div/button[1]
${XPATH_SHOPPING_LIST_CONTINUE_BUTTON}     //*[@id="root"]/div[2]/main/div/div[1]/div/div/div[2]/div/button
${XPATH_SHOW_QUOTATION_BUTTON}             //*[@id="root"]/div[2]/main/div/form/div[2]/div/div/div/div[2]/button[contains(.,"報 價")]
${XPATH_SKIP_BUTTON}                       //button[text()="跳過簽署"]
${XPATH_STEP_3_CONTINUE_BUTTON}            //div[@class="orderCollapse-content"][contains(.,"選牌狀況*")]//button[text()="繼 續"]
${XPATH_SUBSIDY_LIMITATION_CHECKBOX}       //*[@id="root"]/div[2]/main/div/div[3]/div/div/form/div[1]/div/div[2]/div/div[2]/div[2]/div/div/span/label/span[1]/span
${XPATH_TAKE_PLATE_SELF_SPAN_BUTTON}       //span[text()="自領牌"]
${XPATH_TAKE_PLATE_SELF_SPAN_TEXT}         //span[text()="出廠車籍資料文件屬 Gogoro 所有，若於領牌前遺失或毀損而造成 Gogoro 之損失，車主須賠償 Gogoro 新臺幣 7,000 元整。"]
${XPATH_TARIFF_NAME}                       //section[1]/dl[@class="InfoList_container__3MlL2"]/dd[1]
${XPATH_TELECOM_COMBOBOX_DIV}              //div[@class="Order-collapseRow" and contains(.,"電信折價卷")]/div/div/div/div/div[@role="combobox"]/div
${XPATH_TELECOM_COUPON_DIV}                //div[@id="telecomDiscountId"]/div
${XPATH_TELECOM_DISCOUNT_H3_TEXT}          //h3[contains(.,"電信折價卷")]
# ----- Verify Element -----
${XPATH_BUYER_ADDRESS_TD_TEXT}             //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[1]/table/tbody/tr[4]/td
${XPATH_BUYER_EMAIL_TD_TEXT}               //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[1]/table/tbody/tr[2]/td
${XPATH_BUYER_NAME_P_TEXT}                 //*[@id="root"]/div[2]/main/div/div/div/div[1]/div/div/div[2]/div[1]/div[2]/p
${XPATH_BUYER_NAME_TD_TEXT}                //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[1]/table/tbody/tr[1]/td
${XPATH_BUYER_PHONE_P_TEXT}                //*[@id="root"]/div[2]/main/div/div/div/div[1]/div/div/div[2]/div[2]/div[2]/p
${XPATH_BUYER_PHONE_TD_TEXT}               //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[1]/table/tbody/tr[3]/td
${XPATH_CHT_PHONE_NUM_ERROR_TEXT}          //*[@id="root"]/div[2]/main/div/div[1]/div/div/div[1]/div/div[2]/div[1]/form/div[3]/div/div/div[2]/div[3]/div/div/div
${XPATH_CREATE_SCOOTER_SUCCESS_H1}         //*[@id="root"]/div[2]/main/div/div/div/h1[1]
${XPATH_DEFAULT_SUBSIDY_CITY}              //*[@id="root"]/div/div/div[5]/div[1]/div/div[2]/div/div[1]/header[3]/span
${XPATH_DEPARTMENT_P}                      //*[@id="root"]/div[2]/main/div/div/div/div[1]/div/div/div[1]/div[2]/div[2]/p
${XPATH_DMS_ORDER_NUMBER_H1}               //*[@id="root"]/div[2]/main/div/div/div/div[1]/header/div[1]/h1
${XPATH_DRIVER_ADDRESS_TD_TEXT}            //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[3]/table/tbody/tr[4]/td
${XPATH_DRIVER_BIRTHDAY_TD_TEXT}           //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[3]/table/tbody/tr[5]/td
${XPATH_DRIVER_EMAIL_TD_TEXT}              //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[3]/table/tbody/tr[2]/td
${XPATH_DRIVER_NAME_TD_TEXT}               //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[3]/table/tbody/tr[1]/td
${XPATH_DRIVER_PHONE_TD_TEXT}              //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[3]/table/tbody/tr[3]/td
${XPATH_OWNER_ADDRESS_TD_TEXT}             //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[2]/table/tbody/tr[4]/td
${XPATH_OWNER_BIRTHDAY_TD_TEXT}            //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[2]/table/tbody/tr[5]/td
${XPATH_OWNER_EMAIL_TD_TEXT}               //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[2]/table/tbody/tr[2]/td
${XPATH_OWNER_NAME_TD_TEXT}                //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[2]/table/tbody/tr[1]/td
${XPATH_OWNER_PHONE_TD_TEXT}               //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[2]/table/tbody/tr[3]/td
${XPATH_OWNER_PROFILE_ID_TD_TEXT}          //*[@id="root"]/div[2]/main/div/div/div[2]/div/div[1]/div[2]/table/tbody/tr[6]/td
${XPATH_SCOOTER_COUPON_CODE_ERROR_TEXT}    //*[@id="root"]/div[2]/main/div/div[1]/div/div/div[1]/div/div[2]/div[1]/form/div[3]/div/div/div[2]/div[2]/div/div/div/div
${XPATH_SCOOTER_DETAIL_BUTTON}             //*[@id="root"]/div[2]/main/div/div/div[2]/div/nav/a[2]
${XPATH_SCOOTER_MODEL_H4}                  //*[@id="root"]/div[2]/main/div/div/div/div[2]/div/div[1]/section[1]/article/div[2]/div[1]/h4
${XPATH_SCOOTER_ORDER_DETAIL_BUTTON}       //*[@id="root"]/div[2]/main/div/div/div/div[3]/div/div/button[3]
