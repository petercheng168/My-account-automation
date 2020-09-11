*** Settings ***
Documentation    Test suite of Sales_Portal Verify Invoice Detail Information
Resource    ../init.robot

Force Tags    SalesPortal
Suite Teardown    Close All Browsers
Test Teardown    Test Teardown
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Add accessory to scooter order
    [Tags]    CID:5158
    [Setup]    Test Setup For Creating Scooter Order
    Update Scooter Order
    ...    Owner=${owner}    dms_order_no=${dms_order_no}    order_type=1
    ...    sales_channel_no=A    licensing_location=台北領牌中心    licensing_location_id=DMV_TP
    ...    license_type=1    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=Accessories    agency_fees=2215
    ...    is_receive_award=-1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    token=${token}
    Verify Add Accessories Invoice Information    ${dms_order_no}

Change scooter order payment type
    [Tags]    CID:5159
    [Setup]    Test Setup For Creating Scooter Order
    Update Scooter Order
    ...    Owner=${owner}    dms_order_no=${dms_order_no}    order_type=1
    ...    sales_channel_no=A    licensing_location=台北領牌中心    licensing_location_id=DMV_TP
    ...    license_type=1    payment_type=2    is_payment_change=1
    ...    document_payer=1    scooter_model=Gogoro S2 Cafe Racer    agency_fees=-1
    ...    is_receive_award=-1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    token=${token}
    Verify Change Payment Type Invoice Information    ${dms_order_no}

Change scooter order scooter owner
    [Tags]    CID:5160
    [Setup]    Test Setup For Change Scooter Owner
    Update Scooter Order
    ...    Owner=${new_owner}    dms_order_no=${dms_order_no}    order_type=1
    ...    sales_channel_no=A    licensing_location=台北領牌中心    licensing_location_id=DMV_TP
    ...    license_type=1    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=Gogoro S2 Cafe Racer    agency_fees=-1
    ...    is_receive_award=-1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    token=${token}
    Verify Change Scooter Owner Invoice Information    ${dms_order_no}

Change scooter order scooter type to Gogoro VIVA
    [Tags]    CID:5161
    [Setup]    Test Setup For Creating Scooter Order
    Update Scooter Order
    ...    Owner=${owner}    dms_order_no=${dms_order_no}    order_type=1
    ...    sales_channel_no=A    licensing_location=台北領牌中心    licensing_location_id=DMV_TP
    ...    license_type=2    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=Gogoro VIVA    agency_fees=1685
    ...    is_receive_award=-1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    token=${token}
    Verify Change Scooter Invoice Information    ${dms_order_no}

Change scooter order take plate location
    [Tags]    CID:5162
    [Setup]    Test Setup For Creating Scooter Order
    Update Scooter Order
    ...    Owner=${owner}    dms_order_no=${dms_order_no}    order_type=1
    ...    sales_channel_no=A    licensing_location=高雄領牌中心    licensing_location_id=DMV_KS
    ...    license_type=1    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=Gogoro S2 Cafe Racer    agency_fees=2380
    ...    is_receive_award=-1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    token=${token}
    Verify Change Take Plate Location Invoice Information    ${dms_order_no}

Change scooter order take plate method
    [Tags]    CID:5163
    [Setup]    Test Setup For Creating Scooter Order
    Update Scooter Order
    ...    Owner=${owner}    dms_order_no=${dms_order_no}    order_type=1
    ...    sales_channel_no=A    licensing_location=自領牌    licensing_location_id=DMV_ZL
    ...    license_type=1    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=Gogoro S2 Cafe Racer    agency_fees=0
    ...    is_receive_award=-1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    token=${token}
    Verify Change Take Plate Method Invoice Information    ${dms_order_no}

