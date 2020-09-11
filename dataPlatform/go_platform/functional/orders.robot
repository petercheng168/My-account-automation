*** Settings ***
Documentation    Test suite of orders
Resource    ../init.robot

Force Tags    Orders
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
orders - get - get order with scooter type and dms_order_no 
    ${resp} =    Orders Get    order_type=scooter    dms_order_no=P1910D00393
    Verify Status Code As Expected       ${resp}                                              200
    Verify Response Contains Expected    ${resp.json()['data'][0]['delivery_by_emp_code']}    QA00003
    Verify Response Contains Expected    ${resp.json()['data'][0]['delivery_by_emp_name']}    dev QAgss.user


orders - get - invalid - get order with null requried fields
    [Tags]    FET
    [Template]    Verify Orders Post With Invalid Fields                                                                                                  
    402010006     must not be null    order_type=None


orders - get - invalid - get order with invalid requried fields        
    [Tags]    FET
    [Template]    Verify Orders Post With Invalid Fields 
    402010006     [getData.type]]; default message [must not be null]]    order_type=INVALID    dms_order_no=P1910D00393
    803010003     decode failed                                           order_type=scooter    order_id=12345 
    402010006     must be greater than or equal to 0                      order_type=scooter    create_time_from=-1
    402010006     must be greater than or equal to 0                      order_type=scooter    create_time_to=-1
    402010006     must be greater than or equal to 0                      order_type=scooter    promise_delivery_date_from=-1
    402010006     must be greater than or equal to 0                      order_type=scooter    promise_delivery_date_to=-1
    402010006     must be greater than or equal to 0                      order_type=scooter    payment_complete=-1
    402010006     must be less than or equal to 1                         order_type=scooter    payment_complete=2
    402010006     must be greater than or equal to 0                      order_type=scooter    status=-1
    #402010006     must be less than or equal to 1                                           order_type=scooter    status=2
    

*** Keywords ***
Verify Orders Post With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Orders Get    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}