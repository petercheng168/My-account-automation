*** Keywords ***
# -------- Sales Portal Keywords --------
Checking Out Scooter Order
    [Documentation]    Create scooter order with buyer, owner, driver, subsidy and licensing information
    [Arguments]    ${Buyer}    ${Owner}    ${Driver}    ${employee_no}
    ...    ${sales_channel_no}    ${sales_channel_name}    ${invoice_number}    ${invoice_date}    ${store_id}
    ...    ${pdi_store_id}    ${subsidy_city}    ${tes_subsidy_type_id}    ${local_subsidy_type_id}
    ...    ${license_type}    ${order_type}    ${scooter_type}    ${licensing_location}    ${licensing_location_id}
    ...    ${agency_fee}    ${plate_type}    ${document_payer}    ${payment_type}    ${subsidy_type}    ${is_tes}
    ...    ${is_epa}    ${is_epb}    ${token}    ${hash_id}
    ${resp} =    Shopping Cart Checkout Post    ${Buyer.user_guid}    ${employee_no}    ${Buyer.email}    ${Buyer.name}
    ...    ${Buyer.gender}    ${Buyer.full_phone}    ${Buyer.city}    ${Buyer.district}    ${Buyer.zipcode}    ${Buyer.address}
    ...    ${Owner.email}    ${Owner.name}    ${Owner.gender}    ${Owner.profile_id}    ${Owner.full_phone}    ${Owner.birthday}
    ...    ${Owner.city}    ${Owner.district}    ${Owner.zipcode}    ${Owner.address}    ${Driver.name}    ${Driver.email}
    ...    ${sales_channel_no}    ${sales_channel_name}    ${invoice_number}    ${invoice_date}
    ...    ${store_id}    ${pdi_store_id}    ${Driver.user_guid}    ${Driver.birthday}   ${subsidy_city}
    ...    ${tes_subsidy_type_id}    ${local_subsidy_type_id}    ${licensing_location}    ${licensing_location_id}    ${agency_fee}
    ...    ${license_type}    ${order_type}    ${scooter_type}    ${plate_type}    ${document_payer}    ${payment_type}
    ...    ${subsidy_type}    ${is_tes}    ${is_epa}    ${is_epb}    ${token}    ${hash_id}
    [Return]    ${resp.json()['Data']}

Update Scooter Order
    [Documentation]    Update scooter order
    [Arguments]    ${Owner}    ${dms_order_no}    ${order_type}    ${sales_channel_no}
    ...    ${licensing_location}    ${licensing_location_id}    ${license_type}    ${payment_type}
    ...    ${is_payment_change}    ${document_payer}    ${scooter_model}    ${agency_fees}
    ...    ${is_receive_award}    ${token}    ${hash_id}
    ${resp} =    Shopping Cart Modify Order Post    ${dms_order_no}    ${order_type}    ${sales_channel_no}
    ...    ${Owner.email}    ${Owner.name}    ${Owner.gender}    ${Owner.profile_id}    ${Owner.full_phone}
    ...    ${Owner.birthday}    ${Owner.city}    ${Owner.district}    ${Owner.zipcode}    ${Owner.address}
    ...    ${licensing_location}    ${licensing_location_id}    ${license_type}    ${payment_type}
    ...    ${is_payment_change}    ${document_payer}    ${scooter_model}    ${agency_fees}
    ...    ${is_receive_award}    ${token}    ${hash_id}
    [Return]    ${resp.json()['Data']}
