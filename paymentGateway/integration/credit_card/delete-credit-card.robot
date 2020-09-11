*** Settings ***
Documentation    Test suite of Get the status of the credit card
Resource    ../../init.robot

Force Tags    PaymentGateway - CreditCard - Credit Card List
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Delete credit card - empty - without authorization token and informations: BankCode, CardToken, MemberId, CreditCardId, WalletId
    ${resp} =    Delete Credit Card    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Delete credit card - empty - without authorization token
    ${resp} =    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${card_token}    ${member_id}    ${card_id}    ${wallet_id}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Delete credit card - empty - without BankCode
    ${resp} =    Delete Credit Card    ${EMPTY}    ${card_token}    ${member_id}    ${card_id}    ${wallet_id}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    BankCode invalid

Delete credit card - empty - without CardToken
    ${resp} =    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${EMPTY}    ${member_id}    ${card_id}    ${wallet_id}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    CardToken invalid

Delete credit card - empty - without MemberId
    ${resp} =    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${card_token}    ${EMPTY}    ${card_id}    ${wallet_id}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    MemberId invalid

Delete credit card - empty - without CreditCardId
    ${resp} =    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${card_token}    ${member_id}    ${EMPTY}    ${wallet_id}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    CreditCardId invalid

Delete credit card - empty - without WalletId
    ${resp} =    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${card_token}    ${member_id}    ${card_id}    ${EMPTY}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    WalletId invalid

Delete credit card - invalid - with incorrect BankCode: non-exist BankCode
    ${resp} =    Delete Credit Card    ${incorrect_bank_code}    ${card_token}    ${member_id}    ${card_id}    ${wallet_id}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    BankCode invalid

Delete credit card - invalid - with incorrect CardToken: non-exist CardToken
    ${resp} =    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${incorrect_card_token}    ${member_id}    ${card_id}    ${wallet_id}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    2001
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    卡片未授權

Delete credit card - invalid - with incorrect MemberId: non-exist MemberId
    ${resp} =    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${card_token}    ${incorrect_member_id}    ${card_id}    ${wallet_id}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    2001
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    卡片未授權

Delete credit card - valid - with correct information
    ${resp} =    Delete Credit Card    ${PAYMENT_GATEWAY_BANK_CODE}    ${card_token}    ${member_id}    ${card_id}    ${wallet_id}    ${auth}
    Verify Schema    credit_card.json    deleteCreditCard    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    1
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    Successfully

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    Binding Credit Card Process    ${auth}
    Sleep    1
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    ${wallet_id} =    Encode Hashid    ${PAYMENT_GATEWAY_WALLET_ID}
    ${credit_card_list_resp} =    Credit Card List     ${PAYMENT_GATEWAY_BANK_CODE}    ${member_id}    ${auth}
    ${credit_cards_resp} =    Get Credit Cards    ${wallet_id}    ${auth}
    Set Suite Variable    ${auth}
    Set Suite Variable    ${incorrect_bank_code}    000
    Set Suite Variable    ${member_id}
    Set Suite Variable    ${incorrect_member_id}    m4wP3AEZ
    Set Suite Variable    ${wallet_id}
    Set Suite Variable    ${card_token}    ${credit_card_list_resp.json()['ResultData'][0]['CardToken']}
    Set Suite Variable    ${incorrect_card_token}    1234abcd-1234-abcd-1234-545c8eb19f33_0457612837465813
    Set Suite Variable    ${card_id}    ${credit_cards_resp.json()['data'][0]['credit_card_id']}
