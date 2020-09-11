*** Settings ***
Documentation    Test suite of Get a page for binding credit card from bank
Resource    ../../init.robot

Force Tags    PaymentGateway - CreditCard - Auth
Suite Setup    Suite Setup
Suite Teardown  Unbinding Credit Card Process    ${auth}
Test Setup    Init Bill Info
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Auth - empty - without authorization token and informations: BankCode, PaymentType, TradeNo, CardToken, Amount, Mode
    ${resp} =    Auth    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Auth - empty - without authorization token
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${trade_no}    ${card_token}    ${amount}    ${normal_mode}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Auth - empty - without Amount
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${trade_no}    ${card_token}    ${EMPTY}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}   Amount is zero

Auth - empty - without BankCode
    ${resp} =    Auth    ${EMPTY}    ${credit_card_payment_type}    ${trade_no}    ${card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    BankCode invalid

Auth - empty - without CardToken
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${trade_no}    ${EMPTY}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    CardToken invalid

Auth - empty - without Mode
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${trade_no}    ${card_token}    ${amount}    ${EMPTY}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}   Mode invalid

Auth - empty - without PaymentType
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${EMPTY}    ${trade_no}    ${card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    PaymentType invalid

Auth - empty - without TradeNo
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${EMPTY}    ${card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    TradeNo invalid

Auth - invalid - with incorrect Amount: Amount=0
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${trade_no}    ${card_token}    ${incorrect_amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    Amount is zero

Auth - invalid - with incorrect BankCode: non-exist BankCode
    ${resp} =    Auth    ${incorrect_bank_code}    ${credit_card_payment_type}    ${trade_no}    ${card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    BankCode invalid

Auth - invalid - with incorrect CardToken: non-exist CardToken
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${trade_no}    ${incorrect_card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    1010
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    請重新操作

Auth - invalid - with incorrect Mode: non-exist Mode
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${trade_no}    ${card_token}    ${amount}    ${incorrect_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    2252
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}   信用卡分期長度異常

Auth - invalid - with incorrect PaymentType: non-exist PaymentType
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${incorrect_payment_type}    ${trade_no}    ${card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    PaymentType invalid

Auth - invalid - with incorrect TradeNo: duplicate ES Bill ID
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${duplicate_trade_no}    ${card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}   訂單編號重複

Auth - invalid - with incorrect TradeNo: non-exist ES Bill ID
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${incorrect_trade_no}    ${card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    Internal Server Error: no bills found

Auth - valid - with correct information
    ${resp} =    Auth    ${PAYMENT_GATEWAY_BANK_CODE}    ${credit_card_payment_type}    ${trade_no}    ${card_token}    ${amount}    ${normal_mode}    ${auth}
    Verify Schema    credit_card.json    auth    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    success

*** Keywords ***
Init Bill Info
    Payment Gateway Test Data Setup    1
    ${es_bill_info} =    Get ES Bill Info
    Set Test Variable    ${trade_no}    2103_${es_bill_info['es_bill_id']}

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    Binding Credit Card Process    ${auth}
    ${member_id} =    Encode Hashid    ${PAYMENT_GATEWAY_MEMBER_ID}
    ${credit_card_list_resp} =    Credit Card List     ${PAYMENT_GATEWAY_BANK_CODE}    ${member_id}    ${auth}
    ${credit_card_payment_type} =    Convert To Integer  1
    ${bamk_account_link_payment_type} =    Convert To Integer  2
    ${incorrect_payment_type} =    Convert To Integer  3
    ${normal_mode} =    Convert To Integer  0
    ${installment_plan_mode} =    Convert To Integer  1
    ${incorrect_mode} =    Convert To Integer  2
    ${amount} =    Convert To Number  60
    ${incorrect_amount} =    Convert To Integer  0
    ${time} =    Get Current Date    result_format=%H%M%S
    ${incorrect_trade_no_postfix} =    Encode Hashid    99${time}
    Set Suite Variable    ${auth}
    Set Suite Variable    ${incorrect_bank_code}    000
    Set Suite Variable    ${credit_card_payment_type}
    Set Suite Variable    ${bamk_account_link_payment_type}
    Set Suite Variable    ${incorrect_payment_type}
    Set Suite Variable    ${card_token}    ${credit_card_list_resp.json()['ResultData'][0]['CardToken']}
    Set Suite Variable    ${incorrect_card_token}    1234abcd-1234-abcd-1234-545c8eb19f33_0457612837465813
    Set Suite Variable    ${amount}
    Set Suite Variable    ${incorrect_amount}
    Set Suite Variable    ${normal_mode}
    Set Suite Variable    ${installment_plan_mode}
    Set Suite Variable    ${incorrect_mode}
    Set Suite Variable    ${duplicate_trade_no}    2103_Z4mkaRPp
    Set Suite Variable    ${incorrect_trade_no}    2103_${incorrect_trade_no_postfix}
