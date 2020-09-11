*** Settings ***
Documentation    Test suite of Sales_Portal setup scooter auto pairing test data
Resource    ../init.robot

Force Tags    SalesPortal
Test Timeout    3600

*** Variables ***
# order_channel
${預設}             ${SCOOTER_AUTO_PAIRING_DEFAULT_ACCOUNT}
${茁壯}             PT0012T
${智慧嘉}            SP1234
${斯酷德}            SCT0010T
${菊島}             JDGL001
${岡山}             ES313024
# dept_code
${小港漢民店}         PTS31603
${高雄中正交車中心}    ES314006
${嘉義興業東門市}      ES316002
${南區建成門市}       SCTS1601
${基隆義一門市}       ES316020
# product_name
${BH2+防滑墊}        Gogoro S2 Café Racer+Anti slip mat
${BH2+照地燈}        Gogoro S2 Café Racer+Light sensor
${BR2+防滑墊}        Gogoro 2 Delight+Anti slip mat
${BR2+照地燈}        Gogoro 2 Delight+Light sensor
${BY2+防滑墊}        Gogoro 2 Rumbler+Anti slip mat
${BY2+照地燈}        Gogoro 2 Rumbler+Light sensor
# scooter_owner
${個人}             ${SALES_PORTAL_BUYER_EMAIL}
${法人}             order-system@gogoro.com
# update_product_name
${Legal_BH2+防滑墊}    Legal_Entity+GogoroS2CaféRacer+Anti slip mat
${Legal_BR2+防滑墊}    Legal_Entity+Gogoro 2 Delight+Anti slip mat
${Legal_BR2+照地燈}    Legal_Entity+Gogoro 2 Delight+Light sensor
${Legal_BY2+照地燈}    Legal_Entity+Gogoro 2 Rumbler+Light sensor

