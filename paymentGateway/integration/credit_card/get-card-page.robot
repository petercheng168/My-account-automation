*** Settings ***
Documentation    Test suite of get a page for binding credit card from bank
Resource    ../../init.robot

Force Tags    PaymentGateway - CreditCard - Get Card Page
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Get card page - empty - without authorization token and informations: OrderNo, MemberId, PaymentType, SuccessUrl and FailUrl
    ${resp} =    Get Card Page    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Get card page - empty - without authorization token
    ${resp} =    Get Card Page    ${order_no}    ${member_id}    ${credit_card_payment_type}    ${success_url}    ${fail_url}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Get card page - empty - without OrderNo
    ${resp} =    Get Card Page    ${EMPTY}    ${member_id}    ${credit_card_payment_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    OrderNo invalid

Get card page - empty - without MemberId
    ${resp} =    Get Card Page    ${order_no}    ${EMPTY}    ${credit_card_payment_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    MemberId invalid

Get card page - empty - without PaymentType
    ${resp} =    Get Card Page    ${order_no}    ${member_id}    ${EMPTY}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    PaymentType invalid

Get card page - empty - without SuccessUrl
    ${resp} =    Get Card Page    ${order_no}    ${member_id}    ${credit_card_payment_type}    ${EMPTY}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    SuccessUrl invalid

Get card page - empty - without FailUrl
    ${resp} =    Get Card Page    ${order_no}    ${member_id}    ${credit_card_payment_type}    ${success_url}    ${EMPTY}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    FailUrl invalid

Get card page - invalid - with incorrect OrderNo: higher than maxLength
    ${resp} =    Get Card Page    ${higher_order_no}    ${member_id}    ${credit_card_payment_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    2014
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    訂單編號長度異常

Get card page - invalid - with incorrect OrderNo: integer OrderNo
    ${resp} =    Get Card Page    ${incorrect_order_no}    ${member_id}    ${credit_card_payment_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    OrderNo invalid

Get card page - invalid - with incorrect PaymentType: non-exist PaymentType
    ${resp} =    Get Card Page    ${order_no}    ${member_id}    ${incorrect_payment_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    PaymentType invalid

Get card page - invalid - with incorrect MemberId: non-exist MemberId
    ${resp} =    Get Card Page    ${order_no}    ${incorrect_member_id}    ${credit_card_payment_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    MemberId invalid, get user data from Go-platform failed, undefined

Get card page - valid - with correct information: bank account payment type
    ${resp} =    Get Card Page    ${order_no}    ${member_id}    ${bank_account_payment_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    PaymentType invalid: Account Link has not been applied.

Get card page - valid - with correct information: credit card payment type
    ${resp} =    Get Card Page    ${order_no}    ${member_id}    ${credit_card_payment_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    credit_card.json    getCardPage    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    1
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    1000
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    交易成功
    Check Bind Card URL Redirect    pg_correct_info    ${resp.json()}    ${resp.status_code}    card_auth_url    gogoro
    Sleep    1
    [Teardown]  Unbinding Credit Card Process    ${auth}

*** Keywords ***
Suite Setup
    ${order_no} =    Evaluate    str(int(time.time()))   time
    ${incorrect_order_no} =    Evaluate    int(time.time())   time
    ${higher_order_no} =    Generate Random String    51    [NUMBERS]
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    ${auth} =    App Cipher Get    account=${null}
    ${credit_card_payment_type} =    Convert To Integer  1
    ${bank_account_payment_type} =    Convert To Integer  2
    ${incorrect_payment_type} =    Convert To Integer  3
    Set Suite Variable    ${order_no}
    Set Suite Variable    ${incorrect_order_no}
    Set Suite Variable    ${higher_order_no}
    Set Suite Variable    ${member_id}
    Set Suite Variable    ${incorrect_member_id}    m4wP3AEZ
    Set Suite Variable    ${auth}
    Set Suite Variable    ${credit_card_payment_type}
    Set Suite Variable    ${bank_account_payment_type}
    Set Suite Variable    ${incorrect_payment_type}
    Set Suite Variable    ${success_url}    https://www.gogoro.com
    Set Suite Variable    ${fail_url}    https://www.facebook.com
