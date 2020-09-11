*** Settings ***
Documentation    Test suite of charges the transaction by the synchronous method
Resource    ../../init.robot

Force Tags    PaymentGateway - Internal - Credit Card Sync Transaction Charges
Suite Setup    Suite Setup
Test Setup    Init Bill Info
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Sync transaction charges - empty - without authorization token and all informations
    ${resp} =    Sync Transaction Charges    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ...    ${EMPTY}    ${EMPTY}    token=${EMPTY}    tokenType=${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Sync transaction charges - empty - without authorization token
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${EMPTY}
    ...    token=${token}    tokenType=${token_type}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Sync transaction charges - empty - without transactionId
    ${resp} =    Sync Transaction Charges    ${EMPTY}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionId, should NOT be shorter than 1 characters

Sync transaction charges - empty - without transactionType
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${EMPTY}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionType, should be integer

Sync transaction charges - empty - without paySourceAccountId
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${EMPTY}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceAccountId, should NOT be shorter than 1 characters

Sync transaction charges - empty - without payTargetAccountId
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${EMPTY}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetAccountId, should NOT be shorter than 1 characters

Sync transaction charges - empty - without paySourceType
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${EMPTY}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceType, should be integer

Sync transaction charges - empty - without payTargetType
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${EMPTY}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetType, should be integer

Sync transaction charges - empty - without amount
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${EMPTY}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.amount, should NOT be shorter than 1 characters

Sync transaction charges - empty - without token
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${EMPTY}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.token, should NOT be shorter than 1 characters

Sync transaction charges - empty - without tokenType
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${EMPTY}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.tokenType, should be equal to one of the allowed values

Sync transaction charges - invalid - with incorrect transactionId: non-exist ES bill ID
    ${resp} =    Sync Transaction Charges    ${incorrect_transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    200-internal
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80004
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Write off failed

Sync transaction charges - invalid - with duplicate transactionId
    ${resp} =    Sync Transaction Charges    ${duplicate_transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    200-external
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['additionalCode']}    2011
    Should Be Equal As Strings    ${resp.json()['additionalMessage']}    訂單編號重複

Sync transaction charges - invalid - with incorrect transactionType: non-exist transactionType
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${incorrect_transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionType, should be equal to one of the allowed values

# Now has a bug: PMGW-178
Sync transaction charges - invalid - with incorrect paySourceAccountId: non-exist user id
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${incorrect_pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    MemberId invalid, get user data from Go-platform failed, undefined

Sync transaction charges - invalid - with incorrect payTargetAccountId
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${incorrect_pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}   Invalid payTargetAccountId, should be equal to one of the allowed values

Sync transaction charges - invalid - with incorrect paySourceType
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${incorrect_pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceType, should be equal to one of the allowed values

Sync transaction charges - invalid - with incorrect payTargetType
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${incorrect_pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetType, should be equal to one of the allowed values

Sync transaction charges - invalid - with incorrect amount: amount = 0
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${zero_amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.amount, should NOT be valid

Sync transaction charges - invalid - with incorrect token
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${incorrect_token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    200-external
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['additionalCode']}    1010
    Should Be Equal As Strings    ${resp.json()['additionalMessage']}    請重新操作

Sync transaction charges - invalid - with incorrect tokenType
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${incorrect_token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.tokenType, should be equal to one of the allowed values

Sync transaction charges - valid - with overcharge amount: amount = 70
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${overcharge_amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    200-internal
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Success

Sync transaction charges - valid - with correct amount: amount = 60
    ${resp} =    Sync Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${auth}
    ...    token=${token}    tokenType=${token_type}
    Verify Schema    internal.json    syncTransactionCharges    ${resp.json()}    200-internal
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Success

*** Keywords ***
Init Bill Info
    Payment Gateway Test Data Setup    1    5    new_user
    ${es_bill_info} =    Get ES Bill Info
    Set Test Variable    ${transaction_id}    ${es_bill_info['es_bill_id']}

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    ${wallet_resp} =    Get Wallets Information From User    ${auth}    ${member_id}
    ${time} =    Evaluate    str(int(time.time()))   time
    ${incorrect_transaction_id} =    Encode Hashid    ${time}
    Set Suite Variable    ${auth}
    Set Suite Variable    ${incorrect_transaction_id}
    Set Suite Variable    ${duplicate_transaction_id}    EmDl7v3m
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
    Set Suite Variable    ${amount}    60
    Set Suite Variable    ${zero_amount}    0
    Set Suite Variable    ${overcharge_amount}    70
    Set Suite Variable    ${token_type}    1
    Set Suite Variable    ${incorrect_token_type}    2
    Set Suite Variable    ${token}    ${wallet_resp.json()['data'][0]['credit_cards'][0]['token']}
    Set Suite Variable    ${incorrect_token}    1234abcd-1234-abcd-1234-545c8eb19f33_0457612837465813