*** Test Cases ***
Create legal entity scooter auto pairing data
    [Template]    Create Legal Entity Order In Gogoro
    51    ${預設}      GSBH2-000-CF    0    ${FALSE}    ${FALSE}    ${FALSE}    2    ${BH2+防滑墊}    台北領牌中心            DMV_TP          ${None}                                   paid=No
    52    ${茁壯}      GSBR2-000-GD    0    ${FALSE}    ${FALSE}    ${FALSE}    1    ${BR2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${None}               ${小港漢民店}         paid=No
    53    ${斯酷德}    GSBH2-000-CF    1    ${TRUE}     ${FALSE}    ${FALSE}    2    ${BH2+防滑墊}    斯酷德_彰化領牌中心      B58462205_CH    ${None}               ${南區建成門市}        paid=No
    54    ${岡山}      GSBY2-000-SI    1    ${TRUE}     ${FALSE}    ${FALSE}    1    ${BY2+照地燈}    高雄領牌中心            DMV_KS          ${None}               ${高雄中正交車中心}    paid=No
    55    ${智慧嘉}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    1    ${BR2+防滑墊}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${None}               ${嘉義興業東門市}      paid=No
    56    ${菊島}      GSBR2-000-GD    0    ${FALSE}    ${FALSE}    ${FALSE}    2    ${BR2+照地燈}    菊島_澎湖領牌中心       B24209129_PH     ${Legal_BR2+照地燈}    ${基隆義一門市}
    57    ${預設}      GSBH2-000-CF    0    ${FALSE}    ${FALSE}    ${FALSE}    1    ${BH2+防滑墊}    台北領牌中心            DMV_TP          ${Legal_BH2+防滑墊}
    58    ${茁壯}      GSBY2-000-SI    1    ${TRUE}     ${FALSE}    ${FALSE}    2    ${BY2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${Legal_BY2+照地燈}    ${小港漢民店}
    59    ${岡山}      GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    1    ${BY2+照地燈}    高雄領牌中心            DMV_KS          ${Legal_BR2+防滑墊}    ${高雄中正交車中心}
    60    ${智慧嘉}    GSBY2-000-SI    1    ${TRUE}     ${FALSE}    ${FALSE}    1    ${BY2+照地燈}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${Legal_BY2+照地燈}    ${嘉義興業東門市}

Create scooter auto pairing data
    [Template]    Create Scooter Order In Gogoro
    1     ${預設}      ${None}    ${None}    GSBH2-000-CF    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BH2+防滑墊}    台北領牌中心            DMV_TP                               paid=No
    2     ${茁壯}      ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    2    ${BR2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}          paid=No
    3     ${預設}      臺北市      2004       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BH2+防滑墊}    台北領牌中心            DMV_TP                               paid=No
    4     ${茁壯}      高雄市      2029       GSBY2-000-SI    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    2    ${BY2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}          paid=No
    5     ${斯酷德}    臺中市      2015       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    斯酷德_彰化領牌中心      B58462205_CH    ${南區建成門市}        paid=No
    6     ${岡山}      ${None}    ${None}    GSBH2-000-CF    0    ${FALSE}    ${FALSE}    ${FALSE}    ${法人}    2    ${BH2+照地燈}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}    paid=No
    7     ${智慧嘉}    ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${個人}    1    ${BR2+防滑墊}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}      paid=No
    8     ${岡山}      宜蘭縣      2033       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    2    ${BH2+照地燈}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}    paid=No
    9     ${智慧嘉}    嘉義縣      2023       GSBY2-000-SI    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BY2+防滑墊}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}      paid=No
    10    ${菊島}      基隆市      2001       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    2    ${BR2+照地燈}    菊島_澎湖領牌中心       B24209129_PH     ${基隆義一門市}       paid=No
    11    ${預設}      ${None}    ${None}    GSBH2-000-CF    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BH2+防滑墊}    台北領牌中心            DMV_TP
    12    ${茁壯}      ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    2    ${BR2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}
    13    ${斯酷德}    臺中市      2015       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BH2+防滑墊}    斯酷德_彰化領牌中心      B58462205_CH    ${南區建成門市}
    14    ${岡山}      宜蘭縣      2033       GSBY2-000-SI    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    2    ${BY2+照地燈}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}
    15    ${智慧嘉}    嘉義縣      2023       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}
    16    ${菊島}      基隆市      2001       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    2    ${BH2+照地燈}    菊島_澎湖領牌中心       B24209129_PH     ${基隆義一門市}
    17    ${預設}      臺北市      2004       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    台北領牌中心            DMV_TP
    18    ${茁壯}      高雄市      2029       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    2    ${BH2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}
    19    ${岡山}      ${None}    ${None}    GSBY2-000-SI    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BY2+防滑墊}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}
    20    ${智慧嘉}    ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    2    ${BR2+照地燈}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}
    21    ${預設}      ${None}    ${None}    GSBH2-000-CF    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BH2+防滑墊}    台北領牌中心            DMV_TP
    22    ${茁壯}      ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    1    ${BR2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}
    23    ${斯酷德}    臺中市      2015       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BH2+防滑墊}    斯酷德_彰化領牌中心      B58462205_CH    ${南區建成門市}
    24    ${岡山}      宜蘭縣      2033       GSBY2-000-SI    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BY2+照地燈}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}
    25    ${智慧嘉}    嘉義縣      2023       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}
    26    ${菊島}      基隆市      2001       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BH2+照地燈}    菊島_澎湖領牌中心       B24209129_PH     ${基隆義一門市}
    27    ${預設}      臺北市      2004       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    台北領牌中心            DMV_TP
    28    ${茁壯}      高雄市      2029       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BH2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}
    29    ${岡山}      ${None}    ${None}    GSBY2-000-SI    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BY2+防滑墊}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}
    30    ${智慧嘉}    ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    1    ${BR2+照地燈}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}
    31    ${預設}      ${None}    ${None}    GSBH2-000-CF    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BH2+防滑墊}    台北領牌中心            DMV_TP
    32    ${茁壯}      ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    1    ${BR2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}
    33    ${斯酷德}    臺中市      2015       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BH2+防滑墊}    斯酷德_彰化領牌中心      B58462205_CH    ${南區建成門市}
    34    ${岡山}      宜蘭縣      2033       GSBY2-000-SI    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BY2+照地燈}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}
    35    ${智慧嘉}    嘉義縣      2023       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}
    36    ${菊島}      基隆市      2001       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BH2+照地燈}    菊島_澎湖領牌中心       B24209129_PH     ${基隆義一門市}
    37    ${預設}      臺北市      2004       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    台北領牌中心            DMV_TP
    38    ${茁壯}      高雄市      2029       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BH2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}
    39    ${岡山}      ${None}    ${None}    GSBY2-000-SI    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BY2+防滑墊}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}
    40    ${智慧嘉}    ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    1    ${BR2+照地燈}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}
    41    ${預設}      ${None}    ${None}    GSBH2-000-CF    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BH2+防滑墊}    台北領牌中心            DMV_TP
    42    ${茁壯}      ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    1    ${BR2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}
    43    ${斯酷德}    臺中市      2015       GSBH2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BH2+防滑墊}    斯酷德_彰化領牌中心      B58462205_CH    ${南區建成門市}
    44    ${岡山}      宜蘭縣      2033       GSBY2-000-SI    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BY2+照地燈}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}
    45    ${智慧嘉}    嘉義縣      2023       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}
    46    ${菊島}      基隆市      2001       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BH2+照地燈}    菊島_澎湖領牌中心       B24209129_PH     ${基隆義一門市}
    47    ${預設}      臺北市      2004       GSBR2-000-GD    2    ${TRUE}     ${TRUE}     ${TRUE}     ${個人}    1    ${BR2+防滑墊}    台北領牌中心            DMV_TP
    48    ${茁壯}      高雄市      2029       GSBH2-000-CF    2    ${TRUE}     ${TRUE}     ${TRUE}     ${法人}    1    ${BH2+照地燈}    茁壯創能_屏東領牌中心    B58635038_PT    ${小港漢民店}
    49    ${岡山}      ${None}    ${None}    GSBY2-000-SI    0    ${FALSE}    ${FALSE}    ${FALSE}    ${個人}    1    ${BY2+防滑墊}    高雄領牌中心            DMV_KS          ${高雄中正交車中心}
    50    ${智慧嘉}    ${None}    ${None}    GSBR2-000-GD    1    ${TRUE}     ${FALSE}    ${FALSE}    ${法人}    1    ${BR2+照地燈}    智慧嘉_嘉義市領牌中心    B58239804_CYI    ${嘉義興業東門市}

