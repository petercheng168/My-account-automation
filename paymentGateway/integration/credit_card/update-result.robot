*** Settings ***
Documentation    Test suite of binding credit card from bank
Resource    ../../init.robot

Force Tags    PaymentGateway - CreditCard - Update Result
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Update result - empty - without all informations
    ${resp} =    Update Result    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ...    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Verify Schema    credit_card.json    updateResult    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['OrderNo']}    ${EMPTY}
    Should Not Be True    ${resp.json()['IsSuccess']}

Update result - invalid - with incorrect CardStatus: non-exist CardStatus
    ${resp} =    Update Result    ${trans_no}    ${credit_card_payment_type}    ${order_no}    ${member_id}
    ...    ${card_token}    ${new_card_number}    ${card_hash}    ${expired_date}    ${PAYMENT_GATEWAY_CARD_NAME}
    ...    ${incorrect_card_status}    ${card_type}    ${timestemp}
    ${log_boolean} =    Get Logs    add credit card: ${new_card_number} Successfully
    Verify Schema    credit_card.json    updateResult    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['OrderNo']}    1234
    Should Be True    ${resp.json()['IsSuccess']}
    Should Not Be True    ${log_boolean}

Update result - valid - with correct information: suspend CardStatus
    ${resp} =    Update Result    ${trans_no}    ${credit_card_payment_type}    ${order_no}    ${member_id}
    ...    ${card_token}    ${new_card_number}    ${card_hash}    ${expired_date}    ${PAYMENT_GATEWAY_CARD_NAME}
    ...    ${suspend_card_status}    ${card_type}    ${timestemp}
    ${log_boolean} =    Get Logs    add credit card: ${new_card_number} Successfully
    Verify Schema    credit_card.json    updateResult    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['OrderNo']}    1234
    Should Be True    ${resp.json()['IsSuccess']}
    Should Not Be True    ${log_boolean}

Update result - valid - with correct information: invalid CardStatus
    ${resp} =    Update Result    ${trans_no}    ${credit_card_payment_type}    ${order_no}    ${member_id}
    ...    ${card_token}    ${new_card_number}    ${card_hash}    ${expired_date}    ${PAYMENT_GATEWAY_CARD_NAME}
    ...    ${invalid_card_status}    ${card_type}    ${timestemp}
    ${log_boolean} =    Get Logs    add credit card: ${new_card_number} Successfully
    Verify Schema    credit_card.json    updateResult    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['OrderNo']}    1234
    Should Be True    ${resp.json()['IsSuccess']}
    Should Not Be True    ${log_boolean}

Update result - valid - with correct information: account link PaymentType
    ${resp} =    Update Result    ${trans_no}    ${account_link_payment_type}    ${order_no}    ${member_id}
    ...    ${card_token}    ${new_card_number}    ${card_hash}    ${expired_date}    ${PAYMENT_GATEWAY_CARD_NAME}
    ...    ${in_use_card_status}    ${card_type}    ${timestemp}
    ${log_boolean} =    Get Logs    add credit card: ${new_card_number} Successfully
    Verify Schema    credit_card.json    updateResult    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['OrderNo']}    1234
    Should Be True    ${resp.json()['IsSuccess']}
    Should Not Be True    ${log_boolean}

Update result - valid - with correct information: existed credit card
    [Setup]  Delete Credit Card    ${member_id}    ${wallet_id}    ${existed_card_number}
    ${resp} =    Update Result    ${trans_no}    ${credit_card_payment_type}    ${order_no}    ${member_id}
    ...    ${card_token}    ${existed_card_number}    ${card_hash}    ${expired_date}    ${PAYMENT_GATEWAY_CARD_NAME}
    ...    ${in_use_card_status}    ${card_type}    ${timestemp}
    ${log_boolean} =    Get Logs    add credit card: ${existed_card_number} Successfully
    Verify Schema    credit_card.json    updateResult    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['OrderNo']}    1234
    Should Be True    ${resp.json()['IsSuccess']}
    Should Be True    ${log_boolean}

Update result - valid - with correct information: new credit card
    ${resp} =    Update Result    ${trans_no}    ${credit_card_payment_type}    ${order_no}    ${member_id}
    ...    ${card_token}    ${new_card_number}    ${card_hash}    ${expired_date}    ${PAYMENT_GATEWAY_CARD_NAME}
    ...    ${in_use_card_status}    ${card_type}    ${timestemp}
    ${log_boolean} =    Get Logs    add credit card: ${new_card_number} Successfully
    Verify Schema    credit_card.json    updateResult    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['OrderNo']}    1234
    Should Be True    ${resp.json()['IsSuccess']}
    Should Be True    ${log_boolean}
    [Teardown]  Delete Credit Card    ${member_id}    ${wallet_id}    ${new_card_number}

*** Keywords ***
Suite Setup
    ${current_day} =    Get Current Date    result_format=%Y%m%d
    ${random} =    Generate Random String    10    [NUMBERS]
    ${trans_no} =    Catenate    GR${current_day}${random}
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_CHECK_MEMBER_ID}
    ${card_hash} =    Encode Text With Base64    ${member_id}    sha256
    ${auth} =    App Cipher Get    account=${null}
    ${timestemp} =    Evaluate    str(int(time.time()))   time
    ${wallet_id} =    Encode Hashid    ${PAYMENT_GATEWAY_CHECK_WALLET_ID}
    ${new_card_number} =    Generate Random Credit Card
    Set Suite Variable    ${trans_no}
    Set Suite Variable    ${credit_card_payment_type}    04
    Set Suite Variable    ${account_link_payment_type}    03
    Set Suite Variable    ${order_no}    1234
    Set Suite Variable    ${member_id}
    Set Suite Variable    ${card_token}    test_update_result
    Set Suite Variable    ${existed_card_number}    123456******7890
    Set Suite Variable    ${new_card_number}
    Set Suite Variable    ${card_hash}
    Set Suite Variable    ${expired_date}    3412
    Set Suite Variable    ${in_use_card_status}    1
    Set Suite Variable    ${suspend_card_status}    2
    Set Suite Variable    ${invalid_card_status}    3
    Set Suite Variable    ${incorrect_card_status}    4
    Set Suite Variable    ${card_type}    1
    Set Suite Variable    ${timestemp}
    Set Suite Variable    ${wallet_id}
    Set Suite Variable    ${auth}

Delete Credit Card
    [Arguments]    ${member_id}    ${wallet_id}    ${card_number}
    Get Credit Card And Delete    ${member_id}    ${wallet_id}    ${card_number}


