*** Settings ***
Documentation    Test suite of parts
Resource    ../init.robot


Force Tags    Parts Price
Test Setup    Setup Parts Variable
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
part price - post - create part price 
    ${create_parts_resp} =    Create Part    ${Part}
    ${part_code}    Set Variable    ${create_parts_resp.json()['data'][0]['part_code']}
    ${create_parts_price_resp} =    Parts Prices Post   part_code=${part_code}  price_type=1  amount=1000  currency=TWD

    Verify Status Code As Expected    ${create_parts_price_resp}    200
    Verify Response Contains Expected    ${create_parts_price_resp.json()['data'][0]['part_code']}    ${part_code}
    Verify Response Contains Expected    ${create_parts_price_resp.json()['data'][0]['currency']}     TWD

part price - post - create part price error
    [Tags]    FET
    [Setup]    Test Setup For Parts Prices
    [Template]    Verify Parts Prices Create Error Message
    ABC    2    Unable to find the parts     part_code=ABC  price_type=1  amount=1000  currency=TWD
    ${part_code}    3    price_type must be in 1 2 3 4 5     part_code=${part_code}  price_type=10  amount=1000  currency=TWD
    ${part_code}    2    Unable to find the currency code    part_code=${part_code}  price_type=1  amount=1000  currency=ABC
    ${part_code}    2    The currency code cannot be NULL    part_code=${part_code}  price_type=1  amount=1000                                                       
    ${part_code}    2    All the price parameters have NULL values    part_code=${part_code}  price_type=1  currency=TWD      

part price - update - update part price 
    ${create_parts_resp} =    Create Part    ${Part}
    ${part_code}    Set Variable    ${create_parts_resp.json()['data'][0]['part_code']}
    ${create_parts_price_resp} =    Parts Prices Update   part_code=${part_code}  price_type=1  amount=1000  currency=TWD

    Verify Status Code As Expected    ${create_parts_price_resp}    200
    Verify Response Contains Expected    ${create_parts_price_resp.json()['data'][0]['part_code']}    ${part_code}
    Verify Response Contains Expected    ${create_parts_price_resp.json()['data'][0]['currency']}     TWD

part price - update - update part price error
    [Tags]    FET
    [Setup]    Test Setup For Parts Prices
    [Template]    Verify Parts Prices Update Error Message
    ABC    2    Unable to find the parts     part_code=ABC  price_type=1  amount=1000  currency=TWD
    ${part_code}-TWD    3    price_type must be in 1 2 3 4 5     part_code=${part_code}  price_type=10  amount=1000  currency=TWD
    ${part_code}    2    Unable to find the currency code    part_code=${part_code}  price_type=1  amount=1000  currency=ABC
    ${part_code}    2    The currency code cannot be NULL    part_code=${part_code}  price_type=1  amount=1000                                                       
    ${part_code}    2    All the price parameters have NULL values    part_code=${part_code}  price_type=1  currency=TWD                                              
    
*** Keywords ***
Setup Parts Variable
    Setup Parts Operation Sequence Id
    Setup Parts Category Type
    Setup Parts Sale Status
    Setup Parts Valid Names
    Setup Parts Invalid Names
    Setup Parts Valid And Invalid Prices
    Setup Parts 
    
Setup Parts Operation Sequence Id
    # Sequence Id
    ${random_sequence_id} =    Generate Random String    6    [NUMBERS] 
    ${sequence_id} =    Catenate    SEPARATOR=    SWQA    ${random_sequence_id}
    Set Test Variable    ${sequence_id}

Setup Parts Category Type 
    # Part Type Generate Random String
    ${part_category_type} =     Generate Random String    1    1234 
    Set Test Variable    ${part_category_type}

Setup Parts Sale Status
    # Sale Status Generate Random String
    ${sale_status} =     Generate Random String    1    123
    Set Test Variable    ${sale_status}

Setup Parts Valid Names
    # Valid Names
    &{name1} =    Create Dictionary   lang=en-US    value=Part English Name
    &{name2} =    Create Dictionary   lang=zh-TW    value=料件
    ${names} =    Create List    ${name1}    ${name2}
    Set Test Variable    ${names}