Create scooter into go_platform and dms storage
    [Template]    Create Scooter Into Go_Platform And DMS Storage
    GSBH2-000-CF    ES700000N31
    GSBH2-000-CF    ES700000N31
    GSBH2-000-CF    ES700000N31
    GSBH2-000-CF    ES700000N31
    GSBH2-000-CF    ES700000N31
    GSBH2-000-CF    ES700000N31
    GSBH2-000-CF    ES700000N31
    GSBH2-000-CF    ES700000N31
    GSBH2-000-CF    ES700000N30
    GSBH2-000-CF    ES700000N30

*** Keywords ***
Create Legal Entity Order In Gogoro
    [Arguments]    ${data_no}    ${sales_account}    ${scooter_model}
    ...    ${subsidy_type}    ${is_tes}    ${is_epa}    ${is_epb}
    ...    ${scooter_allocation_flag}    ${product_name}
    ...    ${licensing_location}    ${licensing_location_id}
    ...    ${update_product_name}    ${delivery_location}=${EMPTY}
    ...    ${paid}=Yes    ${license_type}=1    ${sales_channel_no}=A
    ...    ${sales_channel_name}=Gogoro 門市    ${sales_password}=${SCOOTER_AUTO_PAIRING_PASSWORD}
    Setup For Get Token    ${sales_account}    ${sales_password}
    ${dms_order_no} =    Create Legal Entity Order
    ...    licensing_location=自領牌    licensing_location_id=DMV_ZL
    ...    document_payer=1    token=${token}
    ...    scooter_model=${scooter_model}    license_type=${license_type}
    ...    payment_type=cash    agency_fee=0    subsidy_type=${subsidy_type}
    ...    is_tes=${is_tes}    is_epa=${is_epa}    is_epb=${is_epb}
    ...    product_name=${product_name}
    ...    input_delivery_location=${delivery_location}
    Utility Test Order Opening Invoice Get    ${dms_order_no}    token=${token}
    Set Test Variable    ${dms_order_no}
    Run Keyword If    '${paid}' == 'Yes'
    ...    Run Keywords
    ...    User Information Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}
    ...    AND
    ...    Update Invoice Status To Already Paid    ${dms_order_no}    3    ${token}
    ...    AND
    ...    Update Scooter Order
    ...    Owner=${buyer}    dms_order_no=${dms_order_no}    order_type=2
    ...    sales_channel_no=A    licensing_location=${licensing_location}
    ...    licensing_location_id=${licensing_location_id}
    ...    license_type=1    payment_type=2    is_payment_change=0
    ...    document_payer=1    scooter_model=${update_product_name}    agency_fees=2215
    ...    is_receive_award=1    token=${token}    hash_id=${shopping_cart_hash_id}
    ...    AND
    ...    Utility Test Order Opening Invoice Get    ${dms_order_no}    ${token}
    ...    AND
    ...    Update Invoice Status To Already Paid    ${dms_order_no}    5    ${token}
    ${es_plan_id} =    Get Es Plan Id Via Es Plan Code    SUBFEE-40036
    ${current_timestamp} =    Evaluate    int(time.time())   time
    Run Keyword If    '${paid}' == 'No'
    ...    User Information Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}    ${SALES_PORTAL_BUYER_EMAIL}
    Es Contracts Post    ${Order.order_id}    ${buyer.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${es_plan_id}    ${current_timestamp}    1    1    2
    ...    cipher_app=sales_portal     cipher_resource=sales_portal
    ...    account=${SALES_ACCOUNT}    cipher_pwd=${SALES_PASSWORD}
    ...    go_client=sales_portal
    Update Scooter Pairing Flag Post    ${dms_order_no}    ${scooter_allocation_flag}    ${token}

Create Scooter Into Go_Platform And DMS Storage
    [Arguments]    ${scooter_model}    ${storage_code}
    ${order_no} =    Evaluate    int(time.time())    time
    Setup Scooter Variables    ${scooter_model}
    Add Scooter Information To DMS    P${order_no}    ${scooter.scooter_vin}    ${storage_code}    ${scooter_model}
    [Teardown]    Log To Console    ${scooter.scooter_vin}

Create Scooter Order In Gogoro
    [Arguments]    ${data_no}    ${sales_account}    ${subsidy_city}
    ...    ${local_subsidy_type_id}    ${scooter_model}    ${subsidy_type}
    ...    ${is_tes}    ${is_epa}    ${is_epb}
    ...    ${owner_email}    ${scooter_allocation_flag}
    ...    ${product_name}    ${licensing_location}
    ...    ${licensing_location_id}    ${delivery_location}=${EMPTY}
    ...    ${paid}=Yes    ${license_type}=1    ${sales_channel_no}=A
    ...    ${sales_channel_name}=Gogoro 門市    ${sales_password}=${SCOOTER_AUTO_PAIRING_PASSWORD}
    Setup For Get Token    ${sales_account}    ${sales_password}
    User Information Setup    ${SALES_PORTAL_BUYER_EMAIL}    ${owner_email}    ${SALES_PORTAL_BUYER_EMAIL}
    ${dms_order_no} =    Create Scooter Order
    ...    Buyer=${buyer}    subsidy_city=${subsidy_city}    local_subsidy_type_id=${local_subsidy_type_id}    es_plan_code=SUBFEE-00041
    ...    licensing_location=${licensing_location}    licensing_location_id=${licensing_location_id}
    ...    agency_fee=2215    token=${token}    Owner=${owner}    Driver=${driver}
    ...    scooter_model=${scooter_model}    license_type=${license_type}
    ...    payment_type=cash    sales_channel_no=${sales_channel_no}
    ...    sales_channel_name=${sales_channel_name}    subsidy_type=${subsidy_type}    is_tes=${is_tes}
    ...    is_epa=${is_epa}    is_epb=${is_epb}    input_delivery_location=${delivery_location}
    ...    product_name=${product_name}
    Set Test Variable    ${dms_order_no}
    Run Keyword If    '${paid}' == 'Yes'    Update Invoice Status To Already Paid    ${dms_order_no}    5    ${token}    SWQA000001
    Update Scooter Pairing Flag Post    ${dms_order_no}    ${scooter_allocation_flag}    ${token}

Setup For Get Token
    [Arguments]    ${sales_account}    ${sales_password}
    ${get_token} =    Get SP Token    ${sales_account}    ${sales_password}
    Set Test Variable    ${token}    ${get_token}

Setup Scooter Variables
    [Arguments]    ${scooter_model}
    Set Test Variable    ${scooter}    ${Scooters('${scooter_model}')}
    Scooters Post    company_code=${scooter.company_code}    country_code=${scooter.country}
    ...    scooter_vin=${scooter.scooter_vin}    scooter_guid=${scooter.scooter_guid}
    ...    matnr=${scooter.matnr}    atmel_key=${scooter.atmel_key}    state=${scooter.state}
    ...    es_state=${scooter.es_state}    ecu_status=${scooter.ecu_status}
    ...    status=${scooter.keyfobs_status}    manufacture_date=${scooter.manufacture_date}
    ...    keyfobs_id=${scooter.keyfobs_id}

User Information Setup
    [Arguments]    ${buyer_email}    ${owner_email}    ${driver_email}
    Set Test Variable    ${buyer}    ${Roles('${buyer_email}')}
    Set Test Variable    ${owner}    ${Roles('${owner_email}')}
    Set Test Variable    ${driver}    ${Roles('${driver_email}')}
