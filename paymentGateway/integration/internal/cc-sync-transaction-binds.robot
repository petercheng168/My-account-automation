*** Settings ***
Documentation    Test suite of cancel the credit card binding by the synchronous method
Resource    ../../init.robot

Force Tags    PaymentGateway - Internal - Credit Card Sync Transaction Binds
Suite Setup    Suite Setup
Test Setup    Init Transaction ID
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Credit card sync transaction binds - empty - without authorization token and all informations
    ${resp} =    Sync Transaction Binds    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ...    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Credit card sync transaction binds - empty - without authorization token
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Credit card sync transaction binds - empty - without transactionId
    ${resp} =    Sync Transaction Binds    ${EMPTY}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionId, should NOT be shorter than 1 characters

Credit card sync transaction binds - empty - without transactionType
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${EMPTY}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionType, should be integer

Credit card sync transaction binds - empty - without paySourceAccountId
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${EMPTY}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceAccountId, should NOT be shorter than 1 characters

Credit card sync transaction binds - empty - without payTargetAccountId
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${EMPTY}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetAccountId, should NOT be shorter than 1 characters

Credit card sync transaction binds - empty - without paySourceType
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${EMPTY}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceType, should be integer

Credit card sync transaction binds - empty - without payTargetType
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${EMPTY}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetType, should be integer

Credit card sync transaction binds - empty - without creditCardId
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${EMPTY}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.creditCardId, should NOT be shorter than 1 characters

Credit card sync transaction binds - empty - without walletId
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${EMPTY}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.walletId, should NOT be shorter than 1 characters

Credit card sync transaction binds - invalid - with duplicate transactionId
    ${resp} =    Sync Transaction Binds    ${duplicate_transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    12001
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    The orderNo is duplicate

Credit card sync transaction binds - invalid - with incorrect transactionType: non-exist transactionType
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${incorrect_transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionType, should be equal to one of the allowed values

Credit card sync transaction binds - invalid - with incorrect paySourceAccountId: non-exist user id
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${incorrect_pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    11000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    The credit card is invalid

Credit card sync transaction binds - invalid - with incorrect payTargetAccountId
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${incorrect_pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetAccountId, should be equal to one of the allowed values

Credit card sync transaction binds - invalid - with incorrect paySourceType
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${incorrect_pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceType, should be equal to one of the allowed values

Credit card sync transaction binds - invalid - with incorrect payTargetType
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${incorrect_pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetType, should be equal to one of the allowed values

Credit card sync transaction binds - invalid - with incorrect creditCardId
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${incorrect_credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    81001
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Credit card not found in Gobank wallet

Credit card sync transaction binds - invalid - with incorrect walletId
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${incorrect_wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80005
    Should Contain    ${resp.json()['resultMessage']}    Get credit card info from go-wallet failed

Credit card sync transaction binds - valid - with correct information
    ${resp} =    Sync Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}    ${pay_target_account_id}
    ...    ${pay_source_type}    ${pay_target_type}    ${credit_card_id}    ${wallet_id}    ${auth}
    Verify Schema    internal.json    syncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Success

*** Keywords ***
Init Transaction ID
    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    Set Test Variable    ${transaction_id}

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    ${wallet_resp} =    Get Wallets Information From User   ${auth}    ${member_id}
    Set Suite Variable    ${auth}
    Set Suite Variable    ${duplicate_transaction_id}    1000000000
    Set Suite Variable    ${transaction_type}    ${101}
    Set Suite Variable    ${incorrect_transaction_type}    ${201}
    Set Suite Variable    ${incorrect_member_id}    m4wP3AEZ
    Set Suite Variable    ${pay_source_account_id}    ${member_id}
    Set Suite Variable    ${incorrect_pay_source_account_id}    ${incorrect_member_id}
    Set Suite Variable    ${pay_target_account_id}    1
    Set Suite Variable    ${incorrect_pay_target_account_id}    4
    Set Suite Variable    ${pay_source_type}    ${1}
    Set Suite Variable    ${incorrect_pay_source_type}    ${3}
    Set Suite Variable    ${pay_target_type}    ${2}
    Set Suite Variable    ${incorrect_pay_target_type}    ${3}
    Set Suite Variable    ${credit_card_id}    ${wallet_resp.json()['data'][0]['credit_cards'][0]['credit_card_id']}
    Set Suite Variable    ${incorrect_credit_card_id}    mknD6QYb
    Set Suite Variable    ${wallet_id}    ${wallet_resp.json()['data'][0]['credit_cards'][0]['wallet_id']}
    Set Suite Variable    ${incorrect_wallet_id}    R0AZGEZ5
