*** Settings ***
Documentation    Test suite of parts

Library      ../api/LibParts.py
Resource    ../init.robot

Force Tags    Part
Test Setup    Setup Parts Variable
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
part - post - valid - create part with sequence_id
    ${resp} =    Create Part    ${Part}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()['sequence_id']}             ${Part.sequence_id}
    Verify Response Contains Expected    ${resp.json()['data'][0]['part_code']}    ${Part.part_code}

part - post - invalid - create part with invalid fields
    #key of error object is actually part_code
    [Tags]    FET
    [Template]    Verify Parts Add Error Message
    SWQA709394    1    Part code is duplicate               sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices}
    SWQA709394    3    type must be in 1 2 3 4              sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=5  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices}
    SWQA709394    3    sale_status must be in 1 2 3         sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=4    prices=${prices}
    SWQA709394    3    currency TWD miss of price type 2    sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_lack_price_type2}
    SWQA709394    3    currency TWD miss of price type 3    sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_lack_price_type3}
    SWQA709394    3    currency TWD miss of price type 4    sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_lack_price_type4}
    SWQA709394    3    currency TWD miss of price type 5    sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_lack_price_type5}
    SWQA709394    3    name must not be null                sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  sale_status=1
    SWQA709394    3    is not avaliable                     sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names_wrong}  sale_status=1
    SWQA709394    3    currency in price item is missed or can not be recognized         sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_invalid_currency}
    SWQA709394    3    currency in price item is missed or can not be recognized         sequence_id=${sequence_id}  part_code=SWQA709394  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_no_currency}

part - update - update part successfully
    ${create_resp} =    Create Part    ${Part}
    ${part_code}    Set Variable    ${create_resp.json()['data'][0]['part_code']}
    ${update_resp} =    Parts Update    sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=2  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices}

    Verify Response Contains Expected    ${update_resp.json()['data'][0]['part_code']}    ${part_code}

part - update - update part error
#key of error object is actually part_code
    [Tags]    FET
    [Setup]    Test Setup For Parts Update And Get
    [Template]    Verify Parts Update Error Message
    ${part_code}    3    type must be in 1 2 3 4              sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=5  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices}
    ${part_code}    3    sale_status must be in 1 2 3         sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=4    prices=${prices}
    ${part_code}    3    currency TWD miss of price type 3    sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_lack_price_type3}
    ${part_code}    3    currency TWD miss of price type 4    sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_lack_price_type4}
    ${part_code}    3    currency TWD miss of price type 5    sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_lack_price_type5}
    ${part_code}    3    name must not be null                sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=1  part_category_sub_type=0  sale_status=1
    ${part_code}    3    is not avaliable                     sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=1  part_category_sub_type=0  names=${names_wrong}  sale_status=1
    ${part_code}    3    currency in price item is missed or can not be recognized         sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_invalid_currency}
    ${part_code}    3    currency in price item is missed or can not be recognized         sequence_id=${sequence_id}  part_code=${part_code}  part_category_type=1  part_category_sub_type=0  names=${names}  sale_status=1    prices=${prices_no_currency}

part - get - get part successfully
    [Setup]    Test Setup For Parts Update And Get
    [Template]    Verify Parts Get successfully
    None          ${part_code}    part_code=${part_code}
    ${part_id}    None            part_id=${part_id}
    language_code=en-US
    language_code=zh-TW
    category_type=${part_category_type}
    category_subtype=0
    sale_status=${sale_status}

part - get - get part error
    [Tags]    FET
    [Template]    Verify Parts Get Error With Invalid Fields
    60    Both in_language_code and in_name must be given at the same time    name=Part
    60    invalid language code                                               language_code=ABC

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

Test Setup For Parts Update And Get
    Setup Parts Variable
    ${resp} =    Create Part    ${Part}
    ${part_code}    Set Variable    ${resp.json()['data'][0]['part_code']}
    ${part_id}    Set Variable    ${resp.json()['data'][0]['part_id']}
    Set Test Variable    ${part_code}
    Set Test Variable    ${part_id}

Verify Parts Add Error Message
    [Arguments]    ${key}    ${error_code}    ${err_msg}=${None}    &{fields}
    ${resp} =    Parts Post    &{fields}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['key']}                ${key}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['code']}               ${error_code}
    Should Contain                       ${resp.json()['error_list'][0]['message']}            ${err_msg}

Verify Parts Update Error Message
    [Arguments]    ${key}    ${error_code}    ${err_msg}=${None}    &{fields}
    ${resp} =    Parts Update    &{fields}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['key']}                ${key}
    Verify Response Contains Expected    ${resp.json()['error_list'][0]['code']}               ${error_code}
    Should Contain                       ${resp.json()['error_list'][0]['message']}            ${err_msg}

Verify Parts Get successfully
    [Arguments]    ${id}=${None}    ${code}=${None}    &{fields}
    ${resp} =    Parts Get    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Run Keyword Unless    '${id}'=='None'    Verify Response Contains Expected    ${resp.json()['data'][0]['part_id']}    ${id}
    Run Keyword Unless    '${code}'=='None'    Verify Response Contains Expected    ${resp.json()['data'][0]['part_code']}    ${code}
    ${data_length} =  Get Length  ${resp.json()['data']}
    Run Keyword Unless    ${data_length}==0    Verify Schema    parts.json    partsGet    ${resp.json()}

Verify Parts Get Error With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Parts Get    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}



