*** Keywords ***
# -------- Gogoro Keywords --------
Register Invoice To An Es Bill Writeoff By Es_Bill_Id
    [Documentation]    register invoice to an es bill writeoff detail by es_bill_id
    [Arguments]    ${es_bill_id}    ${invoice_no}   ${invoice_time}    ${invoice_type}    ${invoice_random_code}
    ${resp} =    Es Bill Writeoffs Update    es_bill_id=${es_bill_id}    es_bill_writeoff_id=${None}    invoice_no=${invoice_no}   invoice_time=${invoice_time}    invoice_type=${invoice_type}    invoice_random_code=${invoice_random_code}
    [Return]    ${resp}

Get Es Bill Writeoffs By BillId
    [Documentation]    get es bill writeoff detail by es_bill_id
    [Arguments]    ${es_bill_id} 
    ${resp} =    Es Bill Writeoffs Get    es_bill_id=${es_bill_id}
    [Return]    ${resp}

# -------- Verify Keywords --------