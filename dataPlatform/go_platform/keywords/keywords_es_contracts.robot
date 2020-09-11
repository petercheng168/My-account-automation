*** Keywords ***
# -------- Gogoro Keywords --------
Create Es Contracts
    [Documentation]    Create es contracts
    [Arguments]    ${order_id}    ${user_id}    ${account_type}    ${bill_to_user_id}    ${bill_to_user_type}    ${owner_id}    ${plan_id}    ${plan_effective_date}    ${contract_type}    ${payment_responsibility}    ${status}    ${cycle_end_day}=${31}    ${account}=${None}
    ${resp} =    Es Contracts Post    ${order_id}    ${user_id}    ${account_type}    ${bill_to_user_id}    ${bill_to_user_type}    ${owner_id}    ${plan_id}    ${plan_effective_date}    ${contract_type}    ${payment_responsibility}    ${status}    ${cycle_end_day}    account=${account}
    [Return]    ${resp.json()['data'][0]['es_contract_id']}

Create Es Contract With Addon And Promotion
    [Documentation]    Create es contract with addon, promotion. (Es Status: 2/WA)
    [Arguments]    ${EsContract}    ${Order}    ${User}
    ${es_contract_id} =    Create Es Contracts
    ...    order_id=${Order.order_id}    user_id=${User.user_id}
    ...    account_type=1                bill_to_user_id=${Order.owner_id}
    ...    bill_to_user_type=1           owner_id=${Order.owner_id}
    ...    plan_id=${EsContract.es_plan_id}
    ...    plan_effective_date=${EsContract.effective_date}
    ...    contract_type=1
    ...    payment_responsibility=1
    ...    status=2
    ...    cycle_end_day=${EsContract.cycle_end_day}
    Es Contracts Update Addons        ${es_contract_id}    ${EsContract.es_plan_id}    2    1    ${None}    ${EsContract.start_date}    ${None}    ${None}    1    0    addon_code=${EsContract.addon_code}
    Es Contracts Update Addons        ${es_contract_id}    ${EsContract.es_plan_id}    2    1    ${None}    ${EsContract.start_date}    ${None}    ${None}    1    0    addon_code=SUBFEE-00003
    Es Contracts Update Promotions    ${es_contract_id}    ${EsContract.es_plan_id}    2    1    ${EsContract.promotion_id}    ${EsContract.start_date}    ${None}    ${None}
    [Return]    ${es_contract_id}

Create Es Contract With Flex Plan
    [Documentation]    Create es contract for flex plan (promotion_code: BI007, BI008 addon_code: SUBFEE-00002)
    [Arguments]    ${Order}    ${User}    ${start_date}    ${effective_date}=${start_date}    ${end_date}=${None}    ${account}=${None}
    ${es_plan_id} =            Get Es Plan Id Via Es Plan Code    SUBFEE-00049
    ${promotion_BI007_id} =    Get Promotion Id Via Promotion Name    免費性能提升    account=${account}
    ${promotion_BI008_id} =    Get Promotion Id Via Promotion Name    加送電池使用費折抵金    account=${account}
    ${es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${es_plan_id}    ${effective_date}    1    1    2    account=${account}
    Es Contracts Update Addons        ${es_contract_id}    ${es_plan_id}    2    1    ${None}                  ${start_date}    ${end_date}    ${effective_date}    1    0    addon_code=SUBFEE-00002    account=${account}
    Es Contracts Update Promotions    ${es_contract_id}    ${es_plan_id}    2    1    ${promotion_BI007_id}    ${start_date}    ${end_date}    ${effective_date}    account=${account}
    Es Contracts Update Promotions    ${es_contract_id}    ${es_plan_id}    2    1    ${promotion_BI008_id}    ${start_date}    ${end_date}    ${effective_date}    account=${account}
    [Return]    ${es_contract_id}    ${promotion_BI007_id}

Search Es Contract With UserId
    [Documentation]    Search es contracts with user_id
    [Arguments]    ${user_id}
    ${resp} =    Es Contracts Search    user_id=${user_id}
    [Return]    ${resp}

# -------- Verify Keywords --------
Verify Es Plan Effective Date Should Be Greater Than
    [Documentation]    Verify the es contract plan effetive date should be greater than expected
    [Arguments]    ${es_contract_id}    ${expected}
    ${resp} =    Es Contracts Get    ${es_contract_id}
    Should Be Greater Than    ${resp.json()['data'][0]['plan_effective_date']}    ${expected}

Verify Es Contract Plan Effective Date As Expected
    [Documentation]    Verify the es contract plan effetive date is expected or not
    [Arguments]    ${es_contract_id}    ${expected}
    ${resp} =    Es Contracts Get    ${es_contract_id}
    Should Be Equal As Strings    ${resp.json()['data'][0]['plan_effective_date']}    ${expected}

Verify Es Contract Status As Expected
    [Documentation]    Verify the es contract status is expected or not
    [Arguments]    ${es_contract_id}    ${expected}
    ${resp} =    Es Contracts Get    ${es_contract_id}
    Should Be Equal As Strings    ${resp.json()['data'][0]['status']}    ${expected}

Verify Es Contract Plan Histories As Expected
    [Documentation]    Verify the es contract plan histories
    [Arguments]    ${resp}    ${EsContract}    ${es_plan_id}=${EsContract.es_plan_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['es_contract_id']}         ${EsContract.es_contract_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['plan_id']}                ${es_plan_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['plan_effective_date']}    ${EsContract.effective_date}