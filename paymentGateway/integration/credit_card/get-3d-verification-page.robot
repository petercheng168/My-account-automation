*** Settings ***
Documentation    Test suite of get the 3D verification page from bank
Resource    ../../init.robot

Force Tags    PaymentGateway - CreditCard - Get 3D Verification Page
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Get 3d verification page - empty - without all informations
    ${resp} =    Get 3D Verification Page    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ...    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Get 3d verification page - empty - without authorization token
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${cur}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Get 3d verification page - empty - without layout
    ${resp} =    Get 3D Verification Page    ${EMPTY}    ${order_no}    ${cur}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'layout'

Get 3d verification page - empty - without orderNo
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${EMPTY}    ${cur}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'orderNo'

Get 3d verification page - empty - without cur
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${EMPTY}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'cur'

Get 3d verification page - empty - without amt
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${cur}    ${EMPTY}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'amt'

Get 3d verification page - empty - without postBackUrl
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${cur}    ${amt}    ${EMPTY}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'postBackUrl'

Get 3d verification page - empty - without cardNumber
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${cur}    ${amt}    ${post_back_url}
    ...    ${EMPTY}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'cardNumber'

Get 3d verification page - empty - without expiredDate
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${cur}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${EMPTY}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'expiredDate'

Get 3d verification page - invalid - with incorrect layout
    ${resp} =    Get 3D Verification Page    ${incorrect_layout}    ${order_no}    ${cur}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'layout'

Get 3d verification page - invalid - with incorrect amt
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${cur}    ${incorrect_amt}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Invalid parameters 'amt'

Get 3d verification page - invalid - with incorrect expiredDate
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${cur}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${incorrect_expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -67
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Expired date format error.

Get 3d verification page - valid - with correct information: normal web page
    ${resp} =    Get 3D Verification Page    ${normal_web_page_layout}    ${order_no}    ${cur}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_1
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    1
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Success

Get 3d verification page - valid - with correct information: mobile page
    ${resp} =    Get 3D Verification Page    ${mobile_page_layout}    ${order_no}    ${cur}    ${amt}    ${post_back_url}
    ...    ${card_number}    ${expired_date}    ${auth}
    Verify Schema    credit_card.json    get3DVerificationPage    ${resp.json()}    200_code_1
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    1
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    [Payment-gateway] Success

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    Payment Gateway Test Data Setup    1
    ${es_bill_info} =    Get ES Bill Info
    Set Suite Variable    ${auth}
    Set Suite Variable    ${normal_web_page_layout}    1
    Set Suite Variable    ${mobile_page_layout}    2
    Set Suite Variable    ${incorrect_layout}    3
    Set Suite Variable    ${order_no}    ${es_bill_info['es_bill_id']}
    Set Suite Variable    ${incorrect_order_no}    1
    Set Suite Variable    ${cur}    NTD
    Set Suite Variable    ${amt}    60
    Set Suite Variable    ${incorrect_amt}    -60
    Set Suite Variable    ${post_back_url}    https://www.gogoro.com
    Set Suite Variable    ${card_number}    ${PATMENT_GATEWAY_CREDIT_CARD_NUMBER}
    Set Suite Variable    ${incorrect_card_number}    41476307000403061
    Set Suite Variable    ${expired_date}    ${PATMENT_GATEWAY_CREDIT_CARD_EXPIRED_DATE}
    Set Suite Variable    ${incorrect_expired_date}    0738
    Set Suite Variable    ${cvv2}    ${PATMENT_GATEWAY_CREDIT_CARD_CVV2}
    Set Suite Variable    ${incorrect_cvv2}    1000
