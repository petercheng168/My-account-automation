*** Variables ***
# ----- Keyword Element -----
${XPATH_BOOKING_DATE_SPAN}                   //span[@id="bookingDate"]
${XPATH_CALENDAR_ADD_BUTTON}                 //button[@class="EventCalendar-add"]
${XPATH_CALENDAR_DATE_INPUT}                 //div[@class="ant-calendar-date-input-wrap"]/input
${XPATH_CONFIRM_DELIVERY_DATE_BUTTON}        //button[@class="EventCalendar-formBtn btn btn_black"]
${XPATH_OK_SPAN_TEXT}                        //span[text()="確 定"]
${XPATH_ORDER_APPLY_TO_TAKE_PLATE_BUTTON}    //button[@class="Attach-btn btn btn_black"]
${XPATH_ORDER_BANK_BRANCH_CODE_INPUT}        //label[@class="BankAccountForm_label__2Asv-"]//div[@class="ant-select-selection__rendered"]//input
${XPATH_ORDER_BANK_BRANCH_CODE_LABEL}        //label[@class="BankAccountForm_label__2Asv-"]//div[@class="ant-select-selection__rendered"]
${XPATH_ORDER_BANK_CONFIRM_BUTTON}           //button[@class="btn btn_blackOutline"]
${XPATH_ORDER_BANK_USER_INPUT}               //input[@name="account"]
${XPATH_ORDER_SELECT_DATE_BUTTON}            //*[text()="選擇日期"]
${XPATH_SCOOTER_LICENSE_UPLOAD_BUTTON}       //li[@class="PreDeliver-opItem"][contains(.,"行照")]/div/button[text()="上傳"]
${XPATH_UPLOAD_INPUT}                        //div[contains(@class, "ant-drawer-open")]//input
# ----- Go Support Site ----- 
${XPATH_GO_SUPPORT_OK_BUTTON}                //button[text()="OK"]
${XPATH_GO_SUPPORT_ORDER_NO_INPUT}           //input[@id="txtOrderNo"]
${XPATH_GO_SUPPORT_SEARCH_BAR_BUTTON}        //button[@id="btnSearchBar"]
${XPATH_GO_SUPPORT_SEARCH_BUTTON}            //button[@id="btnSearch"]