*** Settings ***
Documentation    Test suite of Get the status of the credit card
Resource    ../../init.robot

Force Tags    PaymentGateway - CreditCard - Credit Card List
Suite Setup    Suite Setup
Suite Teardown  Unbinding Credit Card Process    ${auth}
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Credit card list - empty - without authorization token and informations: BankCode and MemberId
    ${resp} =    Credit Card List     ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Credit card list - empty - without authorization token
    ${resp} =    Credit Card List     ${PAYMENT_GATEWAY_BANK_CODE}    ${member_id}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Credit card list - empty - without BankCode
    ${resp} =    Credit Card List     ${EMPTY}    ${member_id}    ${auth}
    Verify Schema    credit_card.json    creditCardList    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    BankCode invalid

Credit card list - empty - without MemberId
    ${resp} =    Credit Card List     ${PAYMENT_GATEWAY_BANK_CODE}    ${EMPTY}    ${auth}
    Verify Schema    credit_card.json    creditCardList    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    MemberId invalid

Credit card list - invalid - with incorrect BankCode: non-exist BankCode
    ${resp} =    Credit Card List     ${incorrect_bank_code}    ${member_id}    ${auth}
    Verify Schema    credit_card.json    creditCardList    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    BankCode invalid

Credit card list - invalid - with incorrect MemberId: non-exist MemberId
    ${resp} =    Credit Card List     ${PAYMENT_GATEWAY_BANK_CODE}    ${incorrect_member_id}    ${auth}
    Verify Schema    credit_card.json    creditCardList    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    交易成功
    Should Be Equal As Strings    ${resp.json()['ResultData']}    []

Credit card list - valid - with correct information
    ${resp} =    Credit Card List     ${PAYMENT_GATEWAY_BANK_CODE}    ${member_id}    ${auth}
    Verify Schema    credit_card.json    creditCardList    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    交易成功
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['BankNo']}    ${PAYMENT_GATEWAY_BANK_CODE}
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['CardNumber']}    414763******0306
    Should Contain    ${resp.json()['ResultData'][0]['CardName']}    ${PAYMENT_GATEWAY_CARD_NAME}
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['ExpDate']}    ${PATMENT_GATEWAY_CREDIT_CARD_EXPIRED_DATE}
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['CardType']}    1
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['CardStatus']}    1
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['PaymentType']}    04
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['AvailableAmount']}    0

*** Keywords ***
Suite Setup
    ${order_no} =    Evaluate    str(int(time.time()))   time
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    ${integer_bank_code} =    Convert To Integer  ${PAYMENT_GATEWAY_BANK_CODE}
    ${higher_order_no} =    Generate Random String    51    [NUMBERS]
    ${auth} =    App Cipher Get    account=${null}
    Binding Credit Card Process    ${auth}
    Set Suite Variable    ${order_no}
    Set Suite Variable    ${member_id}
    Set Suite Variable    ${incorrect_member_id}    m4wP3AEZ
    Set Suite Variable    ${incorrect_bank_code}    000
    Set Suite Variable    ${higher_order_no}
    Set Suite Variable    ${auth}