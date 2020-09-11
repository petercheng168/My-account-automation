*** Keywords ***
# -------- Gogoro Keywords --------
Get Promotion Id Via Promotion Name
    [Documentation]    Get the specific promotion id via promotion name
    [Arguments]    ${promotion_name}    ${account}=${None}
    ${resp} =    Promotions Get Via Promotion Name    ${promotion_name}    account=${account}
    [Return]    ${resp.json()['data'][0]['promotion_id']}

Get Latest Published Activate Es Promotion Id
    [Documentation]    Get the latest published and activate es promotion's id (published: 1, status: 1)
    ${current_timestamp} =    Evaluate    int(time.time())   time
    ${resp} =    Promotions Get    1    1    0    ${current_timestamp}
    [Return]    ${resp.json()['data'][0]['promotion_id']}

Get Promotion Id Via Promotion Code
    [Documentation]    Get the specific promotion id via promotion code
    [Arguments]    ${promotion_code}
    ${resp} =    Promotions Get    1    1    ${None}    ${None}
    ${promotion_data} =    Evaluate    list(filter((lambda i: 'promotion_code' in i.keys() and "${promotion_code}" == i["promotion_code"]), ${resp.json()['data']}))[0]    re
    [Return]    ${promotion_data['promotion_id']}

# -------- Verify Keywords --------