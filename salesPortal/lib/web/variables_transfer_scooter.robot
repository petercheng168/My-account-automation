*** Variables ***
# ----- Keyword Element -----
${XPATH_ADD_NEW_TRANSFER_BUTTON_A}              //a[contains(.,"新增過戶作業")]
${XPATH_BATTERY_TARIFF_PLAN_OPTIONS_UL}         //ul[@class="PlanSelector_container__gGIuh"]
${XPATH_CANCEL_TRANSFER_ORDER_BUTTUON}          //ul[@class="OrderTable-row"]//span[text()="陳龍馬"]/../..//button[text()="取消"]
${XPATH_CANVAS}                                 //canvas[@class="SignaturePad-canvas"]
${XPATH_CANVAS_VIEW_P}                          //*[@id="root"]/div[2]/main/div/div/div/div[2]/div/div/div[4]/div[2]/p
${XPATH_CONFIRM_UPLOAD_BUTTON}                  (//div[contains(@class, "ant-drawer-open")]//button[text()="確認上傳"])
${XPATH_CONTINUE_TRANSFER_BUTTON}               //button[text()="提交過戶完成"]
${XPATH_DOUBLE_CONFIRM_BUTTON}                  //*[@id="root"]/div[2]/main/div/div[2]/div/div/div/div/div[2]/button
${XPATH_END_SIGN_UP_BUTTON}                     //div[@class="SignaturePad-btnWrap"]/button[3]
${XPATH_GET_ES_CONTRACT_BUTTON}                 //*[@id="root"]/div[2]/main/div/div[1]/div/div/form/div/div/div[2]/div/div/button
${XPATH_INPUT_TRANSFER_DATA_H5}                 //*[@id="root"]/div[2]/main/div/div[1]/div/div/form/div[1]/div/div[2]/div/div[1]/h5[2]
${XPATH_NEXT_SIGN_UP_BUTTON}                    //div[@class="SignaturePad-btnWrap"]//button[@class="btn btn_blackOutline"][3]
${XPATH_PLATE_DATE_INPUT}                       //*[@id="plateDate"]/div/input
${XPATH_RECYCLE_FEE_TRANSFER_CHECKBOX}          //input[@name="recycleFee"]
${XPATH_SAVE_SIGN_UP_BUTTON}                    //button[@class="btn btn_blackOutline"][contains(.,"儲存")]
${XPATH_SELECT_MANAGER_DIV}                     //*[@id="managerName"]/div/div/div
${XPATH_SELECT_TARIFF_PLAN_CONTINUE_BUTTON}     //button[@type="submit"]
${XPATH_SEND_TRANSFER_SCOOTER_DATA_BUTTON}      //*[@id="root"]/div[2]/main/div/div[1]/div/div/div/div/div[2]/button
${XPATH_SIGN_UP_BUTTON}                         //button[text()="簽名"]
${XPATH_START_SIGN_UP_BUTTON}                   //button[contains(.,"進行簽署")]
${XPATH_TRANSFER_SCOOTER_DATA_TITLE_P}          //*[@id="root"]/div[2]/main/div//div[1]/div/div/form/div[2]/div/div[2]/div/div/div/p
# ----- Verify Element -----
${XPATH_ORDERTABLE_UL}                          //ul[@class="OrderTable-row"]