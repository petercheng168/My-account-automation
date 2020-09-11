*** Keywords ***
# -------- Gogoro Keywords --------
Update Bill Status
    [Documentation]    update es_bill.bill_status to specific status
    [Arguments]    ${es_bill_ids}   ${bill_status}
    FOR    ${index}    IN RANGE    2    ${bill_status}+1
        Es Bills Transitions Update    bill_status=${index}    es_bill_ids=${es_bill_ids}
    END

# -------- Verify Keywords --------