Create legal entity order in franchise
    [Tags]    CID:6046
    [Setup]    Test Setup For Creating Legal Entity Order In Franchise    ${SALES_PORTAL_BUYER_EMAIL}
    Update Invoice Status To Already Paid    ${dms_order_no}    3    ${franchise_token}
    Update Scooter Order
    ...    Owner=${buyer}    dms_order_no=${dms_order_no}    order_type=2
    ...    sales_channel_no=A    licensing_location=茁壯創能_屏東領牌中心    licensing_location_id=B58635038_PT
    ...    license_type=1    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=Legal Entity    agency_fees=2215
    ...    is_receive_award=1    token=${franchise_token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    ${franchise_token}
    Update Invoice Status To Already Paid    ${dms_order_no}    5    ${franchise_token}
    Verify Create Legal Entity Order In Franchise    ${dms_order_no}

Create legal entity order with card
    [Tags]    CID:6070
    [Setup]    Test Setup For Creating Legal Entity Order With Payment Type    ${SALES_PORTAL_BUYER_EMAIL}    card
    Update Invoice Status To Already Paid    ${dms_order_no}    3    ${token}
    Update Scooter Order
    ...    Owner=${buyer}    dms_order_no=${dms_order_no}    order_type=2
    ...    sales_channel_no=A    licensing_location=台北領牌中心    licensing_location_id=DMV_TP
    ...    license_type=1    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=Legal Entity    agency_fees=2215
    ...    is_receive_award=1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    ${token}
    Update Invoice Status To Already Paid    ${dms_order_no}    5    ${token}
    Verify Create Legal Entity Order With Payment Type    ${dms_order_no}    card

Create legal entity order with cash
    [Tags]    CID:6071
    [Setup]    Test Setup For Creating Legal Entity Order With Payment Type    ${SALES_PORTAL_BUYER_EMAIL}    cash
    Update Invoice Status To Already Paid    ${dms_order_no}    3    ${token}
    Update Scooter Order
    ...    Owner=${buyer}    dms_order_no=${dms_order_no}    order_type=2
    ...    sales_channel_no=A    licensing_location=台北領牌中心    licensing_location_id=DMV_TP
    ...    license_type=1    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=Legal Entity    agency_fees=2215
    ...    is_receive_award=1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    ${token}
    Update Invoice Status To Already Paid    ${dms_order_no}    5    ${token}
    Verify Create Legal Entity Order With Payment Type    ${dms_order_no}    cash

Create scooter order from Carrefour
    [Tags]    CID:6047
    [Setup]    Test Setup For Creating Scooter Order With Channel    H    家樂福    cash
    Update Invoice Status To Already Paid    ${dms_order_no}    2    ${token}    ${invoice_number}
    Verify Create Scooter From Channel    ${dms_order_no}    ${invoice_number}

Create scooter order from RT-Mart
    [Tags]    CID:6048
    [Setup]    Test Setup For Creating Scooter Order With Channel    I    大潤發    cash
    Update Invoice Status To Already Paid    ${dms_order_no}    2    ${token}    ${invoice_number}
    Verify Create Scooter From Channel    ${dms_order_no}    ${invoice_number}

Create scooter order in franchise from Carrefour
    [Tags]    CID:6049
    [Setup]    Test Setup For Creating Scooter Order In Franchise With Channel    H    家樂福    cash
    Update Invoice Status To Already Paid    ${dms_order_no}    2    ${franchise_token}    ${invoice_number}
    Verify Create Scooter In Franchise From Channel    ${dms_order_no}    ${invoice_number}

Create scooter order in franchise from RT-Mart
    [Tags]    CID:6050
    [Setup]    Test Setup For Creating Scooter Order In Franchise With Channel    I    大潤發    cash
    Update Invoice Status To Already Paid    ${dms_order_no}    2    ${franchise_token}    ${invoice_number}
    Verify Create Scooter In Franchise From Channel    ${dms_order_no}    ${invoice_number}

Create scooter order in franchise with cash
    [Tags]    CID:6051
    [Setup]    Test Setup For Creating Scooter Order In Franchise    cash    茁壯創能_屏東領牌中心    B58635038_PT    2215
    Verify Create Scooter In Franchise With Cash    ${dms_order_no}

Create scooter order in franchise with loan
    [Tags]    CID:6052
    [Setup]    Test Setup For Creating Scooter Order In Franchise    loan    茁壯創能_屏東領牌中心    B58635038_PT    2215
    Verify Create Scooter In Franchise With Loan    ${dms_order_no}

Create scooter order with card
    [Tags]    CID:6053
    [Setup]    Test Setup For Creating Scooter Order With Payment Type    card
    Verify Create Scooter With Any Payment Type    ${dms_order_no}    card

Create scooter order with cash
    [Tags]    CID:6054
    [Setup]    Test Setup For Creating Scooter Order With Payment Type    cash
    Verify Create Scooter With Any Payment Type    ${dms_order_no}    cash

Create scooter order with loan
    [Tags]    CID:6055
    [Setup]    Test Setup For Creating Scooter Order With Payment Type    loan
    Verify Create Scooter With Any Payment Type    ${dms_order_no}    loan

Remove scooter order down payment with loan
    [Tags]    CID:5164
    [Setup]    Test Setup For Creating Scooter Order With Payment Type    loan
    Update Scooter Order
    ...    Owner=${owner}    dms_order_no=${dms_order_no}    order_type=1
    ...    sales_channel_no=A    licensing_location=台北領牌中心    licensing_location_id=DMV_TP
    ...    license_type=1    payment_type=3    is_payment_change=0
    ...    document_payer=1    scooter_model=Gogoro S2 Cafe Racer    agency_fees=-1
    ...    is_receive_award=-1    token=${token}    hash_id=${shopping_cart_hash_id}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    token=${token}
    Verify Remove Down Payment Invoice Information    ${dms_order_no}

*** Keywords ***
Setup For Direct Selling
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    Set Test Variable    ${token}    ${get_token}
    Login With Direct Login
    Click Button In Main Body    待處理訂單
    Verify Page URL    ${SALES_PORTAL_URL}/order/manage

Setup For Franchise
    ${get_token} =    Get SP Token    ${FRANCHISE_ACCOUNT}    ${FRANCHISE_PASS}
    Set Test Variable    ${franchise_token}    ${get_token}
    Login With Direct Login    ${FRANCHISE_ACCOUNT}    ${FRANCHISE_PASS}
    Click Button In Main Body    待處理訂單
    Verify Page URL    ${SALES_PORTAL_URL}/order/manage

Test Setup For Change Scooter Owner
    Setup For Direct Selling
    Test Setup For Creating Scooter Order
    Set Test Variable    ${new_owner}    ${Roles('${SALES_PORTAL_OWNER_EMAIL}')}

Test Setup For Creating Legal Entity Order In Franchise
    [Arguments]    ${buyer_email}
    Setup For Franchise
    User Information Setup    ${buyer_email}    ${buyer_email}    ${buyer_email}
    ${dms_order_no} =    Create Legal Entity Order
    ...    licensing_location=茁壯創能_屏東領牌中心    licensing_location_id=B58635038_PT
    ...    document_payer=1    token=${franchise_token}
    Set Test Variable    ${dms_order_no}

Test Setup For Creating Legal Entity Order With Payment Type
    [Arguments]    ${buyer_email}    ${payment_type}
    Setup For Direct Selling
    User Information Setup    ${buyer_email}    ${buyer_email}    ${buyer_email}
    ${dms_order_no} =    Create Legal Entity Order
    ...    licensing_location=自領牌    licensing_location_id=DMV_ZL
    ...    document_payer=1    token=${token}    payment_type=${payment_type}
    Set Test Variable    ${dms_order_no}

Test Setup For Creating Scooter Order
    [Arguments]    ${buyer_email}=${SALES_PORTAL_BUYER_EMAIL}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}    ${licensing_location}=台北領牌中心    ${licensing_location_id}=DMV_TP    ${agency_fee}=2215
    Setup For Direct Selling
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    ${dms_order_no} =    Create Scooter Order
    ...    Buyer=${buyer}    subsidy_city=臺北市    local_subsidy_type_id=1903    es_plan_code=SUBFEE-00049
    ...    licensing_location=${licensing_location}    licensing_location_id=${licensing_location_id}
    ...    agency_fee=${agency_fee}    token=${token}    Owner=${owner}    Driver=${driver}
    Set Test Variable    ${dms_order_no}

