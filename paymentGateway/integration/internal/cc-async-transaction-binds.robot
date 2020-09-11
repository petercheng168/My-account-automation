*** Settings ***
Documentation    Test suite of binds the credit card by the asynchronous method
Resource    ../../init.robot

Force Tags    PaymentGateway - Internal - Credit Card Async Transaction Binds
Suite Setup    Suite Setup
Test Setup    Init Transaction ID
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Credit card async transaction binds - empty - without authorization token and all informations
    ${resp} =    Credit Card Async Transaction Binds    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ...    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Credit card async transaction binds - empty - without authorization token
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Credit card async transaction binds - empty - without transactionId
    ${resp} =    Credit Card Async Transaction Binds    ${EMPTY}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionId, should NOT be shorter than 1 characters

Credit card async transaction binds - empty - without transactionType
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${EMPTY}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionType

Credit card async transaction binds - empty - without paySourceAccountId
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${EMPTY}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceAccountId, should NOT be shorter than 1 characters

Credit card async transaction binds - empty - without payTargetAccountId
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${EMPTY}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetAccountId, should NOT be shorter than 1 characters

Credit card async transaction binds - empty - without paySourceType
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${EMPTY}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceType, should be integer

Credit card async transaction binds - empty - without payTargetType
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}     ${pay_source_type}    ${EMPTY}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetType, should be integer

Credit card async transaction binds - empty - without successUrl
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${EMPTY}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.successUrl, should NOT be shorter than 1 characters

Credit card async transaction binds - empty - without failUrl
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${EMPTY}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionData.failUrl, should NOT be shorter than 1 characters

Credit card async transaction binds - invalid - with duplicate transactionId
    ${resp} =    Credit Card Async Transaction Binds    ${duplicate_transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    12001
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    The orderNo is duplicate

Credit card async transaction binds - invalid - with incorrect transactionType: non-exist transactionType
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${incorrect_transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionType

Credit card async transaction binds - invalid - with incorrect paySourceAccountId: non-exist user id
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${incorrect_pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    MemberId invalid, get user data from Go-platform failed, undefined

Credit card async transaction binds - invalid - with incorrect payTargetAccountId
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${incorrect_pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetAccountId, should be equal to one of the allowed values

Credit card async transaction binds - invalid - with incorrect paySourceType
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${incorrect_pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceType, should be equal to one of the allowed values

Credit card async transaction binds - invalid - with incorrect payTargetType
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${incorrect_pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetType, should be equal to one of the allowed values

Credit card async transaction binds - valid - with correct information
    ${resp} =    Credit Card Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${success_url}    ${fail_url}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Success
    Check Bind Card URL Redirect    pg_correct_info    ${resp.json()}    ${resp.status_code}    card_auth_url    gogoro

*** Keywords ***
Init Transaction ID
    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    Set Test Variable    ${transaction_id}

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    Set Suite Variable    ${bind_type}    credit_card
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
    Set Suite Variable    ${success_url}    https://www.gogoro.com
    Set Suite Variable    ${fail_url}    https://www.facebook.com
