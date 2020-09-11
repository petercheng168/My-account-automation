*** Keywords ***
# -------- Gogoro Keywords --------
Generate Random Bill Period
    [Documentation]    Generate random es bill period
    ${random_year} =     Evaluate    random.randint(1900, 2020)             random
    ${random_month} =    Evaluate    format(random.randint(1, 12), '02')    random
    ${bill_period} =     Set Variable    ${random_year}-${random_month}
    [Return]    ${bill_period}

Generate Random UUID
    [Documentation]    Generate random uuid via python
    ${uuid} =    Evaluate    str(uuid.uuid4())    uuid
    [Return]    ${uuid}

Generate SWQA Random String
    [Documentation]    Generate swqa testing random string.
    [Arguments]    ${length}
    ${length} =      Convert To Integer        ${length}
    ${rand_str} =    Generate Random String    ${length-5}    [NUMBERS]
    [Return]    SWQA_${rand_str}

Should Be Equal As Strings
    [Documentation]    Build in compare two variables keyword with log
    [Arguments]    ${resp}    ${message}
    BuiltIn.Should Be Equal As Strings    ${resp}    ${message}    msg=Response: Actual result: ${resp} != Expected result: ${message}    values=False

Should Be Greater Than
    [Arguments]    ${value}    ${expected}
    Run Keyword If    ${value} <= ${expected}
    ...    Fail    The value ${expected} is not Greater than ${value}

Should Contain
    [Documentation]    Build in compare two variables keyword with log
    [Arguments]    ${resp}    ${message}
    BuiltIn.Should Contain    ${resp}    ${message}    msg=Response: Actual result: ${resp} != Expected result: ${message}    values=False

Update Scooter Contract To Delivery Approval Status
    [Documentation]    Update the scooter contract to delivery approval status (DA)
    ...                Order's order_id, owner_id shouldn't is None.
    [Arguments]    ${Order}    ${Scooter}    ${User}    ${sport_mode}=0
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    0    turn_light=1    brake_light=1    tpms=0    sport_mode=${sport_mode}
    Orders Update    ${Order.order_id}    VEH_SALE_CR    ${Order.order_no}    ${NONE}    ${User.user_id}    30004    1    delivery_place=ES313020
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    2    turn_light=1    brake_light=1    tpms=0    sport_mode=${sport_mode}
    Scooters Infos Update    ${Order.order_no}    ${Scooter.vin}    ${User.user_id}    ${Order.owner_id}    ${User.gogoro_guid}    3    turn_light=1    brake_light=1    tpms=0    sport_mode=${sport_mode}
    Orders Update    ${Order.order_id}    VEH_SALE_CR    ${Order.order_no}    R    ${User.user_id}    50001    1    plate=${Scooter.plate}    plate_date=${Scooter.plate_date}
    Orders Update    ${Order.order_id}    VEH_SALE_CR    ${Order.order_no}    DA    ${User.user_id}    50001    1

Should Not Be Equal As None
    [Documentation]    Build in compare variables keyword with None
    [Arguments]    ${resp}
    BuiltIn.Should Not Be Equal    ${resp}    ${None}    msg=Response: Actual result: ${resp} == Expected result: ${None}    values=False

# -------- Verify Keywords --------
Verify GoPlatform Error Message
    [Arguments]    ${resp}    ${error_code}    ${err_msg}
    Verify Response Contains Expected    ${resp.json()['code']}               -1
    Verify Response Contains Expected    ${resp.json()['additional_code']}    ${error_code}
    Should Contain                       ${resp.json()['message']}            ${err_msg}

Verify GoPlatform Partial Error Message
    [Arguments]    ${resp}    ${error_code}    ${err_msg}    ${idx}=0
    Verify Response Contains Expected    ${resp.json()['code']}                       -1
    Verify Response Contains Expected    ${resp.json()["data"][${idx}]["code"]}       ${error_code}
    Should Contain                       ${resp.json()["data"][${idx}]["message"]}    ${err_msg}

Verify Status Code As Expected
    [Documentation]    Verify Status Code As Expected
    [Arguments]    ${resp}    ${code}
    Should Be Equal As Strings    ${resp.status_code}    ${code}

Verify Response Contains Expected
    [Documentation]    Verify response message should be equals expected
    [Arguments]    ${resp}    ${message}
    Should Be Equal As Strings    ${resp}    ${message}

Verify Response Json Data As Expected
    [Documentation]    Verify response json()['data'] should be equals expected
    [Arguments]    ${resp}    ${key}    ${expected}    ${index}=${0}
    Should Be Equal As Strings    ${resp.json()['data'][${index}]['${key}']}    ${expected}

Verify Response Data Length Expected
    [Documentation]    Verify response message json data's length
    [Arguments]    ${data}    ${expected_len}
    ${len} =    Get Length    ${data}
    Should Be Equal As Numbers    ${len}    ${expected_len}

Verify Response Json Data Should Contains Key
    [Documentation]    Verify response json()['data'] should be equals expected
    [Arguments]    ${resp}    ${expected_key}    ${index}=${0}
    Dictionary Should Contain Key    ${resp.json()['data'][${index}]}    ${expected_key}

Verify Response Should Contains Key
    [Documentation]    Verify response message should be contain expected key
    [Arguments]    ${resp}    ${expected_key}
    Dictionary Should Contain Key    ${resp}    ${expected_key}

Verify Response Data Not None
    [Documentation]    Verify response should not be None
    [Arguments]    ${resp}
    Should Not Be Equal As None    ${resp}