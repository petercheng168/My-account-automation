*** Settings ***
Documentation    Test suite for MyGogoro new subscription flow
Resource    ../../init.robot

Force Tags    MyGogoroWeb    New-Sub
Suite Setup    Suite Setup
# Suite Teardown    Close All Browsers
Test Setup    Mapping Scooter VIN And Batteries
Test Teardown    Test Teardown
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***

Return to new subscription first page after click previous button in terms page       #M04-01-08
    Click Button Type Button    為你的新車建立電池服務合約  
    Click Button Type Button    建立電池服務合約  
    Click Button Type Button    上一步
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Page        歡迎登入電池交換平台

Return to new subscription first page after cancel user profile in user profile page          #M04-01-10
    Click Button Type Button    為你的新車建立電池服務合約  
    Click Button Type Button    建立電池服務合約 
    Agree Terms And Conditions
    Input User Information As Subscriber But Cancel
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Page        歡迎登入電池交換平台

Return to new subscription first page after cancel user profile in choose plan page           #M04-01-16
    Click Button Type Button    為你的新車建立電池服務合約  
    Click Button Type Button    建立電池服務合約 
    Agree Terms And Conditions
    Input User Information As Subscriber
    Click Button Type Button    上一步
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub User Profile Page       使用者資料

Return to new subscription plan page after cancel user profile in cancel disclaimer page              #M04-01-23
    Click Button Type Button  為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings Cancel Disclaimer
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Choose Plan Page       點選你愛的資費方案

Return to new subscription plan page after cancel system charge       #系統開通設定費
    Click Button Type Button  為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings Cancel System Pay
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Choose Plan Page       點選你愛的資費方案

Return to new subscription plan page after cancel addon setting           #M04-01-24
    Click Button Type Button  為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings Cancel Addon Setting
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Choose Plan Page       點選你愛的資費方案

Return to new subscription plan page after disable addon setting              #M04-01-24
    Click Button Type Button  為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings Disable Addon       addon=None
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Choose Plan Page       點選你愛的資費方案

Return to new subscription plan page after cancel invoice seeting             #M04-01-31
    Click Button Type Button  為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings Cancel Invoice Setting      #取消發票設定
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Choose Plan Page       點選你愛的資費方案

Return to new subscription plan page after cancel contract service seeting            #M04-01-32
    Click Button Type Button  為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings  
    Click Button Type Button    上一步     #確認取消服務合約簽署
    Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Choose Plan Page       帳單與發票設定
    Sleep   2s

# Return to new subscription plan page after cancel contract service seeting           #M04-01-32
#     Click Button Type Button  為你的新車建立電池服務合約   
#     Click Button Type Button    建立電池服務合約        
#     Agree Terms And Conditions
#     Input User Information As Subscriber
#     Choose Es Contract Settings  
#     Click Button Type Button    上一步     #確認取消服務合約簽署
#     Wait Until Keyword Succeeds    10s    2s   Verify In Newsub Choose Plan Page       帳單與發票設定
#     Click Button Type Button    上一步     #確認取消服務合約簽署

Upload incorrect front ID card        #M04-01-33
    Click Button Type Button  為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings  
    Upload Incorrect User Front Id Card
    Wait Until Keyword Succeeds    10s    2s    Verify In Upload ID Card Or License Page        檔案上傳錯誤\n請選擇 PNG 或 JPG 檔案，並確認檔案小於 10MB，然後再試一次
    Sleep   2s

Upload incorrect back ID card         #M04-01-33
    Click Button Type Button  為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings  
    Upload Incorrect User Back Id Card
    Wait Until Keyword Succeeds    10s    2s    Verify In Upload ID Card Or License Page        檔案上傳錯誤\n請選擇 PNG 或 JPG 檔案，並確認檔案小於 10MB，然後再試一次     #worng format message
    Sleep   2s
    
Clear the battery contract signature canvas of new subscription           #M04-01-39
    Click Button Type Button    為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings
    Upload User Id Card
    Signed Battery Contract Again
    Sleep   2s

Clear the personal data signature canvas of new subscription          #M04-01-44
    Click Button Type Button    為你的新車建立電池服務合約   
    Click Button Type Button    建立電池服務合約        
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings
    Upload User Id Card
    Signed Personal Data Agreement Again
    Sleep   2s

