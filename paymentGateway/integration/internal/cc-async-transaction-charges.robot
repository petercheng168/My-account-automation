*** Settings ***
Documentation    Test suite of charges the transaction by the asynchronous method.
Resource    ../../init.robot

Force Tags    PaymentGateway - Internal - Credit Card Async Transaction Charges
Suite Setup    Suite Setup
Test Setup    Init Bill Info
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Credit card async transaction charges - valid - with overcharge amount: amount = 70
    ${resp} =    Async Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${overcharge_amount}    ${success_url}
    ...    ${fail_url}    ${card_number}    ${expired_date}    ${cvv2}    ${auth}
    Verify Schema    internal.json    asyncTransactionCharges    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    [Payment-gateway] Success
    Check 3D Verification URL Redirect    pg_correct_info    ${resp.json()}    ${resp.status_code}    3d_verification_url    交易成功

Credit card async transaction charges - valid - with correct amount: amount = 60
    ${resp} =    Async Transaction Charges    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${amount}    ${success_url}
    ...    ${fail_url}    ${card_number}    ${expired_date}    ${cvv2}    ${auth}
    Verify Schema    internal.json    asyncTransactionCharges    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['resultCode']}    0
    Should Be Equal As Strings    ${resp.json()['resultMessage']}    [Payment-gateway] Success
    Check 3D Verification URL Redirect    pg_correct_info    ${resp.json()}    ${resp.status_code}    3d_verification_url    交易成功

*** Keywords ***
Init Bill Info
    Payment Gateway Test Data Setup    1    5    new_user
    ${es_bill_info} =    Get ES Bill Info
    Set Test Variable    ${transaction_id}    ${es_bill_info['es_bill_id']}

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    Set Suite Variable    ${auth}
    Set Suite Variable    ${transaction_type}    ${100}
    Set Suite Variable    ${incorrect_transaction_type}    ${200}
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
    Set Suite Variable    ${overcharge_amount}    70
    Set Suite Variable    ${success_url}    https://www.gogoro.com
    Set Suite Variable    ${fail_url}    https://www.facebook.com
    Set Suite Variable    ${card_number}    ${PATMENT_GATEWAY_CREDIT_CARD_NUMBER}
    Set Suite Variable    ${expired_date}    ${PATMENT_GATEWAY_CREDIT_CARD_EXPIRED_DATE}
    Set Suite Variable    ${cvv2}    ${PATMENT_GATEWAY_CREDIT_CARD_CVV2}