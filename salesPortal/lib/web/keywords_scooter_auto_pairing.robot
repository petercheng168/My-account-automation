*** Settings ***
Resource    variables_scooter_auto_pairing.robot

*** Keywords ***
# --------   SP Elements   --------
# --------   SP Keywords   --------
Add Scooter Information To DMS
    [Documentation]    Call API to create scooter into DMS
    [Arguments]    ${dms_order_no}    ${scooter_vin}    ${company_department_code}    ${scooter_model}
    ${current_date} =    Get Current Date    result_format=%Y-%m-%d
    ${order_substring1} =    Get Substring    ${dms_order_no}    1    5
    ${order_substring2} =    Get Substring    ${dms_order_no}    6    11
    ${order_no} =    Catenate    SEPARATOR=    ${order_substring1}    ${order_substring2}
    ${order_no} =    Catenate    SEPARATOR=    SWQA    ${order_no}
    Scooteroutbound Post    ${current_date}    ${scooter_vin}    ${order_no}    ${company_department_code}    ${SALES_PORTAL_DMS_KEY_ONE}    scooter_model=${scooter_model}

# -------- Verify Keywords --------
Verify All Scooter Pairing Response
    [Documentation]    Check all scooter pairing response as expected
    [Arguments]    ${resp}
    Should Be Equal As Strings    斯酷德有限公司    ${resp['Data']['List'][0]['CompanyName']}
    Should Be Equal As Strings    9    ${resp['Data']['List'][0]['TotalCount']}
    
Verify Scooter Pairing Response By Company
    [Documentation]    Check scooter pairing response with company id as expected
    [Arguments]    ${resp}
    Should Be Equal As Strings    斯酷德有限公司    ${resp['Data']['List'][0]['CompanyName']}
    Should Be Equal As Strings    9    ${resp['Data']['TotalCount']}
