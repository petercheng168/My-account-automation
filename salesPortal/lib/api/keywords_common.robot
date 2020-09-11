*** Keywords ***
# -------- Sales Portal Keywords --------
Create Es-contract With Recycle Fee
    [Documentation]    Create es-contract with recycle fee (non flex plan)
    [Arguments]    ${input_order_id}    ${input_buyer_id}    ${input_owner_id}
    ...    ${input_plan_id}    ${current_time}    ${end_time}
    ${resp} =    Es Contracts Post    order_id=${input_order_id}
    ...    user_id=${input_buyer_id}    account_type=1
    ...    bill_to_user_id=${input_owner_id}    bill_to_user_type=1
    ...    owner_id=${input_owner_id}    plan_id=${input_plan_id}
    ...    plan_effective_date=${current_time}    contract_type=1
    ...    payment_responsibility=1    status=2
    ...    plan_start=${current_time}    plan_end=${None}
    ...    contract_date=${current_time}    cipher_app=sales_portal
    ...    cipher_resource=sales_portal    account=${SALES_ACCOUNT}
    ...    cipher_pwd=${SALES_PASSWORD}    go_client=sales_portal
    Es Contracts Update Addons
    ...    es_contract_id=${resp.json()['data'][0]['es_contract_id']}
    ...    plan_id=${input_plan_id}    status=2    op_type=1
    ...    addon_id=${None}    start_date=${current_time}
    ...    end_date=${end_time}    effective_date=${current_time}
    ...    addon_type=1    payment_responsibility=0    addon_code=SUBFEE-00003
    ...    cipher_app=sales_portal     cipher_resource=sales_portal
    ...    account=${SALES_ACCOUNT}    cipher_pwd=${SALES_PASSWORD}
    ...    go_client=sales_portal

Create Flex Plan With Recycle Fee
    [Documentation]    Create flex plan with recycle fee
    [Arguments]    ${input_order}    ${input_buyer}    ${input_plan_id}
    ...    ${current_time}    ${end_time}
    ${es_contract_id}    ${bi_007} =    Create Es Contract With Flex Plan
    ...    ${input_order}    ${input_buyer}
    ...    start_date=${current_time}    effective_date=${current_time}
    ...    end_date=${end_time}    cipher_app=sales_portal
    ...    cipher_resource=sales_portal    account=${SALES_ACCOUNT}
    ...    cipher_pwd=${SALES_PASSWORD}    go_client=sales_portal
    Es Contracts Update Addons
    ...    es_contract_id=${es_contract_id}    plan_id=${input_plan_id}
    ...    status=2    op_type=1    addon_id=${None}
    ...    start_date=${current_time}    end_date=${end_time}
    ...    effective_date=${current_time}    addon_type=1
    ...    payment_responsibility=0    addon_code=SUBFEE-00003
    ...    cipher_app=sales_portal     cipher_resource=sales_portal
    ...    account=${SALES_ACCOUNT}    cipher_pwd=${SALES_PASSWORD}
    ...    go_client=sales_portal

Create Legal Entity Order
    [Documentation]    Keyword to create legal entity order by sp api, given:
    ...    licensing_location: place to take plate
    ...    licensing_location_id: location code
    ...    document_payer: 1 = legal_entity pay, 2 = gogoro user pay
    ...    token: keyword = Get SP Token
    ...    scooter_model: Gogoro S2 Cafe Racer (MY19) = "GSBH2-000-CF" (default), Viva = "GSFC2-000-LO"
    ...    license_type: 1 = 重型車 (default), 2 = 輕型車
    [Arguments]    ${licensing_location}    ${licensing_location_id}    ${document_payer}    ${token}
    ...    ${scooter_model}=GSBH2-000-CF    ${license_type}=1    ${payment_type}=cash
    ...    ${agency_fee}=0    ${subsidy_type}=2    ${is_tes}=${TRUE}    ${is_epa}=${FALSE}
    ...    ${is_epb}=${FALSE}    ${input_delivery_location}=${EMPTY}    ${product_name}=Gogoro S2 Café Racer
    ${department_code} =    Get Department Code
    Run Keyword If    '${input_delivery_location}' == '${EMPTY}'    Set Test Variable    ${delivery_location}    ${department_code}
    ...    ELSE    Set Test Variable    ${delivery_location}    ${input_delivery_location}
    ${legal_entity}    Set Variable    ${Roles('${SALES_PORTAL_LEGAL_ENTITY_EMAIL}')}
    ${user_guid} =    Login Buyer Account    ${legal_entity.email}    ${legal_entity.part_phone}    ${token}
    ${resp}    ${hash_id} =    Shopping Cart Scooter Add To Cart Post    ${product_name}    token=${token}
    Order Form Get Checkout Data    1    ${legal_entity.email}    token=${token}    hash_id=${hash_id}
    Set Test Variable    ${shopping_cart_hash_id}    ${hash_id}
    ${resp} =    Checking Out Scooter Order    ${legal_entity}    ${legal_entity}    ${legal_entity}
    ...    ${SALES_ACCOUNT}    A    Gogoro 門市    ${None}    ${None}
    ...    ${delivery_location}    ${delivery_location}    ${EMPTY}    1    2
    ...    ${license_type}    2    legal_entity    ${licensing_location}    ${licensing_location_id}    ${agency_fee}    self_plate
    ...    ${document_payer}    ${payment_type}    ${subsidy_type}    ${is_tes}    ${is_epa}    ${is_epb}
    ...    ${token}    ${hash_id}
    Set Test Variable    ${Order}    ${Orders('${resp["OrderNo"]}')}
    Set Test Variable    ${shopping_cart_hash_id}    ${hash_id}
    ${Order.order_id} =    Set Variable    ${resp['OrderId']}
    ${Order.owner_id} =    Set Variable    ${resp['OwnerId']}
    Utility Test Order Opening Invoice Get    ${resp['OrderNo']}    token=${token}
    Log To Console    ${resp['OrderNo']}
    [Return]    ${resp['OrderNo']}