Setup Parts Invalid Names
    # Invalid Names
    &{name_wrong_lang} =    Create Dictionary   lang=en-UU    value=Part English Name
    ${names_wrong} =    Create List    ${name_wrong_lang}
    Set Test Variable    ${names_wrong}

Setup Parts Valid And Invalid Prices
    # Valid Price
    ${price_type_1_twd} =    Create Dictionary    part_code=A    price_type=1    amount=100    currency=TWD
    ${price_type_2_twd} =    Create Dictionary    part_code=A    price_type=2    amount=200    currency=TWD
    ${price_type_3_twd} =    Create Dictionary    part_code=A    price_type=3    amount=300    currency=TWD
    ${price_type_4_twd} =    Create Dictionary    part_code=A    price_type=4    amount=400    currency=TWD
    ${price_type_5_twd} =    Create Dictionary    part_code=A    price_type=5    amount=500    currency=TWD

    ${price_type_1_usd} =    Create Dictionary    part_code=A    price_type=1    amount=10    currency=USD
    ${price_type_2_usd} =    Create Dictionary    part_code=A    price_type=2    amount=20    currency=USD
    ${price_type_3_usd} =    Create Dictionary    part_code=A    price_type=3    amount=30    currency=USD
    ${price_type_4_usd} =    Create Dictionary    part_code=A    price_type=4    amount=40    currency=USD
    ${price_type_5_usd} =    Create Dictionary    part_code=A    price_type=5    amount=50    currency=USD

    # Invalid Price
    ${price_type_1_abc} =    Create Dictionary    part_code=A    price_type=1    amount=100    currency=ABC
    ${price_type_1_no_currency} =    Create Dictionary    part_code=A    price_type=1    amount=100    

    # Valid Prices
    ${prices} =    Create List    ${price_type_1_twd}    ${price_type_2_twd}    ${price_type_3_twd}    ${price_type_4_twd}    ${price_type_5_twd}    ${price_type_1_usd}    ${price_type_2_usd}    ${price_type_3_usd}    ${price_type_4_usd}    ${price_type_5_usd}

    # Invalid Prices
    ${prices_lack_price_type2} =    Create List    ${price_type_1_twd}
    ${prices_lack_price_type3} =    Create List    ${price_type_1_twd}    ${price_type_2_twd}
    ${prices_lack_price_type4} =    Create List    ${price_type_1_twd}    ${price_type_2_twd}     ${price_type_3_twd}
    ${prices_lack_price_type5} =    Create List    ${price_type_1_twd}    ${price_type_2_twd}     ${price_type_3_twd}    ${price_type_4_twd}
    ${prices_invalid_currency} =    Create List    ${price_type_1_abc}
    ${prices_no_currency} =    Create List    ${price_type_1_no_currency}

    Set Test Variable    ${prices}
    Set Test Variable    ${prices_lack_price_type2}
    Set Test Variable    ${prices_lack_price_type3}
    Set Test Variable    ${prices_lack_price_type4}
    Set Test Variable    ${prices_lack_price_type5}
    Set Test Variable    ${prices_invalid_currency}
    Set Test Variable    ${prices_no_currency}

Setup Parts
    Set Test Variable    ${Part}    ${Parts(${part_category_type}, ${names}, ${prices})}

Verify Parts Prices Create Error Message
    [Arguments]    ${key}    ${error_code}    ${err_msg}=${None}    &{fields}
    ${resp} =    Parts Prices Post    &{fields}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['key']}                ${key}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['code']}               ${error_code}
    Should Contain                       ${resp.json()['error_list'][0]['message']}            ${err_msg}

Verify Parts Prices Update Error Message
    [Arguments]    ${key}    ${error_code}    ${err_msg}=${None}    &{fields}
    ${resp} =    Parts Prices Update    &{fields}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['key']}                ${key}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['code']}               ${error_code}
    Should Contain                       ${resp.json()['error_list'][0]['message']}            ${err_msg}

Test Setup For Parts Prices 
    Setup Parts Variable
    ${resp} =    Create Part    ${Part}
    ${part_code}    Set Variable    ${resp.json()['data'][0]['part_code']}
    ${part_id}    Set Variable    ${resp.json()['data'][0]['part_id']}
    Set Test Variable    ${part_code}
    Set Test Variable    ${part_id}

