*** Settings ***
Documentation    Test suite of binds the bank account by the asynchronous method
Resource    ../../init.robot

Force Tags    PaymentGateway - Internal - ACH Async Transaction Binds
Suite Setup    Suite Setup
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
ACH async transaction binds - empty - without authorization token and all informations
    ${resp} =    ACH Async Transaction Binds    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

ACH async transaction binds - empty - without authorization token
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

ACH async transaction binds - empty - without transactionId
    ${resp} =    ACH Async Transaction Binds    ${EMPTY}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionId, should NOT be shorter than 1 characters

ACH async transaction binds - empty - without transactionType
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${EMPTY}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionType

ACH async transaction binds - empty - without paySourceAccountId
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${EMPTY}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceAccountIds[0], should NOT be shorter than 1 characters

ACH async transaction binds - empty - without payTargetAccountId
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${EMPTY}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetAccountId, should NOT be shorter than 1 characters

ACH async transaction binds - empty - without paySourceType
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${EMPTY}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid paySourceType, should be integer

ACH async transaction binds - empty - without payTargetType
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${EMPTY}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetType, should be integer

ACH async transaction binds - invalid - with duplicate transactionId
    ${resp} =    ACH Async Transaction Binds    ${duplicate_transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    12001
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    the orderNo is duplicate

ACH async transaction binds - invalid - with incorrect transactionType: non-exist transactionType
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${incorrect_transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid transactionType

# Now has a bug: PMGW-182
ACH async transaction binds - invalid - with incorrect paySourceAccountId: non-exist user id
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${incorrect_pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80002
    Should Be Equal As Strings    ${resp.json()['resultMessage']}     MemberId invalid, get user data from Go-platform failed, undefined

ACH async transaction binds - invalid - with incorrect payTargetAccountId
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${incorrect_pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    Invalid payTargetAccountId, should be equal to one of the allowed values

ACH async transaction binds - invalid - with incorrect paySourceType
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${incorrect_pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}     Invalid paySourceType, should be equal to one of the allowed values

ACH async transaction binds - invalid - with incorrect payTargetType
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${incorrect_pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['resultCode']}    80000
    Should Be Equal As Strings    ${resp.json()['resultMessage']}     Invalid payTargetType, should be equal to one of the allowed values

ACH async transaction binds - valid - with correct information
    ${resp} =    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Verify Schema    internal.json    asyncTransactionBinds    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}     ACH apply success

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    Set Suite Variable    ${auth}
    Set Suite Variable    ${transaction_id}
    Set Suite Variable    ${duplicate_transaction_id}    1000000000
    Set Suite Variable    ${transaction_type}    ${200}
    Set Suite Variable    ${incorrect_transaction_type}    ${201}
    Set Suite Variable    ${incorrect_member_id}    m4wP3AEZ
    Set Suite Variable    ${incorrect_pay_source_account_id}    ${incorrect_member_id}
    Set Suite Variable    ${pay_target_account_id}    1
    Set Suite Variable    ${incorrect_pay_target_account_id}    4
    Set Suite Variable    ${pay_source_type}    ${1}
    Set Suite Variable    ${incorrect_pay_source_type}    ${3}
    Set Suite Variable    ${pay_target_type}    ${2}
    Set Suite Variable    ${incorrect_pay_target_type}    ${3}

Test Setup
    ${account_num} =    Generate Random String    10    [NUMBERS]
    Set Test Variable    ${account_num}
    Payment Gateway Test Data Setup    2    5    new_user
    Add Wallets    ${user_id}    1    9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0    ${0}    TWD    ${auth}
    Add Automated Clearing Houses    ${user_id}    ${User.first_name}    ${account_num}    8120000    ${User.profile_id}A
    ...    ${User.profile_id}    ${transaction_id}    3    ${auth}
    Set Test Variable    ${pay_source_account_id}    ${user_id}