Upload incorrect scooter license of new subscription
    Click Button Type Button    為你的新車建立電池服務合約   #原本是新車輛改成原廠新車又改成為你的新車建立電池服務合約 
    Click Button Type Button    建立電池服務合約        #原本是建立電池服務合約新車輛改成建立電池服務合約
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings
    Upload User Id Card
    Send Es Contract To User Email After Sign A Signature
    Upload Incorrect Scooter License
    Wait Until Keyword Succeeds    10s    2s    Verify In Upload ID Card Or License Page        檔案上傳錯誤\n請選擇 PNG 或 JPG 檔案，並確認檔案小於 10MB，然後再試一次
    Sleep   2s

Upload only plate information of new subscription                 #M04-01-53
    Click Button Type Button    為你的新車建立電池服務合約   #原本是新車輛改成原廠新車又改成為你的新車建立電池服務合約 
    Click Button Type Button    建立電池服務合約        #原本是建立電池服務合約新車輛改成建立電池服務合約
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings
    Upload User Id Card
    Send Es Contract To User Email After Sign A Signature
    Upload User Scooter Information Only Plate      ${Scooter.plate} 
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter User Name Is Blank In Upload Information Page         請填入車主姓名
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter Vin Is Blank In Upload Information Page           請填入車身號碼
    Wait Until Keyword Succeeds    10s    2s    Verify Battery Num Is Blank In Upload Information Page           請填入電池序號
    Sleep   2s

Upload only scooter user name information of new subscription             #M04-01-53
    Click Button Type Button    為你的新車建立電池服務合約   #原本是新車輛改成原廠新車又改成為你的新車建立電池服務合約 
    Click Button Type Button    建立電池服務合約        #原本是建立電池服務合約新車輛改成建立電池服務合約
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings
    Upload User Id Card
    Send Es Contract To User Email After Sign A Signature
    Upload User Scooter Information Only User Name      ${User.last_name}${User.first_name} 
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter Plate Is Blank In Upload Information Page         請填入您的車牌號碼
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter Vin Is Blank In Upload Information Page           請填入車身號碼
    Wait Until Keyword Succeeds    10s    2s    Verify Battery Num Is Blank In Upload Information Page           請填入電池序號
    Sleep   2s

Upload only scooter vin information of new subscription               #M04-01-53
    Click Button Type Button    為你的新車建立電池服務合約   #原本是新車輛改成原廠新車又改成為你的新車建立電池服務合約 
    Click Button Type Button    建立電池服務合約        #原本是建立電池服務合約新車輛改成建立電池服務合約
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings
    Upload User Id Card
    Send Es Contract To User Email After Sign A Signature
    Upload User Scooter Information Only Scooter Vin      ${Scooter.scooter_vin}    
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter Plate Is Blank In Upload Information Page         請填入您的車牌號碼
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter User Name Is Blank In Upload Information Page         請填入車主姓名
    Wait Until Keyword Succeeds    10s    2s    Verify Battery Num Is Blank In Upload Information Page           請填入電池序號
    Sleep   2s

Upload only battery number information of new subscription            #M04-01-53
    Click Button Type Button    為你的新車建立電池服務合約   #原本是新車輛改成原廠新車又改成為你的新車建立電池服務合約 
    Click Button Type Button    建立電池服務合約        #原本是建立電池服務合約新車輛改成建立電池服務合約
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings
    Upload User Id Card
    Send Es Contract To User Email After Sign A Signature
    Upload User Scooter Information Only Battery Number      ${last_six_sn}
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter Plate Is Blank In Upload Information Page         請填入您的車牌號碼
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter User Name Is Blank In Upload Information Page         請填入車主姓名
    Wait Until Keyword Succeeds    10s    2s    Verify Scooter Vin Is Blank In Upload Information Page           請填入車身號碼
    Sleep   2s

Check contract draft step of new subscription
    Click Button Type Button    為你的新車建立電池服務合約   #原本是新車輛改成原廠新車又改成為你的新車建立電池服務合約 
    Click Button Type Button    建立電池服務合約        #原本是建立電池服務合約新車輛改成建立電池服務合約
    Agree Terms And Conditions
    Input User Information As Subscriber
    Choose Es Contract Settings
    Upload User Id Card
    Send Es Contract To User Email After Sign A Signature
    