Test Setup For Creating Scooter Order In Franchise
    [Arguments]    ${payment_type}    ${licensing_location}    ${licensing_location_id}    ${agency_fee}
    Setup For Franchise
    User Information Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}
    ${dms_order_no} =    Create Scooter Order
    ...    Buyer=${buyer}    subsidy_city=臺北市    local_subsidy_type_id=1903    es_plan_code=SUBFEE-00049
    ...    licensing_location=${licensing_location}    licensing_location_id=${licensing_location_id}
    ...    agency_fee=${agency_fee}    token=${franchise_token}    Owner=${owner}    Driver=${driver}
    ...    payment_type=${payment_type}
    Set Test Variable    ${dms_order_no}

Test Setup For Creating Scooter Order In Franchise With Channel
    [Arguments]    ${sales_channel_no}    ${sales_channel_name}    ${payment_type}
    ...    ${buyer_email}=${SALES_PORTAL_BUYER_EMAIL}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}
    ...    ${licensing_location}=茁壯創能_屏東領牌中心    ${licensing_location_id}=B58635038_PT    ${agency_fee}=2215
    ${invoice_number} =    Generate Random String    10    [NUMBERS]
    ${current_date} =    Get Current Date    UTC    increment=+ 1 hours    result_format=%Y-%m-%dT%H:%M:%S.000000Z
    ${invoice_date} =    Evaluate    int((datetime.datetime.strptime("${current_date}", "%Y-%m-%dT%H:%M:%S.%fZ") + datetime.timedelta(hours=8)).timestamp())    datetime
    Setup For Franchise
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    ${dms_order_no} =    Create Scooter Order
    ...    Buyer=${buyer}    subsidy_city=臺北市    local_subsidy_type_id=1903    es_plan_code=SUBFEE-00049
    ...    licensing_location=${licensing_location}    licensing_location_id=${licensing_location_id}
    ...    agency_fee=${agency_fee}    token=${franchise_token}    Owner=${owner}    Driver=${driver}
    ...    sales_channel_no=${sales_channel_no}    sales_channel_name=${sales_channel_name}
    ...    invoice_number=${invoice_number}    invoice_date=${invoice_date}
    Set Test Variable    ${dms_order_no}
    Set Test Variable    ${invoice_number}