Create Scooter Order
    [Documentation]    Keyword to create scooter order by sp api, given:
    ...    Buyer: Roles object, Owner = Buyer (default), Driver = Buyer (default)
    ...    subsidy_city and subsidy_type should be paired (ex: 新北市 1906)
    ...    es_plan_code: SUBFEE-00049 = Flex Plan , SUBFEE-00040 = 預選里程105
    ...    licensing_location: place to take plate
    ...    licensing_location_id: location code
    ...    token: keyword = Get SP Token
    ...    scooter_model: Gogoro S2 Cafe Racer (MY19) = "GSBH2-000-CF" (default), Viva = "GSFC2-000-LO"
    ...    license_type: 1 = 重型車 (default), 2 = 輕型車
    [Arguments]    ${Buyer}    ${subsidy_city}    ${local_subsidy_type_id}    ${es_plan_code}    ${licensing_location}
    ...    ${licensing_location_id}    ${agency_fee}    ${token}
    ...    ${Owner}=${Buyer}    ${Driver}=${Buyer}    ${scooter_model}=GSBH2-000-CF    ${license_type}=1
    ...    ${payment_type}=cash    ${sales_channel_no}=A    ${sales_channel_name}=Gogoro 門市
    ...    ${invoice_number}=${None}    ${invoice_date}=${None}    ${subsidy_type}=2    ${is_tes}=${TRUE}
    ...    ${is_epa}=${TRUE}    ${is_epb}=${TRUE}    ${input_delivery_location}=${EMPTY}
    ...    ${product_name}=Gogoro S2 Café Racer
    Run Keyword If    '${licensing_location}' == '自領牌'    Set Test Variable    ${plate_type}    self_plate
    ...    ELSE    Set Test Variable    ${plate_type}    gogoro_plate
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${end_date_timestamp} =    Evaluate    int(time.time()+65536)   time
    ${department_code} =    Get Department Code
    Run Keyword If    '${input_delivery_location}' == '${EMPTY}'    Set Test Variable    ${delivery_location}    ${department_code}
    ...    ELSE    Set Test Variable    ${delivery_location}    ${input_delivery_location}
    ${user_guid} =    Login Buyer Account    ${buyer.email}    ${buyer.part_phone}    ${token}
    ${resp}    ${hash_id} =    Shopping Cart Scooter Add To Cart Post    ${product_name}    token=${token}
    ${resp} =    Checking Out Scooter Order    ${Buyer}    ${Owner}    ${Driver}
    ...    ${SALES_ACCOUNT}    ${sales_channel_no}    ${sales_channel_name}    ${invoice_number}    ${invoice_date}
    ...    ${delivery_location}    ${delivery_location}    ${subsidy_city}    1    ${local_subsidy_type_id}
    ...    ${license_type}    1    normal    ${licensing_location}    ${licensing_location_id}    ${agency_fee}
    ...    ${plate_type}    1    ${payment_type}    ${subsidy_type}    ${is_tes}    ${is_epa}    ${is_epb}
    ...    token=${token}    hash_id=${hash_id}
    Set Test Variable    ${Order}    ${Orders('${resp["OrderNo"]}')}
    Set Test Variable    ${shopping_cart_hash_id}    ${hash_id}
    ${Order.order_id} =    Set Variable    ${resp['OrderId']}
    ${Order.owner_id} =    Set Variable    ${resp['OwnerId']}
     # 判斷車型電池數量
    ${es_plan_id} =    Run Keyword If    '${scooter_model}' == 'GSFC2-000-LO'
    ...    Get Es Plan Id Via Es Plan Code    ${es_plan_code}    1
    ...    ELSE
    ...    Get Es Plan Id Via Es Plan Code    ${es_plan_code}    2
    # 判斷資費方案種類
    Run Keyword If    '${es_plan_code}' == 'SUBFEE-00049'
    ...    Create Flex Plan With Recycle Fee    ${Order}    ${Buyer}
    ...    ${es_plan_id}    ${current_timestamp}    ${end_date_timestamp}
    ...    ELSE IF    '${es_plan_code}' == 'SUBFEE-00053'
    ...    Create Single Plan With Recycle Fee    ${Order}    ${Buyer}
    ...    ${es_plan_id}    ${current_timestamp}    ${end_date_timestamp}
    ...    ELSE
    ...    Create Es-contract With Recycle Fee    ${resp['OrderId']}
    ...    ${buyer.user_id}    ${resp['OwnerId']}    ${es_plan_id}
    ...    ${current_timestamp}    ${end_date_timestamp}
    Utility Test Order Opening Invoice Get    ${resp['OrderNo']}    token=${token}
    Log To Console    ${resp['OrderNo']}
    [Return]    ${resp['OrderNo']}