*** Keywords ***
Create Batteries
    :FOR    ${index}    IN RANGE    2
    \    Create Battery    ${index}

Create Battery
    [Arguments]    ${index}
    Setup Battery Variables
    ${resp} =    Batteries Post    ${Battery.battery_guid}    ${Battery.battery_sn}    ${Battery.charge_cycles}\
    ...    ${Battery.state}    ${Battery.manufacture_date}    ${Battery.pn}
    Set Test Variable    ${battery_guid${index}}    ${Battery.battery_guid}
    Set Test Variable    ${battery_sn${index}}    ${Battery.battery_sn}

Create Scooter
    Setup Scooter Variables
    ${resp} =    Scooters Post    ${Scooter.company_code}    TW    ${Scooter.scooter_vin}\
    ...    ${Scooter.scooter_guid}    ${Scooter.matnr}    ${Scooter.atmel_key}    ${Scooter.state}    ${Scooter.es_state}\
    ...    ${Scooter.ecu_status}    ${Scooter.keyfobs_status}    keyfobs_id=${Scooter.keyfobs_id}\
    ...    motor_num=${Scooter.motor_num}    atmel_sn=${Scooter.atmel_sn}    ecu_mac=${Scooter.ecu_mac}\
    ...    ecu_sn=${Scooter.ecu_sn}    manufacture_date=${Scooter.manufacture_date}
    Set Test Variable    ${scooter_Id}    ${resp.json()['data'][0]['scooter_id']}

Mapping Scooter VIN And Batteries
    ${swap_id} =    Generate Random String    8    [NUMBERS]
    Create Scooter
    Create Batteries
    Batteries Swap Logs Post Gds    ${swap_id}    ${Scooter.scooter_guid}    ${battery_guid0}    ${battery_guid1}
    ${resp} =    Scooters Batteries Get    ${scooter_Id}
    ${last_six_sn} =    Evaluate    str('${battery_sn0}')[-6:]
    Set Test Variable    ${last_six_sn}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][0]['battery_sn']}    ${battery_sn0}
    Verify Response Contains Expected    ${resp.json()['data'][0]['batteries'][1]['battery_sn']}    ${battery_sn1}

Setup Battery Variables
    Set Test Variable    ${Battery}    ${Batteries()}

Setup Scooter Variables
    Set Test Variable    ${Scooter}    ${Scooters('B22318608', 'BUS')}

Setup User Variables
    ${password} =    Encode Password Get    Gogoro123
    Set Suite Variable    ${User}    ${User('${password.text}')}

Signup User
    Setup User Variables
    ${resp} =    Users Post    ${User.company_code}    ${User.first_name}    ${User.gender}    ${User.email}    ${User.status}\
    ...    ${User.enable_e_carrier}    ${User.last_name}    ${User.display_name}    ${User.birthday}\
    ...    ${User.contact_address}    ${User.contact_district}    ${User.contact_city}    ${User.contact_zipcode}\
    ...    ${User.invoice_address}    ${User.invoice_district}    ${User.invoice_city}    ${User.invoice_zipcode}\
    ...    ${User.country_code}    mobile_phone1=${User.mobile}    profile_id=E123456789    password=${User.encode_password}\
    ...    login_phone=${User.phone}    occupation=${User.occupation}    gogoro_guid=${User.gogoro_guid}
    Set Suite Variable    ${user_Id}    ${resp.json()['data'][0]['user_id']}
    Users Update Email Verified    ${user_Id}    1

Suite Setup
    Open Browser    ${MYGOGORO_GN_DOMAIN}    ${WINDOW_HEIGHT}    ${WINDOW_WEIGHT}
    Signup User
    Login With Email And Password    ${User.email}    Gogoro123
    ${gogoro-sess}    ${csrf_token} =    Sign In MyGogoro Account To Return New Cookie    ${User.email}    ${User.encode_password}
    Set Suite Variable    ${gogoro-sess}
    Set Suite Variable    ${csrf_token}

Test Teardown
    ${resp} =    Api My Subscription Draft Delete    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    ${resp} =    Api My Subscription Inactive Delete    ${gogoro-sess}    ${csrf_token}
    Verify Status Code As Expected    ${resp}   200
    Go To    https://pa-network-my.gogoro.com/new-sub 