Test Setup For Creating Scooter Order With Channel
    [Arguments]    ${sales_channel_no}    ${sales_channel_name}    ${payment_type}
    ...    ${buyer_email}=${SALES_PORTAL_BUYER_EMAIL}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}
    ...    ${licensing_location}=台北領牌中心    ${licensing_location_id}=DMV_TP    ${agency_fee}=2215
    ${invoice_number} =    Generate Random String    10    [NUMBERS]
    ${current_date} =    Get Current Date    UTC    increment=+ 1 hours    result_format=%Y-%m-%dT%H:%M:%S.000000Z
    ${invoice_date} =    Evaluate    int((datetime.datetime.strptime("${current_date}", "%Y-%m-%dT%H:%M:%S.%fZ") + datetime.timedelta(hours=8)).timestamp())    datetime
    Setup For Direct Selling
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    ${dms_order_no} =    Create Scooter Order
    ...    Buyer=${buyer}    subsidy_city=臺北市    local_subsidy_type_id=1903    es_plan_code=SUBFEE-00049
    ...    licensing_location=${licensing_location}    licensing_location_id=${licensing_location_id}
    ...    agency_fee=${agency_fee}    token=${token}    Owner=${owner}    Driver=${driver}
    ...    sales_channel_no=${sales_channel_no}    sales_channel_name=${sales_channel_name}
    ...    invoice_number=${invoice_number}    invoice_date=${invoice_date}
    Set Test Variable    ${dms_order_no}
    Set Test Variable    ${invoice_number}

Test Setup For Creating Scooter Order With Payment Type
    [Arguments]    ${payment_type}    ${buyer_email}=${SALES_PORTAL_BUYER_EMAIL}    ${owner_email}=${buyer_email}    ${driver_email}=${buyer_email}    ${licensing_location}=台北領牌中心    ${licensing_location_id}=DMV_TP    ${agency_fee}=2215
    Setup For Direct Selling
    User Information Setup    ${buyer_email}    ${owner_email}    ${driver_email}
    ${dms_order_no} =    Create Scooter Order
    ...    Buyer=${buyer}    subsidy_city=臺北市    local_subsidy_type_id=1903    es_plan_code=SUBFEE-00049
    ...    licensing_location=${licensing_location}    licensing_location_id=${licensing_location_id}
    ...    agency_fee=${agency_fee}    token=${token}    Owner=${owner}    Driver=${driver}
    ...    payment_type=${payment_type}
    Set Test Variable    ${dms_order_no}

Test Teardown
    Click Logout Button
    Close All Browsers

User Information Setup
    [Arguments]    ${buyer_email}    ${owner_email}    ${driver_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}
