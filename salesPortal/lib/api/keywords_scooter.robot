*** Keywords ***
# -------- Sales Portal Keywords --------
Get Scooter Stock And Type
    [Documentation]    Get scooter stock information from sales portal database
    [Arguments]    ${scooter_model}    ${color}
    ${resp} =               Scooter List Get
    ${scooter_detail} =     Evaluate    list(filter((lambda i: "${scooter_model}" == i["ScooterName"]), ${resp.json()['Data']}))[0]    re
    ${color_detail} =       Evaluate    list(filter((lambda i: "${color}" == i["ColorName"]), ${scooter_detail['Color']}))[0]    re
    [Return]    ${color_detail['Stock']}    ${color_detail['OutStockType']}