Create Single Plan With Recycle Fee
    [Documentation]    Create single battery flex plan with recycle fee
    [Arguments]    ${input_order}    ${input_buyer}    ${input_plan_id}
    ...    ${current_time}    ${end_time}
    ${es_contract_id}    ${bi_011} =    Create Es Contract With Single Battery Flex Plan
    ...    ${input_order}    ${input_buyer}
    ...    start_date=${current_time}    effective_date=${current_time}
    ...    end_date=${end_time}    cipher_app=sales_portal
    ...    cipher_resource=sales_portal    account=${SALES_ACCOUNT}
    ...    cipher_pwd=${SALES_PASSWORD}    go_client=sales_portal
    Es Contracts Update Addons
    ...    es_contract_id=${es_contract_id}    plan_id=${input_plan_id}
    ...    status=2    op_type=1    addon_id=${None}
    ...    start_date=${current_time}    end_date=${end_time}
    ...    effective_date=${current_time}    addon_type=1
    ...    payment_responsibility=0    addon_code=SUBFEE-00003
    ...    cipher_app=sales_portal     cipher_resource=sales_portal
    ...    account=${SALES_ACCOUNT}    cipher_pwd=${SALES_PASSWORD}
    ...    go_client=sales_portal

Update Invoice Status To Already Paid
    [Documentation]    Update invoice status to already paid, sleep to simulate pos operation will not too fast
    [Arguments]    ${dms_order_no}    ${times}    ${token}    ${invoice_number}=CG00000003
    ${resp} =    Utility Test Order Info Get    ${dms_order_no}    ${token}
    FOR    ${idx}    IN RANGE    ${times}
    Utility Test Order Update Invoice Opened Post    ${resp.json()['Data']['DeliveryStoreId']}
    ...    ${resp.json()['Data']['InvoiceList'][${idx}-1]['InvoiceTypeText']}    ${dms_order_no}
    ...    ${resp.json()['Data']['InvoiceList'][${idx}-1]['Amount']}    ${resp.json()['Data']['InvoiceList'][${idx}-1]['InvoiceTransactionNo']}
    ...    ${invoice_number}    ${token}
    Sleep    2s
    END

Update Order From Waiting Checkout To Waiting Redemption
    [Documentation]    Keyword for update scooter order status to (I,10008)
    [Arguments]    ${dms_order_no}
    ${resp} =    Orders Get    scooter    0    10    None    ${dms_order_no}    None
    ${order_id} =    Set Variable     ${resp.json()['data'][0]['order_id']}
    ${current_time} =    Evaluate    int(time.time())   time
    Orders Update    order_id=${order_id}    order_type=VEH_SALE_CR
    ...    order_number=None    order_state=I    user_id=None
    ...    flow_status=10008    scooter_allocation_flag=2
    ...    delivery_time=${current_time}    sales_portal_flag=1
    ...    scooter_model=GSBH2-000-CF    account=${CIPHER_GSS_ACCOUNT}

# -------- Verify Keywords --------
